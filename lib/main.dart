import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:myshop_mobx/locator.dart';
import 'package:myshop_mobx/screens/auth.dart';
import 'package:myshop_mobx/screens/cart.dart';
import 'package:myshop_mobx/screens/edit_product.dart';
import 'package:myshop_mobx/screens/orders.dart';
import 'package:myshop_mobx/screens/product_detail.dart';
import 'package:myshop_mobx/screens/products_overview.dart';
import 'package:myshop_mobx/screens/splash.dart';
import 'package:myshop_mobx/screens/user_products.dart';
import 'package:myshop_mobx/stores/auth.dart';
import 'package:myshop_mobx/stores/cart.dart';
import 'package:myshop_mobx/stores/orders.dart';
import 'package:myshop_mobx/stores/products.dart';
import 'package:provider/provider.dart';

void main() {
  // Provider.debugCheckInvalidValueType = null;
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: Auth()),
        ProxyProvider<Auth, Cart>(
          builder: (ctx, auth, previousCart) {
            return Cart();
          },
        ),
        Provider(builder: (_) => Products()),
        Provider(builder: (_) => Orders()),
      ],
      child: Observer(
        builder: (ctx) {
          final auth = Provider.of<Auth>(ctx);
          return MaterialApp(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.blue,
              accentColor: Colors.deepOrange,
              fontFamily: 'Lato',
            ),
            home: auth.isAuth
                ? ProductsOverviewScreen()
                : FutureBuilder(
                    future: auth.tryAutoLogin(),
                    builder: (ctx, snapshot) =>
                        snapshot.connectionState == ConnectionState.waiting
                            ? SplashScreen()
                            : AuthScreen(),
                  ),
            routes: {
              ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
              CartScreen.routeName: (ctx) => CartScreen(),
              OrdersScreen.routeName: (ctx) => OrdersScreen(),
              UserProductsScreen.routeName: (ctx) => UserProductsScreen(),
              EditProductScreen.routeName: (ctx) => EditProductScreen(),
            },
          );
        },
      ),
    );
  }
}
