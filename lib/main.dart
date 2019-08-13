import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:myshop_mobx/locator.dart';
import 'package:myshop_mobx/screens/auth_screen.dart';
import 'package:myshop_mobx/screens/cart_screen.dart';
import 'package:myshop_mobx/screens/edit_product_screen.dart';
import 'package:myshop_mobx/screens/order_screen.dart';
import 'package:myshop_mobx/screens/product_detail_screen.dart';
import 'package:myshop_mobx/screens/products_overview_screen.dart';
import 'package:myshop_mobx/screens/splash_screen.dart';
import 'package:myshop_mobx/screens/user_products_screen.dart';
import 'package:myshop_mobx/store/auth.dart';
import 'package:myshop_mobx/store/carts.dart';
import 'package:myshop_mobx/store/orders.dart';
import 'package:myshop_mobx/store/products.dart';
import 'package:provider/provider.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(builder: (_) => Auth()),
        Provider(builder: (_) => Products()),
        Provider(builder: (_) => Carts()),
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
              OrderScreen.routeName: (ctx) => OrderScreen(),
              UserProductsScreen.routeName: (ctx) => UserProductsScreen(),
              EditProductScreen.routeName: (ctx) => EditProductScreen(),
            },
          );
        },
      ),
    );
  }
}
