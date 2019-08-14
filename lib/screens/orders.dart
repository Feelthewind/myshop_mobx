import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:myshop_mobx/stores/orders.dart';
import 'package:myshop_mobx/widgets/app_drawer.dart';
import 'package:provider/provider.dart';

import '../widgets/order_item.dart';

class OrdersScreen extends StatefulWidget {
  static const routeName = '/orders';

  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  @override
  Widget build(BuildContext context) {
    final ordersStore = Provider.of<Orders>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      drawer: AppDrawer(),
      body: FutureBuilder(
        future: Provider.of<Orders>(context, listen: false).fetchAndSetOrders(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.error != null) {
            // ...
            // Do error handling stuff
            return Center(
              child: Text('An error occurred!'),
            );
          } else {
            return Observer(
              builder: (ctx) => ListView.builder(
                itemCount: ordersStore.orders.length,
                itemBuilder: (ctx, i) => OrderItem(ordersStore.orders[i]),
              ),
            );
          }
        },
      ),
    );
  }
}
