import 'package:flutter/material.dart';
import 'package:sokia_app/controllers/home_controller.dart';
import 'package:sokia_app/controllers/order_controller.dart';
import 'package:sokia_app/data/responses/home_response.dart';
import 'package:sokia_app/helper/Constant.dart';
import 'package:sokia_app/helper/custom_widgets/custom_button.dart';
import 'package:sokia_app/helper/custom_widgets/main_screen.dart';
import 'package:get/get.dart';
import 'package:sokia_app/helper/custom_widgets/text/custom_outline_text_form_field.dart';
import 'package:sokia_app/helper/custom_widgets/text/custom_text.dart';
import 'package:sokia_app/screens/create_order/components/single_item_card.dart';
import 'package:sokia_app/screens/order_completed_screen.dart';

final TextEditingController noteController = TextEditingController();

class CreateOrderScreen extends StatelessWidget {
  final List<Mosque> mosques;
  final orderController = Get.put(OrderController());
  final homeController = Get.find<HomeController>();

  //radio switch value
  final String cash = 'cash'.tr;
  final String visa = 'visa'.tr;

  CreateOrderScreen({@required this.mosques}) {
    if (orderController.orderMap.isEmpty) {
      mosques.forEach((mosque) {
        OrderModel orderModel = OrderModel(
          mosque: mosque,
          category: homeController.categories[0],
          count: 10,
        );
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
            _paymentMethod(),
            _notes(),
            _price(),
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
        noteController.text = '';
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
    Get.to(()=>OrderCompletedScreen());
  }

  _confirmButton() => Container(
        height: 60,
        width: MediaQuery.of(Get.context).size.width,
        child: CustomButton(
          text: 'confirmOrder'.tr,
          colorText: Colors.white,
          fontSize: fontSize18,
          radius: 0,
          colorBackground: kPrimaryColor,
          onPressed: () {
            _confirmOrder();
          },
        ),
      );

  _paymentMethod() => Column(
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.only(
                start: 40, top: 20, bottom: 10),
            child: CustomText(
              text: 'choosePaymentMethod'.tr,
              fontSize: fontSize16,
              color: kPrimaryColor,
            ),
          ),
          GetBuilder<OrderController>(
            builder: (controller) => Padding(
              padding: const EdgeInsetsDirectional.only(start: 20),
              child: Column(
                children: [
                  Row(
                    children: [
                      Radio(
                        //if value and groupValue are the same it will be selected otherwise not selected
                        value: true,
                        activeColor: Colors.amber,
                        groupValue: orderController.cash,
                        onChanged: (value) {
                          orderController.changePaymentMethod(value);
                        },
                      ),
                      Text(cash, style: TextStyle(fontSize: fontSize16)),
                    ],
                  ),
                  Row(
                    children: [
                      Radio(
                        value: false,
                        activeColor: Colors.amber,
                        groupValue: orderController.cash,
                        onChanged: (value) {
                          orderController.changePaymentMethod(value);
                        },
                      ),
                      Text(visa, style: TextStyle(fontSize: fontSize16)),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      );

  _notes() => Padding(
        padding: const EdgeInsets.all(20),
        child: CustomOutlinedTextFormField(
          text: 'note'.tr,
          hintText: 'note'.tr,
          controller: noteController,
          maxLines: 6,
          required: false,
          labelText: 'note'.tr,
          keyboardType: TextInputType.text,
          labelColor: Colors.black,
          hintColor: Colors.black,
          textColor: Colors.black,
        ),
      );

  _price() => GetBuilder<OrderController>(
        builder: (_) => Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadiusDirectional.only(
                  topEnd: Radius.circular(40), topStart: Radius.circular(40)),
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsetsDirectional.only(
                start: 20,
                end: 20,
                top: 20,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        text: 'total'.tr,
                        color: Colors.grey.shade500,
                      ),
                      CustomText(
                        text: orderController
                            .priceWithCurrency(orderController.totalPrice),
                        fontSize: fontSize16,
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.only(top: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          text: 'fee'.tr,
                          color: Colors.grey.shade500,
                        ),
                        CustomText(
                          text: orderController
                              .priceWithCurrency(orderController.fee),
                          fontSize: fontSize16,
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsetsDirectional.only(top: 20, bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          text: 'shipping'.tr,
                          color: Colors.grey.shade500,
                        ),
                        CustomText(
                          text: orderController
                              .priceWithCurrency(orderController.shipping),
                          fontSize: fontSize16,
                        )
                      ],
                    ),
                  ),
                  Divider(
                    color: Colors.grey.shade500,
                  ),
                  Padding(
                    padding:
                        const EdgeInsetsDirectional.only(top: 10, bottom: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          text: 'orderTotalPrice'.tr,
                        ),
                        CustomText(
                          text: orderController.priceWithCurrency(
                              orderController.totalPriceForAllOrders),
                          fontSize: fontSize18,
                          color: kPrimaryColor,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )),
      );
}
