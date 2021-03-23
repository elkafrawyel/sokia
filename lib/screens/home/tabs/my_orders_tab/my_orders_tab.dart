import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sokia_app/controllers/my_orders_controller.dart';
import 'package:sokia_app/helper/Constant.dart';
import 'package:sokia_app/screens/home/tabs/my_orders_tab/components/orders_list.dart';

class MyOrdersTab extends StatefulWidget {
  final _myOrdersController = Get.put(MyOrdersController());

  MyOrdersTab() {
    _myOrdersController.onInit();
  }

  @override
  _MyOrdersTabState createState() => _MyOrdersTabState();
}

class _MyOrdersTabState extends State<MyOrdersTab>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: RefreshIndicator(
        onRefresh: () {
          widget._myOrdersController.onInit();
          return Future.value();
        },
        child: CustomScrollView(
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
              child: OrdersListView(),
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
