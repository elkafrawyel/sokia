import 'package:flutter/material.dart';
import 'package:sokia_app/helper/Constant.dart';
import 'package:sokia_app/helper/custom_widgets/text/custom_text.dart';
import 'package:sokia_app/helper/local_storage.dart';

class OrderCompletedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Image.asset(
              'src/images/order_confirmed.png',
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(
                    fontSize: fontSize16,
                    color: Colors.white,
                    alignment: AlignmentDirectional.center,
                    text: 'تم تأكيد طلبك بنجاح',
                  ),
                  CustomText(
                    fontSize: 12,
                    color: Colors.white,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    text:
                        'يمكنك الرجوع إلى تفاصيل طلبك وذلك من خلال خانة طلباتي الموجودة في القائمة ',
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.white),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            LocalStorage().isArabicLanguage()
                                ? Icons.arrow_back
                                : Icons.arrow_forward,
                            color: kPrimaryColor,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      CustomText(
                        fontSize: fontSize16,
                        color: Colors.white,
                        alignment: AlignmentDirectional.center,
                        text: 'الرجوع للرئيسية',
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
