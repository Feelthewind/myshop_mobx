import 'package:mobx/mobx.dart';
import 'package:myshop_mobx/models/cart_model.dart';

part 'carts.g.dart';

class Carts = _Carts with _$Carts;

abstract class _Carts with Store {
  @observable
  ObservableMap<String, CartModel> items = ObservableMap();

  @computed
  int get itemCount => items.length;

  @computed
  double get totalAmount {
    var total = 0.0;
    items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  void addItem(String productId, double price, String title) {
    if (items.containsKey(productId)) {
      items.update(
        productId,
        (existingCartItem) => CartModel(
          id: existingCartItem.id,
          title: existingCartItem.title,
          price: existingCartItem.price,
          quantity: existingCartItem.quantity + 1,
        ),
      );
    } else {
      items.putIfAbsent(
        productId,
        () => CartModel(
          id: DateTime.now().toString(),
          title: title,
          price: price,
          quantity: 1,
        ),
      );
    }
  }

  void clear() {
    items = ObservableMap();
  }
}
