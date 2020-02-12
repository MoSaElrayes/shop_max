import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/orders.dart' show Orders;
import '../widgets/order_item.dart';
import '../widgets/app_drawer.dart';

class OrdersScreen extends StatelessWidget{
//  void initState() {
//    Future.delayed(Duration.zero).then((_) async {
//      setState(() {
//        _isLoading = true;
//      });
//      await Provider.of<Orders>(context, listen: false).fetchAndSetOrders();
//      setState(() {
//        _isLoading = false;
//      });
//    });
//    super.initState();
//  }
  static const routeName = '/orders';
  @override
  Widget build(BuildContext context) {
    print('building');
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      drawer: AppDrawer(),
      body: FutureBuilder(
        future: Provider.of<Orders>(context, listen: false).fetchAndSetOrders(),
        builder:
            (ctx ,dataSnapshot ) {
          if (dataSnapshot.connectionState == ConnectionState.waiting)
          {
            print('wait');
            return Center(child: CircularProgressIndicator());
          } else
            {
              if (dataSnapshot.error != null) {
                return Center(child: Text('Erorrrrr'),);
              } else
                {
                  return Consumer<Orders>(builder: (ctx , orders , child)=>
                    ListView.builder(
                      itemCount: orders.orders.length,
                      itemBuilder: (ctx, i) => OrderItem(orders.orders[i]),
                    ),
                  );

              }
          }
        }
      )

    );
  }
}
