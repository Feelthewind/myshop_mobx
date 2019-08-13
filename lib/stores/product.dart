import 'package:mobx/mobx.dart';
import 'package:myshop_mobx/locator.dart';
import 'package:myshop_mobx/services/product.dart';

part 'product.g.dart';

class Product = _Product with _$Product;

abstract class _Product with Store {
  _Product({
    this.id,
    this.title,
    this.description,
    this.price,
    this.imageUrl,
    this.isFavorite = false,
  });

  final ProductService api = locator<ProductService>();

  @observable
  String id;

  @observable
  String title;

  @observable
  String description;

  @observable
  double price;

  @observable
  String imageUrl;

  @observable
  bool isFavorite;

  @action
  Future<void> toggleFavoriteStatus() async {
    final oldStatus = isFavorite;
    try {
      isFavorite = !isFavorite;
      await api.toggleFavoriteStatus(id, isFavorite);
    } catch (error) {
      isFavorite = oldStatus;
      throw error;
    }
  }

  // _Product.fromJson(Map<String, dynamic> json) {
  //   id = json['id'];
  //   title = json['title'];
  //   description = json['description'];
  //   price = json['price'];
  //   imageUrl = json['imageUrl'];
  //   isFavorite = json['isFavorite'];
  // }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['id'] = this.id;
  //   data['title'] = this.title;
  //   data['description'] = this.description;
  //   data['price'] = this.price;
  //   data['imageUrl'] = this.imageUrl;
  //   data['isFavorite'] = this.isFavorite;
  //   return data;
  // }
}
