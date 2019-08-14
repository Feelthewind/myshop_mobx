import 'package:flutter/foundation.dart';

class CartModel {
  final String id;
  final String title;
  final int quantity;
  final double price;

  CartModel({
    @required this.id,
    @required this.title,
    @required this.quantity,
    @required this.price,
  });

  factory CartModel.fromJson(Map<String, dynamic> parsedJson) {
    return CartModel(
      id: parsedJson['id'],
      title: parsedJson['title'],
      quantity: parsedJson['quantity'],
      price: parsedJson['price'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'quantity': quantity,
      'price': price,
    };
  }
}
