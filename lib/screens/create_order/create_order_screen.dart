import 'package:flutter/material.dart';
import 'package:sokia_app/controllers/home_controller.dart';
import 'package:sokia_app/controllers/order_controller.dart';
import 'package:sokia_app/data/responses/home_response.dart';
import 'package:sokia_app/helper/Constant.dart';
import 'package:sokia_app/helper/custom_widgets/custom_button.dart';
import 'package:sokia_app/helper/custom_widgets/main_screen.dart';
import 'package:get/get.dart';
import 'package:sokia_app/screens/create_order/components/single_item_card.dart';

class CreateOrderScreen extends StatelessWidget {
  final List<Mosque> mosques;
  final orderController = Get.put(OrderController());
  final homeController = Get.find<HomeController>();

  CreateOrderScreen({@required this.mosques}) {
    if (orderController.orderMap.isEmpty) {
      mosques.forEach((mosque) {
        OrderModel orderModel = OrderModel(
            mosque: mosque,
            category: homeController.categories[0],
            count: 10,
            workerName: null,
            workerNumber: null);
        orderController.addToOrderMap(orderModel: orderModel);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MainScreen(
      title: 'createOrder'.tr,
      pageBackground: kBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildMosqueCards(),
            _confirmButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildMosqueCards() {
    return GetBuilder<OrderController>(
      dispose: (state) {
        orderController.orderMap.clear();
      },
      builder: (controller) => Column(
        children: controller.orderMap.values.map((order) {
          return SingleItemCard(
            orderModel: order,
          );
        }).toList(),
      ),
    );
  }

  void _confirmOrder() {
    print(orderController.orderMap.toString());
  }

  _confirmButton() => Padding(
        padding: EdgeInsets.all(20),
        child: Container(
          height: 50,
          width: MediaQuery.of(Get.context).size.width / 2,
          child: CustomButton(
            text: 'confirm'.tr,
            colorText: Colors.white,
            colorBackground: kPrimaryColor,
            onPressed: () {
              _confirmOrder();
            },
          ),
        ),
      );
}
