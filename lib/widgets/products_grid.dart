import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/products_provider.dart';
import 'product_item.dart';

class ProductsGrid extends StatelessWidget {
  final bool  showFavs;


  ProductsGrid(this.showFavs);

  @override
  Widget build(BuildContext context) {
    final productsProviderData = Provider.of<ProductsProvider>(context);
    final products =showFavs ? productsProviderData.favoriteItems : productsProviderData.items;

    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: products.length,
      itemBuilder: (ctx, index) => ChangeNotifierProvider.value(
        value: products[index],
//          create: (c)=>productsProviderData[index],
        child: ProductItem(
//            id: productsProviderData.items[index].id,
//            title: productsProviderData.items[index].title,
//            imageUrl: productsProviderData.items[index].imageUrl,
            ),
      ),
    );
  }
}
