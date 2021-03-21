import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sokia_app/api/api_service.dart';
import 'package:sokia_app/api/logging_interceptor.dart';
import 'package:sokia_app/controllers/home_controller.dart';
import 'package:sokia_app/controllers/order_controller.dart';
import 'package:sokia_app/data/responses/home_response.dart';
import 'package:sokia_app/helper/CommonMethods.dart';
import 'package:sokia_app/helper/Constant.dart';
import 'package:sokia_app/helper/custom_widgets/custom_button.dart';
import 'package:sokia_app/helper/custom_widgets/main_screen.dart';
import 'package:get/get.dart';
import 'package:sokia_app/helper/custom_widgets/text/custom_outline_text_form_field.dart';
import 'package:sokia_app/helper/custom_widgets/text/custom_text.dart';
import 'package:sokia_app/helper/payment/payment_helper.dart';
import 'package:sokia_app/screens/create_order/components/single_item_card.dart';
import 'package:sokia_app/screens/order_completed_screen.dart';

final TextEditingController noteController = TextEditingController();

class CreateOrderScreen extends StatelessWidget {
  final List<Mosque> mosques;
  final orderController = Get.put(OrderController());
  final homeController = Get.find<HomeController>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
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
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text(
          'createOrder'.tr,
          style: Theme.of(context)
              .textTheme
              .headline6
              .copyWith(color: Colors.white),
        ),
        centerTitle: true,
        brightness: Brightness.dark,
      ),
      backgroundColor: kBackgroundColor,
      body:  SingleChildScrollView(
        child: Column(
          children: [
            _buildMosqueCards(),
            _paymentMethod(),
            _paymentMethodView(),
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

  Future<void> _confirmOrder() async {
    // Get.to(()=>OrderCompletedScreen());
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

  Widget _paymentMethodView() => GetBuilder<OrderController>(
        builder: (controller) => AnimatedSwitcher(
          duration: Duration(milliseconds: 500),
          child: controller.cash
              ? Container(
                  key: UniqueKey(),
                )
              : Padding(
                  key: UniqueKey(),
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    height: 70,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        // mada
                        GestureDetector(
                          onTap: () async {
                            _openPaymentGateWay(Brands.Mada);
                          },
                          child: Container(
                            width: 100,
                            height: 60,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white),
                            alignment: AlignmentDirectional.center,
                            child: Image.asset(
                              'src/images/mada.png',
                              fit: BoxFit.contain,
                              alignment: AlignmentDirectional.center,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        // visa
                        GestureDetector(
                          onTap: () {
                            _openPaymentGateWay(Brands.Visa);

                          },
                          child: Container(
                            width: 100,
                            height: 60,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white),
                            alignment: AlignmentDirectional.center,
                            child: Image.asset(
                              'src/images/visa.png',
                              fit: BoxFit.contain,
                              alignment: AlignmentDirectional.center,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        // master card
                        GestureDetector(
                          onTap: () {
                            _openPaymentGateWay(Brands.MasterCard);

                          },
                          child: Container(
                            width: 100,
                            height: 60,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white),
                            alignment: AlignmentDirectional.center,
                            child: Image.asset(
                              'src/images/mastercard.png',
                              fit: BoxFit.contain,
                              alignment: AlignmentDirectional.center,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        // apple
                        GestureDetector(
                          onTap: () {
                            _openPaymentGateWay(Brands.Apple);
                          },
                          child: Visibility(
                            visible: Platform.isIOS,
                            child: Container(
                              width: 100,
                              height: 60,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white),
                              alignment: AlignmentDirectional.center,
                              child: Image.asset(
                                'src/images/apple.png',
                                fit: BoxFit.contain,
                                alignment: AlignmentDirectional.center,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        ),
      );

  Widget _notes() => Padding(
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

  void _openPaymentGateWay(Brands brand) async{
    String status = await PaymentHelper().openPaymentUi(
        brand: brand,
        amount: orderController.totalPriceForAllOrders,
        currency: Currency.USD);

    if (status != null && status == "true") {
      print('Sokia transactionStatus ----> $status');

      CommonMethods().showToast(
          message: 'Payment Completed',
          context: scaffoldKey.currentContext);

      // getPaymentStatus();
    } else if (status == "cancelled") {
      CommonMethods().showToast(
          message: 'Payment Cancelled',
          context: scaffoldKey.currentContext);

      print('Sokia transactionStatus ----> $status');
    } else if (status.contains("false")) {
      //remove false from string
      CommonMethods().showToast(
          message: 'Payment Failed',
          context: scaffoldKey.currentContext);

      //error
      print('Sokia transactionStatus ----> $status');
    }
  }
}
