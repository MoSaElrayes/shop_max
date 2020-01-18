import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './providers/orders.dart';
import './screens/edit_product_screen.dart';
import './screens/orders_screen.dart';
import './screens/user_products_screen.dart';
import './providers/cart.dart';
import './screens/cart_screen.dart';
import './screens/product_detail_screen.dart';
import './screens/products_overview_screen.dart';
import 'providers/products_provider.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
    return MultiProvider(providers:
    [
        ChangeNotifierProvider.value(value: ProductsProvider(),),
        ChangeNotifierProvider.value(value: Cart(),),
        ChangeNotifierProvider.value(value: Orders(),),
    ],

//      create:(ctx)=> ProductsProvider(),
      child: MaterialApp(
        theme: ThemeData(
          primaryColor: Colors.purple ,
          accentColor: Colors.deepOrange ,
          fontFamily: 'Lato',
        ),
        home: ProductsOverviewScreen(),
        routes: {
          ProductDetailScreen.routName : (ctx)=> ProductDetailScreen(),
          CartScreen.routeName : (ctx)=> CartScreen(),
          OrdersScreen.routeName : (ctx)=> OrdersScreen(),
          UserProductsScreen.routeName : (ctx)=> UserProductsScreen(),
          EditProductScreen.routeName : (ctx)=> EditProductScreen(),
        },
      ),
    );
  }
}


