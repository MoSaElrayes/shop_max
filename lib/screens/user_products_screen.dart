import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_max_flutter/providers/products_provider.dart';
import 'package:shop_app_max_flutter/widgets/app_drawer.dart';
import 'package:shop_app_max_flutter/widgets/user_product_item.dart';
import 'edit_product_screen.dart';

class UserProductsScreen extends StatelessWidget {

  static const String routeName = "/userProducts";

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<ProductsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Products'),
        actions: <Widget>
        [
          IconButton(
              icon: Icon(Icons.add),
              onPressed: ()
              {
                Navigator.of(context).pushNamed(EditProductScreen.routeName);
              },
          )
        ],
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: productData.items.length,
          itemBuilder: (_, i) => Column(
            children: <Widget>
            [
              UserProductItem(
                id: productData.items[i].id,
                imageUrl: productData.items[i].imageUrl,
                title: productData.items[i].title,
              ),
              Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
