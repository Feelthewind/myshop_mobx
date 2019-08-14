import 'package:mobx/mobx.dart';
import 'package:myshop_mobx/models/cart_model.dart';

part 'cart.g.dart';

class Cart = _Cart with _$Cart;

abstract class _Cart with Store {
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

  @action
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

  @action
  void clear() {
    items = ObservableMap();
  }
}
