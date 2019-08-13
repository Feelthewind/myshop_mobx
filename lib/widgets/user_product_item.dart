import 'package:flutter/material.dart';
import 'package:myshop_mobx/screens/edit_product_screen.dart';
import 'package:myshop_mobx/store/product.dart';

class UserProductItem extends StatelessWidget {
  final Product product;

  UserProductItem(this.product);

  @override
  Widget build(BuildContext context) {
    // final scaffold = Scaffold.of(context);
    return ListTile(
      title: Text(product.title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(product.imageUrl),
      ),
      trailing: Container(
        width: 100,
        child: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                Navigator.of(context).pushNamed(
                  EditProductScreen.routeName,
                  arguments: product,
                );
              },
              color: Theme.of(context).primaryColor,
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () async {
                // try {
                //   await Provider.of<Products>(context, listen: false)
                //       .deleteProduct(id);
                // } catch (error) {
                //   scaffold.showSnackBar(
                //     SnackBar(
                //       content: Text(
                //         'Deleting failed!',
                //         textAlign: TextAlign.center,
                //       ),
                //     ),
                //   );
                // }
              },
              color: Theme.of(context).errorColor,
            ),
          ],
        ),
      ),
    );
  }
}
