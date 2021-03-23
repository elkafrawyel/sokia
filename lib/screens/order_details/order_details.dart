import 'dart:io';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sokia_app/controllers/user_controller.dart';
import 'package:sokia_app/data/responses/my_orders_response.dart';
import 'package:sokia_app/helper/Constant.dart';
import 'package:sokia_app/helper/custom_widgets/custom_button.dart';
import 'package:sokia_app/helper/custom_widgets/main_screen.dart';
import 'package:sokia_app/helper/custom_widgets/text/custom_text.dart';
import 'package:sokia_app/helper/map_helper/custom_marker.dart';
import 'package:sokia_app/screens/chat/chat_screen.dart';

class OrderDetailsScreen extends StatelessWidget {
  final Order order;

  OrderDetailsScreen(this.order);

  @override
  Widget build(BuildContext context) {
    return MainScreen(
      title: 'orderDetails'.tr,
      pageBackground: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.circular(0)),
                child: CustomText(
                  text: 'orderNumber'.tr,
                  fontSize: fontSize14,
                  color: Colors.white,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: CustomText(
                        text: 'orderNumber'.tr,
                        fontSize: fontSize14,
                        alignment: AlignmentDirectional.centerStart,
                        color: Colors.black,
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: CustomText(
                        text: order.orderCode,
                        fontSize: fontSize14,
                        alignment: AlignmentDirectional.centerStart,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.circular(0)),
                child: CustomText(
                  text: 'customerInfo'.tr,
                  fontSize: fontSize14,
                  color: Colors.white,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: CustomText(
                        text: 'name'.tr,
                        fontSize: fontSize14,
                        color: Colors.black,
                        alignment: AlignmentDirectional.centerStart,
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: CustomText(
                        text: Get.find<UserController>().user.name,
                        fontSize: fontSize14,
                        color: Colors.black,
                        alignment: AlignmentDirectional.centerStart,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: CustomText(
                        text: 'phone'.tr,
                        fontSize: fontSize14,
                        color: Colors.black,
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: CustomText(
                        text: Get.find<UserController>().user.phone == null ||
                                Get.find<UserController>().user.phone.isEmpty
                            ? 'noPhoneNumber'.tr
                            : Get.find<UserController>().user.phone,
                        fontSize: fontSize14,
                        color: Colors.black,
                        alignment: AlignmentDirectional.centerStart,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.circular(0)),
                child: CustomText(
                  text: 'orderDate'.tr,
                  fontSize: fontSize14,
                  color: Colors.white,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: CustomText(
                        text: 'date'.tr,
                        fontSize: fontSize14,
                        color: Colors.black,
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: CustomText(
                        text: order.createdAt,
                        fontSize: fontSize14,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.circular(0)),
                child: CustomText(
                  text: 'orderInfo'.tr,
                  fontSize: fontSize16,
                  color: Colors.white,
                ),
              ),
              _addOrderDetails(),
              Container(
                padding: EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.circular(0)),
                child: CustomText(
                  text: 'price'.tr,
                  fontSize: fontSize14,
                  color: Colors.white,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.of(Get.context).size.width * 0.4,
                      child: CustomText(
                        text: '${order.orderDetails[0].count} ' +
                            'boxes'.tr +
                            ' ${order.orderDetails[0].categoryName}',
                        fontSize: fontSize14,
                        color: Colors.black,
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(Get.context).size.width * 0.4,
                      child: CustomText(
                        text: priceWithCurrency(order.orderDetails[0].price),
                        fontSize: fontSize14,
                        color: Colors.black,
                        alignment: AlignmentDirectional.centerStart,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Container(
                      width: MediaQuery.of(Get.context).size.width * 0.4,
                      child: CustomText(
                        text: 'shipping'.tr,
                        fontSize: fontSize14,
                        color: Colors.black,
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(Get.context).size.width * 0.4,
                      child: CustomText(
                        text: priceWithCurrency(order.shippingPrice),
                        fontSize: fontSize14,
                        color: Colors.black,
                        alignment: AlignmentDirectional.centerStart,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Container(
                      width: MediaQuery.of(Get.context).size.width * 0.4,
                      child: CustomText(
                        text: 'total'.tr,
                        fontSize: fontSize14,
                        color: Colors.black,
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(Get.context).size.width * 0.4,
                      child: CustomText(
                        text: priceWithCurrency(order.orderPrice),
                        fontSize: fontSize14,
                        color: Colors.black,
                        alignment: AlignmentDirectional.centerStart,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 50,
                    width: MediaQuery.of(Get.context).size.width * 0.4,
                    child: CustomButton(
                      text: 'Bill',
                      colorText: Colors.white,
                      colorBackground: kPrimaryColor,
                      onPressed: () {
                        Get.to(() => ChatScreen());
                      },
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    height: 50,
                    width: MediaQuery.of(Get.context).size.width * 0.4,
                    child: CustomButton(
                      text: 'Chat',
                      colorText: Colors.white,
                      colorBackground: kPrimaryColor,
                      onPressed: () {
                        Get.to(() => ChatScreen());
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  String priceWithCurrency(double price) {
    return '${price.toStringAsFixed(2)} ' + 'currency'.tr;
  }

  _addOrderDetails() {
    return Column(
      children: order.orderDetails.map((e) => _singleOrderDetails(e)).toList(),
    );
  }

  Widget _singleOrderDetails(OrderDetails orderDetails) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsetsDirectional.only(top: 10),
          child: Row(
            children: [
              Container(
                width: MediaQuery.of(Get.context).size.width * 0.3,
                child: CustomText(
                  text: 'name'.tr,
                  fontSize: 12,
                  color: Colors.black,
                ),
              ),
              Container(
                width: MediaQuery.of(Get.context).size.width * 0.4,
                child: CustomText(
                  text: orderDetails.donateTo,
                  fontSize: 12,
                  maxLines: 3,
                  color: Colors.black,
                  alignment: AlignmentDirectional.centerStart,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsetsDirectional.only(top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(Get.context).size.width * 0.3,
                child: CustomText(
                  text: 'location'.tr,
                  fontSize: 12,
                  color: Colors.black,
                ),
              ),
              Expanded(
                child: CustomText(
                  text: orderDetails.adress,
                  fontSize: 12,
                  color: Colors.black,
                  maxLines: 4,
                  alignment: AlignmentDirectional.centerStart,
                ),
              ),
              GestureDetector(
                  onTap: () {
                    //open map
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: kPrimaryColor),
                    child: IconButton(
                        icon: Icon(
                          Icons.location_on_outlined,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          _openMapDialog(
                              orderDetails.donateTo,
                              orderDetails.adress,
                              double.parse(orderDetails.latitude),
                              double.parse(orderDetails.longitude));
                        }),
                  )),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsetsDirectional.only(top: 10),
          child: Row(
            children: [
              Container(
                width: MediaQuery.of(Get.context).size.width * 0.3,
                child: CustomText(
                  text: 'workerName'.tr,
                  fontSize: 12,
                  color: Colors.black,
                ),
              ),
              Container(
                width: MediaQuery.of(Get.context).size.width * 0.4,
                child: CustomText(
                  text: orderDetails.workerName == null ||
                          orderDetails.workerName.isEmpty
                      ? 'notFound'.tr
                      : orderDetails.workerName,
                  fontSize: 12,
                  color: Colors.black,
                  alignment: AlignmentDirectional.centerStart,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsetsDirectional.only(top: 10),
          child: Row(
            children: [
              Container(
                width: MediaQuery.of(Get.context).size.width * 0.3,
                child: CustomText(
                  text: 'workerNumber'.tr,
                  fontSize: 12,
                  color: Colors.black,
                ),
              ),
              Container(
                width: MediaQuery.of(Get.context).size.width * 0.4,
                child: CustomText(
                  text: orderDetails.workerNumber == null ||
                          orderDetails.workerNumber.isEmpty
                      ? 'notFound'.tr
                      : orderDetails.workerNumber,
                  fontSize: 12,
                  color: Colors.black,
                  alignment: AlignmentDirectional.centerStart,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Divider(
          thickness: 3,
        ),
      ],
    );
  }

  void _openMapDialog(
    String name,
    String address,
    double lat,
    double lng,
  ) {
    showDialog(
      context: Get.context,
      barrierDismissible: false,
      builder: (ctx) => Dialog(
        backgroundColor: Colors.black87,
        insetPadding: EdgeInsets.all(10),
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
          height: MediaQuery.of(Get.context).size.height * 0.6,
          child: GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: CameraPosition(
                // target: _userLatLng ,
                target: LatLng(lat, lng),
                zoom: 19),
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            onMapCreated: (controller) {
              final CameraPosition _kLocation = CameraPosition(
                  bearing: 0, target: LatLng(lat, lng), zoom: 16.0);
              controller
                  .animateCamera(CameraUpdate.newCameraPosition(_kLocation));
            },
            markers: Set<Marker>.of([createMarker(name, address, lat, lng)]),
            zoomControlsEnabled: false,
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }

  Marker createMarker(
    String name,
    String address,
    double lat,
    double lng,
  ) {
    final MarkerId markerId = MarkerId(order.id.toString());
    return Marker(
      markerId: markerId,
      position: LatLng(
        lat,
        lng,
      ),
      infoWindow: InfoWindow(
        title: name,
        snippet: _multiLineAddress(address),
      ),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
    );
  }

  String _multiLineAddress(String address) {
    String newStr = '';
    int step = 35;
    for (int i = 0; i < address.length; i += step) {
      newStr += address.substring(i, math.min(i + step, address.length));
      if (i + step < address.length) newStr += '\n';
    }
    print(newStr);
    return newStr;
  }
}
