import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sokia_app/helper/Constant.dart';
import 'package:sokia_app/helper/custom_widgets/main_screen.dart';
import 'package:sokia_app/helper/custom_widgets/text/custom_text.dart';
import 'package:sokia_app/screens/chat/chat_screen.dart';

class OrderDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MainScreen(
      title: 'orderDetails'.tr,
      pageBackground: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.circular(0)),
                child: CustomText(
                  text: 'رقم الطلب',
                  fontSize: fontSize16,
                  color: Colors.white,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 5,
                      child: CustomText(
                        text: 'رقم الطلب :',
                        fontSize: fontSize14,
                        color: Colors.black,
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: CustomText(
                        text: '15664616',
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
                  text: 'معلومات العميل',
                  fontSize: fontSize16,
                  color: Colors.white,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 5,
                      child: CustomText(
                        text: 'أسم المستخدم:',
                        fontSize: fontSize14,
                        color: Colors.black,
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: CustomText(
                        text: 'أحمد محمد',
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
                    Expanded(
                      flex: 5,
                      child: CustomText(
                        text: 'رقم الجوال:',
                        fontSize: fontSize14,
                        color: Colors.black,
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: CustomText(
                        text: '01019744661',
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
                  text: 'موعد الطلب',
                  fontSize: fontSize16,
                  color: Colors.white,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 5,
                      child: CustomText(
                        text: 'التاريخ:',
                        fontSize: fontSize14,
                        color: Colors.black,
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: CustomText(
                        text: '2019 / 9 / 1',
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
                  text: 'معلومات الطلب',
                  fontSize: fontSize16,
                  color: Colors.white,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: CustomText(
                        text: 'أسم عامل المسجد:',
                        fontSize: fontSize14,
                        color: Colors.black,
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: CustomText(
                        text: 'أحمد محمد',
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
                    Expanded(
                      flex: 5,
                      child: CustomText(
                        text: 'رقم عامل المسجد:',
                        fontSize: fontSize14,
                        color: Colors.black,
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: CustomText(
                        text: '01019744661',
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 3,
                      child: CustomText(
                        text: 'الموقع:',
                        fontSize: fontSize14,
                        color: Colors.black,
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: CustomText(
                        text: 'الاحساء',
                        fontSize: fontSize14,
                        color: Colors.black,
                        maxLines: 2,
                        alignment: AlignmentDirectional.centerStart,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        //open map
                      },
                      child: Expanded(
                        flex: 1,
                        child: CustomText(
                          text: '(عرض علي الخريطة)',
                          fontSize: fontSize14,
                          color: kPrimaryColor,
                          alignment: AlignmentDirectional.centerStart,
                        ),
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
                  text: 'المبلغ',
                  fontSize: fontSize16,
                  color: Colors.white,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 6,
                      child: CustomText(
                        text: 'عدد (10) كراتين مياة',
                        fontSize: fontSize14,
                        color: Colors.black,
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: CustomText(
                        text: '1500 رس',
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
                    Expanded(
                      flex: 5,
                      child: CustomText(
                        text: 'خدمة التوصيل',
                        fontSize: fontSize14,
                        color: Colors.black,
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: CustomText(
                        text: '40 رس',
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
                    Expanded(
                      flex: 5,
                      child: CustomText(
                        text: 'المبلغ الاجمالي',
                        fontSize: fontSize14,
                        color: Colors.black,
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: CustomText(
                        text: '2000 رس',
                        fontSize: fontSize14,
                        color: Colors.black,
                        alignment: AlignmentDirectional.centerStart,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    flex: 5,
                    child: FlatButton(
                      height: 50,
                      color: kPrimaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      onPressed: () {},
                      child: CustomText(
                        text: 'الفاتورة',
                        color: Colors.white,
                        alignment: AlignmentDirectional.center,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    flex: 5,
                    child: FlatButton(
                      height: 50,
                      color: kPrimaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      onPressed: () {
                        Get.to(ChatScreen());
                      },
                      child: CustomText(
                        text: 'خدمة العملاء',
                        color: Colors.white,
                        alignment: AlignmentDirectional.center,
                      ),
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
}
