import 'package:mobx/mobx.dart';
import 'package:myshop_mobx/locator.dart';
import 'package:myshop_mobx/models/cart_model.dart';
import 'package:myshop_mobx/models/order_model.dart';
import 'package:myshop_mobx/services/orders.dart';

part 'orders.g.dart';

class Orders = _Orders with _$Orders;

abstract class _Orders with Store {
  final service = locator<OrdersService>();

  ObservableList<OrderModel> orders = ObservableList();

  @action
  Future<void> fetchAndSetOrders() async {
    orders = ObservableList();
    final extractedData = await service.fetch();
    if (extractedData == null) {
      return;
    }
    extractedData.forEach((orderId, orderData) {
      orders.add(
        OrderModel(
          id: orderId,
          amount: orderData['amount'],
          dateTime: DateTime.parse(orderData['dateTime']),
          products: (orderData['products'] as List<dynamic>)
              .map((item) => CartModel.fromJson(item))
              .toList(),
        ),
      );
    });
    orders = ObservableList.of(orders.reversed);
  }

  @action
  Future<void> addOrder(List<CartModel> cartProducts, double total) async {
    final timestamp = DateTime.now();
    final result = await service.add(cartProducts, total);
    orders.insert(
      0,
      OrderModel(
        id: result['name'],
        amount: total,
        dateTime: timestamp,
        products: cartProducts,
      ),
    );
  }
}
