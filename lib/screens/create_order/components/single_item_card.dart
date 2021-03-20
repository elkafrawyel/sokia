import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sokia_app/controllers/home_controller.dart';
import 'package:sokia_app/controllers/order_controller.dart';
import 'package:sokia_app/helper/CommonMethods.dart';
import 'package:sokia_app/helper/Constant.dart';
import 'package:sokia_app/helper/custom_widgets/custom_button.dart';
import 'package:sokia_app/helper/custom_widgets/text/custom_outline_text_form_field.dart';
import 'package:sokia_app/helper/custom_widgets/text/custom_text.dart';
import 'package:sokia_app/screens/create_order/components/bottom_sheet_list.dart';

// ignore: must_be_immutable
class SingleItemCard extends StatelessWidget {
  final OrderModel orderModel;

  final orderController = Get.find<OrderController>();

  Timer nameDebouncer;
  Timer numberDebouncer;

  SingleItemCard({
    @required this.orderModel,
  }) {
    if (orderModel.category == null) {
      orderModel.category = Get.find<HomeController>().categories[0];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.only(
              top: 20,
              start: 20,
            ),
            child: CustomText(
              text: 'orderDetails'.tr + ' ( ${orderModel.mosque.mosqueName} )',
              fontSize: fontSize18,
            ),
          ),
          Padding(
            padding:
                const EdgeInsetsDirectional.only(top: 10, start: 10, end: 10),
            child: Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 5,
              shadowColor: Colors.black,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CustomText(
                          text: '${orderModel.count} ' +
                              'boxes'.tr +
                              ' ${orderModel.category.categoryName}',
                          fontSize: fontSize16,
                          color: kPrimaryColor,
                        ),
                        CustomButton(
                            text: 'change'.tr,
                            underLineText: true,
                            colorBackground: Colors.white,
                            colorText: Colors.grey.shade500,
                            elevation: 0.0,
                            onPressed: () {
                              _changeCategory();
                            }),
                        Expanded(
                          child: CustomText(
                            alignment: AlignmentDirectional.centerEnd,
                            text: orderController
                                .priceWithCurrency(orderModel.orderPrice),
                            color: kAccentColor,
                            fontSize: fontSize16,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.only(top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            text: orderModel.category.note,
                            color: Colors.grey.shade600,
                            fontSize: fontSize14,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CachedNetworkImage(
                              fit: BoxFit.contain,
                              // placeholder: placeholder,
                              height: 50,
                              width: 50,
                              placeholder: (context, url) => Center(
                                child: CircularProgressIndicator(
                                  strokeWidth: 2.0,
                                ),
                              ),
                              imageUrl: orderModel.category.categoryImage,
                              errorWidget: (context, url, error) => Icon(
                                Icons.error,
                                color: Colors.grey.shade300,
                                size: 50,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: kBackgroundColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: IconButton(
                            onPressed: () {
                              _add();
                            },
                            color: Colors.black,
                            iconSize: 30,
                            icon: ImageIcon(AssetImage('src/images/add.png')),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CustomText(
                            text: orderModel.count.toString(),
                            fontSize: fontSize18,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: kBackgroundColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: IconButton(
                            onPressed: () {
                              _remove(context);
                            },
                            color: Colors.black,
                            iconSize: 30,
                            icon: ImageIcon(AssetImage('src/images/minus.png')),
                          ),
                        ),
                        Expanded(
                          child: CustomText(
                            text: 'اقل عدد 10 كراتين لوجهتك',
                            color: kAccentColor,
                            fontSize: fontSize14,
                            alignment: AlignmentDirectional.centerEnd,
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.only(
                        top: 20,
                      ),
                      child: CustomOutlinedTextFormField(
                        text: 'workerNameHint'.tr,
                        hintText: 'workerNameHint'.tr,
                        maxLines: 1,
                        labelText: 'workerNameHint'.tr,
                        required: false,
                        keyboardType: TextInputType.text,
                        labelColor: Colors.black,
                        hintColor: Colors.black,
                        textColor: Colors.black,
                        onChanged: (value) {
                          nameDebounce(() {
                            orderModel.workerName = value;
                            print(value);
                            orderController.updateOrderMap(
                                orderModel: orderModel);
                          });
                        },
                        onFieldSubmitted: (value) {
                          if (nameDebouncer != null) nameDebouncer.cancel();

                          print(value);
                          orderController.updateOrderMap(
                              orderModel: orderModel);
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.only(
                        top: 20,
                      ),
                      child: CustomOutlinedTextFormField(
                        text: 'workerNumberHint'.tr,
                        hintText: 'workerNumberHint'.tr,
                        maxLines: 1,
                        required: false,
                        labelText: 'workerNumberHint'.tr,
                        keyboardType: TextInputType.number,
                        labelColor: Colors.black,
                        hintColor: Colors.black,
                        textColor: Colors.black,
                        onChanged: (value) {
                          numberDebounce(() {
                            orderModel.workerNumber = value;
                            print(value);
                            orderController.updateOrderMap(
                                orderModel: orderModel);
                          });
                        },
                        onFieldSubmitted: (value) {
                          if (numberDebouncer != null) numberDebouncer.cancel();

                          print(value);
                          orderController.updateOrderMap(
                              orderModel: orderModel);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void nameDebounce(VoidCallback callback,
      {Duration duration = const Duration(seconds: 1)}) {
    if (nameDebouncer != null) {
      nameDebouncer.cancel();
    }
    nameDebouncer = Timer(duration, callback);
  }

  void numberDebounce(VoidCallback callback,
      {Duration duration = const Duration(seconds: 1)}) {
    if (numberDebouncer != null) {
      numberDebouncer.cancel();
    }
    numberDebouncer = Timer(duration, callback);
  }

  void _add() {
    orderModel.count++;
    orderController.updateOrderMap(orderModel: orderModel);
  }

  void _remove(BuildContext context) {
    if (orderModel.count > 10) {
      orderModel.count--;
      orderController.updateOrderMap(orderModel: orderModel);
    } else {
      CommonMethods()
          .showToast(message: 'orderCountMessage'.tr, context: context);
    }
  }

  void _changeCategory() {
    CommonMethods().showBottomSheet(
      BottomSheetList(
        categories: Get.find<HomeController>().categories,
        onSelect: (selectedCategory) {
          Get.back();
          orderModel.category = selectedCategory;
          orderController.updateOrderMap(orderModel: orderModel);
        },
      ),
    );
  }
}
