import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:myshop_mobx/models/cart_model.dart';

class OrderService {
  String _authToken;
  String _userId;

  void setTokenAndUserId(String token, String userId) {
    _authToken = token;
    _userId = userId;
  }

  Future<Map<String, dynamic>> fetch() async {
    final url =
        'https://flutter-update-396ab.firebaseio.com/orders/$_userId.json?auth=$_authToken';
    final response = await http.get(url);
    return jsonDecode(response.body) as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> add(
      List<CartModel> cartProducts, double total) async {
    final url =
        'https://flutter-update-396ab.firebaseio.com/orders/$_userId.json?auth=$_authToken';
    final timestamp = DateTime.now();
    final response = await http.post(url,
        body: json.encode({
          'amount': total,
          'dateTime': timestamp.toIso8601String(),
          'products': cartProducts
              .map((cp) => {
                    'id': cp.id,
                    'title': cp.title,
                    'quantity': cp.quantity,
                    'price': cp.price,
                  })
              .toList(),
        }));
    return jsonDecode(response.body);
  }
}
