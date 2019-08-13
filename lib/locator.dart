import 'package:get_it/get_it.dart';
import 'package:myshop_mobx/services/order_service.dart';
import 'package:myshop_mobx/services/product_service.dart';

GetIt locator = GetIt();

void setupLocator() {
  locator.registerLazySingleton(() => ProductService());
  locator.registerLazySingleton(() => OrderService());
}
