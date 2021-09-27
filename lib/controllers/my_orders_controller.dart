import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sokia_app/api/api_service.dart';
import 'package:sokia_app/data/responses/my_orders_response.dart';
import 'package:sokia_app/helper/custom_widgets/data_state_views/network_view.dart';
import 'package:sokia_app/helper/data_states.dart';
import 'package:sokia_app/helper/local_storage.dart';

class MyOrdersController extends GetxController {
  List<Order> myOrders = [];

  bool loading = false;
  bool error = false;
  bool empty = false;

  @override
  void onInit() {
    super.onInit();
    _getMyOrders();
  }

  _getMyOrders() {
    if (LocalStorage().getBool(LocalStorage.loginKey)) {
      loading = true;
      update();
      ApiService().getMyOrders(
        state: (dataState) {
          if (dataState is SuccessState) {
            myOrders.clear();
            myOrders.addAll(dataState.data as List<Order>);

            loading = false;
            empty = myOrders.isEmpty;
            update();
          } else if (dataState is ErrorState) {
            loading = false;
            error = true;
            update();
          } else if (dataState is NoConnectionState) {
            loading = false;
            update();
            // CommonMethods().goOffline();
            showDialog(
              context: Get.context,
              barrierDismissible: false,
              builder: (ctx) => Dialog(
                backgroundColor: Colors.black87,
                insetPadding: EdgeInsets.all(10),
                child: NetworkView(
                  onPress: () {
                    Get.back();
                    _getMyOrders();
                  },
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            );
          }
        },
      );
    }
  }
}
