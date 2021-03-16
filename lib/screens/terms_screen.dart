import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sokia_app/controllers/general_controller.dart';
import 'package:sokia_app/data/responses/conditions_response.dart';
import 'package:sokia_app/helper/Constant.dart';
import 'package:sokia_app/helper/custom_widgets/main_screen.dart';
import 'package:sokia_app/helper/custom_widgets/text/custom_text.dart';

class TermsScreen extends StatelessWidget {
  final controller = Get.put(GeneralController());

  TermsScreen() {
    controller.getConditionsList();
  }

  @override
  Widget build(BuildContext context) {
    return MainScreen(
      title: 'terms'.tr,
      pageBackground: kBackgroundColor,
      body: GetBuilder<GeneralController>(
        init: GeneralController(),
        builder: (controller) => controller.loading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : _buildView(controller.conditionsList),
      ),
    );
  }

  Widget _buildView(List<ConditionModel> data) {
    List<Widget> views = [];
    data.forEach((element) {
      views.add(
        _singleItem(element.title, element.body),
      );
    });
    return SingleChildScrollView(
      child: Column(
        children: views,
      ),
    );
  }

  _singleItem(String title, String body) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(start: 20, top: 20, end: 20),
      child: Column(
        children: [
          Column(
            children: [
              Container(
                color: Colors.grey.shade300,
                child: Row(
                  children: [
                    Container(
                      width: 20,
                      height: 50,
                      color: kPrimaryColor,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: CustomText(
                        text: title,
                        fontSize: fontSize16,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomText(
                  text: body,
                  maxLines: 50,
                  fontSize: fontSize16,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
