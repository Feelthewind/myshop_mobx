import 'package:get_it/get_it.dart';
import 'package:myshop_mobx/services/order.dart';
import 'package:myshop_mobx/services/product.dart';

GetIt locator = GetIt();

void setupLocator() {
  locator.registerLazySingleton(() => ProductService());
  locator.registerLazySingleton(() => OrderService());
}
