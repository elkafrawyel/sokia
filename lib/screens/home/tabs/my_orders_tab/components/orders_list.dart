import 'package:flutter/material.dart';
import 'package:sokia_app/screens/home/tabs/my_orders_tab/components/order_item.dart';

class OrdersListView extends StatelessWidget {
  final List<String> data;

  OrdersListView({this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        primary: false,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return OrderItem();
        },
        itemCount: data.length,
      ),
    );
  }
}
