import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/orders.dart' show Orders ;
import '../widgets/order_item.dart';
import '../widgets/app_drawer.dart';

class OrderScreen extends StatelessWidget {
  static const routeName = '/order_screen';

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('your orders'),
        ),
        drawer: AppDrawer(),
        body: ListView.builder(
            itemCount: orderData.orders.length,
           itemBuilder: (ctx ,i)=> OrderItem (orderData.orders[i]),
        ),
    );
  }
}