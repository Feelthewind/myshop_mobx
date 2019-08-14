import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:myshop_mobx/screens/cart.dart';
import 'package:myshop_mobx/stores/cart.dart';
import 'package:myshop_mobx/stores/products.dart';
import 'package:myshop_mobx/widgets/app_drawer.dart';
import 'package:myshop_mobx/widgets/badge.dart';
import 'package:myshop_mobx/widgets/products_grid.dart';
import 'package:provider/provider.dart';

class ProductsOverviewScreen extends StatefulWidget {
  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  @override
  void initState() {
    super.initState();
    final productsStore = Provider.of<Products>(context, listen: false);
    productsStore.fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MyShop'),
        actions: <Widget>[
          Observer(
            builder: (ctx) {
              final cart = Provider.of<Cart>(ctx, listen: false);
              return Badge(
                child: IconButton(
                  icon: Icon(
                    Icons.shopping_cart,
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed(CartScreen.routeName);
                  },
                ),
                value: cart.itemCount.toString(),
              );
            },
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: ProductsGrid(),
    );
  }
}
