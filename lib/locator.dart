import 'package:get_it/get_it.dart';
import 'package:myshop_mobx/services/orders.dart';
import 'package:myshop_mobx/services/products.dart';

GetIt locator = GetIt();

void setupLocator() {
  locator.registerLazySingleton(() => ProductsService());
  locator.registerLazySingleton(() => OrdersService());
}

void setServices(String token, String userId) {
  final products = locator<ProductsService>();
  final order = locator<OrdersService>();
  products.setAuthData(token, userId);
  order.setAuthData(token, userId);
}
