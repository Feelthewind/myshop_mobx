import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:myshop_mobx/store/product.dart';

class ProductService {
  var url = 'https://flutter-update-396ab.firebaseio.com/products.json';

  String _authToken;
  String _userId;

  void setTokenAndUserId(String token, String userId) {
    _authToken = token;
    _userId = userId;
  }

  Future<List<Product>> fetch([bool filterByUser = false]) async {
    final filterString =
        filterByUser ? 'orderBy="creatorId"&equalTo="$_userId"' : '';
    var url =
        'https://flutter-update-396ab.firebaseio.com/products.json?auth=$_authToken&$filterString';
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<Product> loadedProducts = [];
      if (extractedData == null) {
        return [];
      }
      url =
          'https://flutter-update-396ab.firebaseio.com/userFavorites/$_userId.json?auth=$_authToken';
      final favoriteResponse = await http.get(url);
      final favoriteData = json.decode(favoriteResponse.body);
      extractedData.forEach((prodId, prodData) {
        loadedProducts.add(Product(
          id: prodId,
          title: prodData['title'],
          description: prodData['description'],
          price: prodData['price'],
          isFavorite:
              favoriteData == null ? false : favoriteData[prodId] ?? false,
          imageUrl: prodData['imageUrl'],
        ));
      });
      return loadedProducts;
    } catch (error) {
      throw error;
    }
  }

  Future<void> toggleFavoriteStatus(String productId, bool isFavorite) async {
    final url =
        'https://flutter-update-396ab.firebaseio.com/userFavorites/$_userId/$productId.json?auth=$_authToken';
    try {
      await http.put(
        url,
        body: json.encode(isFavorite),
      );
    } catch (error) {
      throw error;
    }
  }

  Future<Map<String, dynamic>> add(Product product) async {
    final url =
        'https://flutter-update-396ab.firebaseio.com/products.json?auth=$_authToken';
    try {
      final response = await http.post(url,
          body: json.encode(
            {
              'title': product.title,
              'description': product.description,
              'imageUrl': product.imageUrl,
              'price': product.price,
              'creatorId': _userId,
            },
          ));
      return jsonDecode(response.body);
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> update(String id, Product newProduct) async {
    final url =
        'https://flutter-update-396ab.firebaseio.com/products/$id.json?auth=$_authToken';
    await http.patch(url,
        body: json.encode({
          'title': newProduct.title,
          'description': newProduct.description,
          'imageUrl': newProduct.imageUrl,
          'price': newProduct.price,
        }));
  }
}
