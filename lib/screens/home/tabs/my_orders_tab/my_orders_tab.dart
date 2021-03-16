import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sokia_app/helper/Constant.dart';
import 'package:sokia_app/screens/home/tabs/my_orders_tab/components/orders_list.dart';

class MyOrdersTab extends StatefulWidget {
  @override
  _MyOrdersTabState createState() => _MyOrdersTabState();
}

class _MyOrdersTabState extends State<MyOrdersTab>
    with AutomaticKeepAliveClientMixin {
  final List<String> data = [
    'A',
    'A',
    'A',
    'A',
    'A',
    'A',
    'A',
    'A',
    'A',
    'A',
    'A',
    'A',
  ];

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text(
              'myOrders'.tr,
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  .copyWith(color: Colors.white),
            ),
            centerTitle: true,
            backgroundColor: kPrimaryColor,
            floating: true,
          ),
          SliverToBoxAdapter(
            child: OrdersListView(
              data: data,
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
