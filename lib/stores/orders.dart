import 'package:mobx/mobx.dart';
import 'package:myshop_mobx/locator.dart';
import 'package:myshop_mobx/models/cart_model.dart';
import 'package:myshop_mobx/models/order_model.dart';
import 'package:myshop_mobx/services/order_service.dart';

part 'orders.g.dart';

class Orders = _Orders with _$Orders;

abstract class _Orders with Store {
  final orderService = locator<OrderService>();

  ObservableList<OrderModel> orders = ObservableList();

  @action
  Future<void> fetchAndSetOrders() async {
    orders = ObservableList();
    final extractedData = await orderService.fetch();
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

  Future<void> addOrder(List<CartModel> cartProducts, double total) async {
    final result = await orderService.add(cartProducts, total);
    print(result);
  }
}
