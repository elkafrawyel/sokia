import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sokia_app/controllers/my_orders_controller.dart';
import 'package:sokia_app/helper/custom_widgets/data_state_views/empty_view.dart';
import 'package:sokia_app/helper/custom_widgets/data_state_views/loading_view.dart';
import 'package:sokia_app/helper/local_storage.dart';
import 'package:sokia_app/screens/home/tabs/my_orders_tab/components/order_item.dart';

class OrdersListView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GetBuilder<MyOrdersController>(
        builder: (controller) => LocalStorage().getBool(LocalStorage.loginKey)
            ? controller.loading
                ? LoadingView()
                : controller.empty
                    ? EmptyView()
                    : ListView.builder(
                        primary: false,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          return OrderItem(
                            order: controller.myOrders[index],
                          );
                        },
                        itemCount: controller.myOrders.length,
                      )
            : Container(
                padding: EdgeInsetsDirectional.only(top: 60),
                alignment: AlignmentDirectional.center,
                child: EmptyView(
                  emptyViews: EmptyViews.Magnifier,
                  message: 'loginToSeeOrders'.tr,
                  textColor: Colors.grey.shade700,
                ),
              ),
      ),
    );
  }
}
