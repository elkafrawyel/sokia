import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sokia_app/data/responses/my_orders_response.dart';
import 'package:sokia_app/helper/Constant.dart';
import 'package:sokia_app/helper/custom_widgets/text/custom_text.dart';
import 'package:sokia_app/screens/order_details/order_details.dart';

class OrderItem extends StatelessWidget {
  final Order order;

  OrderItem({@required this.order});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => OrderDetailsScreen(order));
      },
      child: Container(
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          elevation: 2.0,
          child: Stack(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      'src/images/mosque.png',
                      width: 70,
                      height: 70,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 30,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CustomText(
                            text: _donateTo(order.orderDetails),
                            fontSize: fontSize14,
                            maxLines: 30,
                            alignment: AlignmentDirectional.topStart,
                            textAlign: TextAlign.start,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CustomText(
                            text: order.note == null ? '' : order.note,
                            fontSize: fontSize14,
                            color: Colors.grey.shade500,
                            maxLines: 3,
                            alignment: AlignmentDirectional.topStart,
                            textAlign: TextAlign.start,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.only(
                              end: 10, bottom: 10),
                          child: CustomText(
                            text: _orderStatus(order.orderStatus),
                            fontSize: fontSize14,
                            color: _orderStatusColor(order.orderStatus),
                            maxLines: 1,
                            alignment: AlignmentDirectional.bottomEnd,
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              PositionedDirectional(
                  end: 0,
                  top: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadiusDirectional.only(
                        topStart: Radius.elliptical(50, 50),
                        bottomStart: Radius.elliptical(50, 50),
                      ),
                      color: _orderStatusColor(order.orderStatus),
                    ),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.only(
                          start: 20, end: 10, top: 5, bottom: 5),
                      child: CustomText(
                        text: '#${order.orderCode}',
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  _donateTo(List<OrderDetails> orderDetails) {
    String text = '';
    if (orderDetails.isNotEmpty) {
      orderDetails.forEach((element) {
        text = text + '- ' + element.donateTo + ',\n';
      });
    }
    return text.trim();
  }

  _orderStatus(String orderStatus) {
    switch (order.orderStatus) {
      case 'running':
        return 'running'.tr;
      case 'cancelled':
        return 'cancelled'.tr;
      case 'ended':
        return 'ended'.tr;
    }
  }

  _orderStatusColor(String orderStatus) {
    switch (order.orderStatus) {
      case 'running':
        return kPrimaryColor;
      case 'cancelled':
        return Colors.red;
      case 'ended':
        return kAccentColor;
    }
  }
}
