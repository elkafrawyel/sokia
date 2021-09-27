import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sokia_app/controllers/home_controller.dart';
import 'package:sokia_app/controllers/create_order_controller.dart';
import 'package:sokia_app/data/data_models/order_model.dart';
import 'package:sokia_app/helper/CommonMethods.dart';
import 'package:sokia_app/helper/Constant.dart';
import 'package:sokia_app/helper/custom_widgets/custom_button.dart';
import 'package:sokia_app/helper/custom_widgets/text/custom_text.dart';
import 'package:sokia_app/screens/create_order/components/bottom_sheet_list.dart';

Timer nameDebouncer;
Timer numberDebouncer;

final nameController = TextEditingController();
final numberController = TextEditingController();

class SingleItemCard extends StatelessWidget {
  final OrderModel orderModel;

  final orderController = Get.find<CreateOrderController>();

  SingleItemCard({
    @required this.orderModel,
  });

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
            child: Row(
              children: [
                Expanded(
                  child: CustomText(
                    text:
                        'orderDetails'.tr + ' (${orderModel.searchModel.name})',
                    fontSize: fontSize14 - 2,
                    maxLines: 2,
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.only(
                    top: 5,
                    end: 10,
                    start: 10,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.green.shade300),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          _addCategory();
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                            CustomText(
                              text: 'addCategory'.tr,
                              fontSize: fontSize14,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding:
                const EdgeInsetsDirectional.only(top: 10, start: 10, end: 10),
            child: Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 3,
              child: Column(
                children: [
                  Column(
                    children: orderModel.orderCategories
                        .map(
                          (item) => Column(
                            children: [
                              Padding(
                                padding: const EdgeInsetsDirectional.only(
                                    top: 10, end: 10, start: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    CustomText(
                                      text: '${item.count} ' +
                                          'boxes'.tr +
                                          ' ${item.category.categoryName}',
                                      fontSize: fontSize14,
                                      color: kPrimaryColor,
                                    ),
                                    Visibility(
                                      visible:
                                          orderModel.orderCategories.length > 1,
                                      child: IconButton(
                                          icon: Icon(
                                            Icons.remove,
                                            color: Colors.red,
                                          ),
                                          onPressed: () {
                                            _removeCategory(item);
                                          }),
                                    ),
                                    Expanded(
                                      child: CustomText(
                                        alignment:
                                            AlignmentDirectional.centerEnd,
                                        text: orderController.priceWithCurrency(
                                            item.categoryPrice()),
                                        color: kAccentColor,
                                        fontSize: fontSize14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.only(
                                    end: 10, start: 10),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomText(
                                      text: item.category.note,
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
                                        imageUrl: item.category.categoryImage,
                                        errorWidget: (context, url, error) =>
                                            Icon(
                                          Icons.error,
                                          color: Colors.grey.shade300,
                                          size: 50,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.only(
                                    end: 10, start: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: kBackgroundColor,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: IconButton(
                                        onPressed: () {
                                          _add(item);
                                        },
                                        color: Colors.black,
                                        iconSize: 30,
                                        icon: Icon(
                                          Icons.add,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: CustomText(
                                        text: item.count.toString(),
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
                                          _remove(context, item);
                                        },
                                        color: Colors.black,
                                        iconSize: 30,
                                        icon: Icon(
                                          Icons.remove,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: CustomText(
                                        text: 'atLeastTenBox'.tr,
                                        color: kAccentColor,
                                        fontSize: 12,
                                        textAlign: TextAlign.center,
                                        alignment:
                                            AlignmentDirectional.centerEnd,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Divider(
                                thickness: 2,
                              ),
                            ],
                          ),
                        )
                        .toList(),
                  ),
                  _workerInfo(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void nameDebounce(VoidCallback callback,
      {Duration duration = const Duration(seconds: 3)}) {
    if (nameDebouncer != null) {
      nameDebouncer.cancel();
    }
    nameDebouncer = Timer(duration, callback);
  }

  void numberDebounce(VoidCallback callback,
      {Duration duration = const Duration(seconds: 3)}) {
    if (numberDebouncer != null) {
      numberDebouncer.cancel();
    }
    numberDebouncer = Timer(duration, callback);
  }

  void _add(OrderCategories item) {
    orderModel
        .orderCategories[orderModel.orderCategories.indexOf(item)].count++;
    orderController.updateOrderMap(orderModel: orderModel);
  }

  void _remove(BuildContext context, OrderCategories item) {
    if (orderModel
            .orderCategories[orderModel.orderCategories.indexOf(item)].count >
        10) {
      orderModel
          .orderCategories[orderModel.orderCategories.indexOf(item)].count--;
      orderController.updateOrderMap(orderModel: orderModel);
    } else {
      CommonMethods().showToast(
        message: 'orderCountMessage'.tr,
      );
    }
  }

  void _addCategory() {
    CommonMethods().showBottomSheet(
      BottomSheetList(
        categories: Get.find<HomeController>().categories,
        onSelect: (selectedCategory) {
          Get.back();
          orderModel.orderCategories.add(OrderCategories(selectedCategory, 10));
          orderController.updateOrderMap(orderModel: orderModel);
        },
      ),
    );
  }

  void _removeCategory(OrderCategories item) {
    orderModel.orderCategories.remove(item);
    orderController.updateOrderMap(orderModel: orderModel);
  }

  _workerInfo() => Column(
        children: [
          Visibility(
            visible: (orderModel.workerName != null &&
                    orderModel.workerName.isNotEmpty) ||
                (orderModel.workerNumber != null &&
                    orderModel.workerNumber.isNotEmpty),
            child: Divider(
              thickness: 2,
            ),
          ),
          Visibility(
            visible: orderModel.workerName != null &&
                orderModel.workerName.isNotEmpty,
            child: Padding(
              padding:
                  const EdgeInsetsDirectional.only(top: 10, end: 10, start: 10),
              child: CustomText(
                text: '${'workerName'.tr} : ${orderModel.workerName}',
              ),
            ),
          ),
          Visibility(
            visible: orderModel.workerNumber != null &&
                orderModel.workerNumber.isNotEmpty,
            child: Padding(
              padding:
                  const EdgeInsetsDirectional.only(top: 10, end: 10, start: 10),
              child: CustomText(
                text: '${'workerNumber'.tr} : ${orderModel.workerNumber}',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.only(
              top: 10,
            ),
            child: Container(
              width: MediaQuery.of(Get.context).size.width * 0.6,
              child: CustomButton(
                text: 'addWorkerInfo'.tr,
                colorText: Colors.white,
                elevation: 0,
                radius: 20,
                fontSize: 12,
                colorBackground: kPrimaryColor,
                onPressed: () async {
                  WorkerInfo workerInfo = await _showWorkerDialog(
                      workerName: orderModel.workerName,
                      workerNumber: orderModel.workerNumber);
                  orderModel.workerName = workerInfo.name;
                  orderModel.workerNumber = workerInfo.number;
                  orderController.updateOrderMap(orderModel: orderModel);
                },
              ),
            ),
          ),
        ],
      );

  Future<WorkerInfo> _showWorkerDialog(
      {String workerName, String workerNumber}) async {
    TextEditingController nameController = TextEditingController();
    TextEditingController numberController = TextEditingController();
    nameController.text = workerName;
    numberController.text = workerNumber;
    String name;
    String number;
    await showDialog<WorkerInfo>(
      barrierDismissible: true,
      context: Get.context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.white,
          insetPadding: EdgeInsets.all(20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsetsDirectional.only(
                start: 10, bottom: 5, end: 10, top: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                    controller: nameController,
                    keyboardType: TextInputType.text,
                    autofocus: true,
                    decoration: InputDecoration(
                      hintText: 'workerName'.tr,
                      hintStyle:
                          TextStyle(fontSize: 14, color: Colors.grey.shade600),
                      contentPadding: EdgeInsets.all(16),
                      alignLabelWithHint: true,
                      errorStyle: TextStyle(
                        color: Colors.red,
                        fontSize: 14,
                      ),
                      labelText: 'workerName'.tr,
                      labelStyle:
                          TextStyle(fontSize: 14, color: Colors.grey.shade600),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    )),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: numberController,
                  keyboardType: TextInputType.number,
                  autofocus: true,
                  decoration: InputDecoration(
                    hintText: 'workerNumber'.tr,
                    hintStyle:
                        TextStyle(fontSize: 14, color: Colors.grey.shade600),
                    contentPadding: EdgeInsets.all(16),
                    alignLabelWithHint: true,
                    errorStyle: TextStyle(
                      color: Colors.red,
                      fontSize: 14,
                    ),
                    labelText: 'workerNumber'.tr,
                    labelStyle:
                        TextStyle(fontSize: 14, color: Colors.grey.shade600),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomButton(
                        text: 'ok'.tr,
                        colorBackground: Colors.white,
                        fontSize: fontSize16,
                        elevation: 0,
                        colorText: kPrimaryColor,
                        radius: 0,
                        onPressed: () {
                          if (nameController.text.isNotEmpty)
                            name = nameController.text;
                          if (numberController.text.isNotEmpty)
                            number = numberController.text;

                          Get.back();
                        }),
                    CustomButton(
                        text: 'cancel'.tr,
                        colorBackground: Colors.white,
                        fontSize: fontSize16,
                        elevation: 0,
                        colorText: Colors.red,
                        radius: 0,
                        onPressed: () {
                          Get.back();
                        }),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
    return WorkerInfo(name: name, number: number);
  }
}

class WorkerInfo {
  String name, number;

  WorkerInfo({this.name, this.number});
}
