import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:myshop_mobx/stores/products.dart';
import 'package:myshop_mobx/widgets/product_item.dart';
import 'package:provider/provider.dart';

class ProductsGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final list = Provider.of<Products>(context);

    return Observer(builder: (_) {
      print('gridview builder');
      if (!list.hasResults) {
        return Center(child: CircularProgressIndicator());
      }
      if (list.products.isEmpty) {
        return const Text('We could not find any products');
      }
      return GridView.builder(
        padding: const EdgeInsets.all(10.0),
        itemCount: list.products.length,
        itemBuilder: (context, index) {
          final product = list.products[index];
          return ProductItem(product);
        },
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
      );
    });
  }
}
