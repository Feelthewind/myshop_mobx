import 'package:mobx/mobx.dart';
import 'package:myshop_mobx/locator.dart';
import 'package:myshop_mobx/services/products.dart';

part 'product.g.dart';

class Product = _Product with _$Product;

abstract class _Product with Store {
  final service = locator<ProductsService>();

  _Product({
    this.id,
    this.title,
    this.description,
    this.price,
    this.imageUrl,
    this.isFavorite = false,
  });

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
      await service.toggleFavoriteStatus(id, isFavorite);
    } catch (error) {
      isFavorite = oldStatus;
      throw error;
    }
  }
}
