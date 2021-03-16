import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sokia_app/helper/Constant.dart';
import 'package:sokia_app/helper/custom_widgets/text/custom_text.dart';
import 'package:sokia_app/screens/order_details/order_details.dart';

class OrderItem extends StatelessWidget {
  final isActive = true;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(OrderDetailsScreen());
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
                            text: 'مسجد علي بن ابي طالب',
                            fontSize: fontSize16,
                            maxLines: 1,
                            alignment: AlignmentDirectional.topStart,
                            textAlign: TextAlign.start,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CustomText(
                            text:
                                ' يجب التسليم في اقرب وقت عمل المسجد يكون موجود وقت الصلاة فقط',
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
                            text: isActive ? 'طلب نشط' : 'طلب منتهي',
                            fontSize: fontSize14,
                            color: isActive ? kPrimaryColor : kAccentColor,
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
                      color: isActive ? kPrimaryColor : kAccentColor,
                    ),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.only(
                          start: 20, end: 10, top: 5, bottom: 5),
                      child: CustomText(
                        text: '#5645333',
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
}
