import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_max_flutter/providers/orders.dart' show Orders;
import 'package:shop_app_max_flutter/widgets/app_drawer.dart';
import 'package:shop_app_max_flutter/widgets/order_item.dart';

class OrdersScreen extends StatelessWidget {

  static const routeName = '/orders';

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      drawer: AppDrawer(),
      body:orderData.order.isEmpty ?Center(child: Text('You did not Add order Yet'),) : ListView.builder(
          itemCount: orderData.order.length,
          itemBuilder: (ctx, i) => OrderItem(orderData.order[i])),
    );
  }
}
