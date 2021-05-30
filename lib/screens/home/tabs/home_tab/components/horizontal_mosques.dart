import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sokia_app/controllers/create_order_controller.dart';
import 'package:sokia_app/data/data_models/search_model.dart';
import 'package:sokia_app/data/responses/home_response.dart';
import 'package:sokia_app/helper/CommonMethods.dart';
import 'package:sokia_app/helper/Constant.dart';
import 'package:sokia_app/helper/custom_widgets/text/custom_text.dart';
import 'package:sokia_app/helper/get_binding.dart';
import 'package:sokia_app/helper/local_storage.dart';
import 'package:sokia_app/screens/create_order/create_order_screen.dart';
import 'package:sokia_app/screens/map/map_screen.dart';

class HorizontalMosques extends StatelessWidget {
  final List<SearchModel> mosques;

  HorizontalMosques({this.mosques});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      padding: EdgeInsetsDirectional.only(top: 5),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: mosques.length,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () async {
            //you must login
            if (LocalStorage().getBool(LocalStorage.loginKey)) {
              await Get.to(
                  () => CreateOrderScreen(searchModel: [mosques[index]]));
              Get.find<CreateOrderController>().orderMap.clear();
            } else {
              CommonMethods().showToast(
                message: 'youMustLogin'.tr,
              );
            }
          },
          child: Container(
            width: Get.width * 0.5,
            alignment: AlignmentDirectional.center,
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              elevation: 2.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CachedNetworkImage(
                      fit: BoxFit.contain,
                      // placeholder: placeholder,
                      height: 90,
                      width: Get.width * 0.6,
                      placeholder: (context, url) => Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 2.0,
                        ),
                      ),
                      imageUrl: mosques[index].image,
                      errorWidget: (context, url, error) => Icon(
                        Icons.error,
                        color: Colors.grey,
                        size: 50,
                      ),
                    ),
                  ),
                  CustomText(
                    text: mosques[index].name,
                    fontSize: fontSize16 - 2,
                    maxLines: 1,
                    alignment: AlignmentDirectional.center,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomText(
                    text: mosques[index].adress,
                    fontSize: fontSize14,
                    color: Colors.grey.shade500,
                    maxLines: 2,
                    alignment: AlignmentDirectional.center,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  // Padding(
                  //   padding:
                  //       const EdgeInsetsDirectional.only(bottom: 10, end: 10),
                  //   child: CustomText(
                  //     text: mosques[index].status,
                  //     alignment: AlignmentDirectional.center,
                  //     fontSize: 12,
                  //     color: kAccentColor,
                  //     maxLines: 1,
                  //   ),
                  // ),
                  // Padding(
                  //   padding:
                  //       const EdgeInsetsDirectional.only(end: 10, bottom: 10),
                  //   child: CustomText(
                  //     text: mosques[index].fastShipping(),
                  //     alignment: AlignmentDirectional.center,
                  //     fontSize: 10,
                  //     color: kPrimaryColor,
                  //     maxLines: 1,
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
