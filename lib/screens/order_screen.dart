import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:myshop_mobx/store/orders.dart';
import 'package:myshop_mobx/widgets/app_drawer.dart';
import 'package:provider/provider.dart';

import '../widgets/order_item.dart' as oi;

class OrderScreen extends StatefulWidget {
  static const routeName = '/orders';

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  Widget build(BuildContext context) {
    final store = Provider.of<Orders>(context);
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
                itemCount: store.orders.length,
                itemBuilder: (ctx, i) => oi.OrderItem(store.orders[i]),
              ),
            );
          }
        },
      ),
    );
  }
}
