import 'dart:async';
import 'dart:convert';

import 'package:mobx/mobx.dart';
import 'package:myshop_mobx/services/auth_service.dart';
import 'package:myshop_mobx/services/order_service.dart';
import 'package:myshop_mobx/services/product_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../locator.dart';

part 'auth.g.dart';

class Auth = _Auth with _$Auth;

abstract class _Auth with Store {
  Timer _authTimer;

  @observable
  String token;

  @observable
  DateTime expiryDate;

  @observable
  String userId;

  @computed
  bool get isAuth {
    if (expiryDate != null &&
        expiryDate.isAfter(DateTime.now()) &&
        token != null) {
      return true;
    } else {
      return false;
    }
  }

  @action
  Future<void> signup(String email, String password) async {
    try {
      final result =
          await AuthService().authenticate(email, password, 'signupNewUser');
      _setStore(result);
      _setServices(token, userId);
      _saveUserDataToPreferences();
    } catch (error) {
      throw error;
    }
  }

  @action
  Future<void> login(String email, String password) async {
    try {
      final result =
          await AuthService().authenticate(email, password, 'verifyPassword');
      _setStore(result);
      _setServices(token, userId);
      await _saveUserDataToPreferences();
    } catch (error) {
      throw error;
    }
  }

  @action
  Future<void> logout() async {
    token = null;
    userId = null;
    expiryDate = null;
    if (_authTimer != null) {
      _authTimer.cancel();
      _authTimer = null;
    }
    final prefs = await SharedPreferences.getInstance();
    // prefs.remove('userData');
    prefs.clear();
  }

  void _setStore(Map<String, dynamic> result) {
    token = result['idToken'];
    userId = result['localId'];

    expiryDate = DateTime.now().add(
      Duration(seconds: int.parse(result['expiresIn'])),
    );
  }

  void _saveUserDataToPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final userData = json.encode(
      {
        'token': token,
        'userId': userId,
        'expiryDate': expiryDate.toIso8601String(),
      },
    );
    prefs.setString('userData', userData);
  }

  @action
  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return false;
    }
    final extractedUserData =
        json.decode(prefs.getString('userData')) as Map<String, Object>;
    final _expiryDate = DateTime.parse(extractedUserData['expiryDate']);

    if (_expiryDate.isBefore(DateTime.now())) {
      return false;
    }
    token = extractedUserData['token'];
    userId = extractedUserData['userId'];
    expiryDate = _expiryDate;

    _setServices(token, userId);

    return true;
  }

  void _setServices(String token, String userId) {
    final products = locator<ProductService>();
    final order = locator<OrderService>();
    products.setTokenAndUserId(token, userId);
    order.setTokenAndUserId(token, userId);
  }
}
