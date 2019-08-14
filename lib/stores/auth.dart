import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:myshop_mobx/services/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../locator.dart';

part 'auth.g.dart';

class Auth = _Auth with _$Auth;

abstract class _Auth with Store, ChangeNotifier {
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
      setServices(token, userId);
      _autoLogout();
      notifyListeners();
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
      setServices(token, userId);
      _autoLogout();
      notifyListeners();
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
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    // prefs.remove('userData');
    prefs.clear();
  }

  @action
  void _setStore(Map<String, dynamic> result) {
    token = result['idToken'];
    userId = result['localId'];

    expiryDate = DateTime.now().add(
      Duration(seconds: int.parse(result['expiresIn'])),
    );
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

    setServices(token, userId);
    notifyListeners();
    _autoLogout();
    return true;
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

  void _autoLogout() {
    if (_authTimer != null) {
      _authTimer.cancel();
    }
    final timeToExpiry = expiryDate.difference(DateTime.now()).inSeconds;
    _authTimer = Timer(Duration(seconds: timeToExpiry), logout);
  }
}
