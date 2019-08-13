import 'package:mobx/mobx.dart';
import 'package:myshop_mobx/locator.dart';
import 'package:myshop_mobx/services/product_service.dart';
import 'package:myshop_mobx/stores/product.dart';

part 'products.g.dart';

class Products = _Products with _$Products;

abstract class _Products with Store {
  final productService = locator<ProductService>();
  // @observable
  // ObservableList<Product> products = ObservableList<Product>.of([
  //   Product(
  //     id: 'p1',
  //     title: 'Red Shirt',
  //     description: 'A red shirt - it is pretty red!',
  //     price: 29.99,
  //     imageUrl:
  //         'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
  //   ),
  // ]);

  @observable
  ObservableList<Product> products = ObservableList<Product>();

  @observable
  ObservableFuture<List<Product>> fetchProductsFuture = emptyResponse;

  static ObservableFuture<List<Product>> emptyResponse =
      ObservableFuture.value([]);

  @computed
  ObservableList<Product> get favoriteProducts =>
      ObservableList.of(products.where((p) => p.isFavorite == true));

  @computed
  bool get hasResults =>
      fetchProductsFuture != emptyResponse &&
      fetchProductsFuture.status == FutureStatus.fulfilled;

  @action
  Future<void> fetchProducts([bool filterByUser = false]) async {
    try {
      final future = productService.fetch(filterByUser);
      fetchProductsFuture = ObservableFuture(future);

      final result = await future;

      if (result == null) {
        return;
      }

      products = ObservableList.of(result);
    } catch (error) {
      throw error;
    }
  }

  @action
  Future<void> addProduct(Product product) async {
    try {
      final result = await productService.add(product);
      final newProduct = Product(
        id: result['name'],
        title: product.title,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl,
      );
      products.add(newProduct);
    } catch (error) {
      throw error;
    }
  }

  @action
  Future<void> updateProduct(String id, Product newProduct) async {
    final prodIndex = products.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      await productService.update(id, newProduct);
      products[prodIndex] = newProduct;
    }
  }
}
