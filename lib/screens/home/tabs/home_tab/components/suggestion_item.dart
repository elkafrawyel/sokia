import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sokia_app/controllers/home_controller.dart';
import 'package:sokia_app/data/responses/home_response.dart';
import 'package:sokia_app/helper/CommonMethods.dart';
import 'package:sokia_app/helper/Constant.dart';
import 'package:sokia_app/helper/custom_widgets/text/custom_text.dart';
import 'package:sokia_app/helper/local_storage.dart';
import 'package:sokia_app/screens/create_order/create_order_screen.dart';
import 'package:get/get.dart';

class SuggestionItem extends StatelessWidget {
  final Mosque mosque;

  SuggestionItem({this.mosque});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //you must login
        if (LocalStorage().getBool(LocalStorage.loginKey)) {
          Get.to(() => CreateOrderScreen(mosques: [mosque]));
        } else {
          CommonMethods().showToast(message: 'youMustLogin'.tr, context: context);
        }
      },
      child: Container(
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          elevation: 2.0,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CachedNetworkImage(
                  fit: BoxFit.contain,
                  // placeholder: placeholder,
                  height: 100,
                  width: 90,
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 2.0,
                    ),
                  ),
                  imageUrl: mosque.mosqueImage,
                  errorWidget: (context, url, error) => Icon(
                    Icons.error,
                    color: Colors.grey,
                    size: 50,
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomText(
                      text: mosque.mosqueName,
                      fontSize: fontSize16,
                      maxLines: 1,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CustomText(
                      text: mosque.mosqueAdress,
                      fontSize: fontSize14,
                      color: Colors.grey.shade500,
                      maxLines: 3,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsetsDirectional.only(
                              bottom: 10, end: 10),
                          child: CustomText(
                            text: mosque.status,
                            fontSize: 12,
                            color: kAccentColor,
                            maxLines: 1,
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsetsDirectional.only(
                                end: 10, bottom: 10),
                            child: CustomText(
                              text: mosque.fastShipping,
                              fontSize: 12,
                              color: kPrimaryColor,
                              maxLines: 1,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
