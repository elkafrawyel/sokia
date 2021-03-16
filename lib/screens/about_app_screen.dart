import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sokia_app/controllers/general_controller.dart';
import 'package:sokia_app/helper/Constant.dart';
import 'package:sokia_app/helper/custom_widgets/main_screen.dart';
import 'package:sokia_app/helper/custom_widgets/text/custom_text.dart';

class AboutAppScreen extends StatelessWidget {
  final controller = Get.put(GeneralController());

  AboutAppScreen() {
    controller.getAboutApp();
  }

  @override
  Widget build(BuildContext context) {
    return MainScreen(
      title: 'about'.tr,
      pageBackground: kBackgroundColor,
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Image.asset(
                'src/images/logo.png',
                width: 100,
                height: 100,
              ),
              SizedBox(
                height: 40,
              ),
              GetBuilder<GeneralController>(
                init: GeneralController(),
                builder: (controller) =>
                    controller.loading && controller.aboutApp == null
                        ? Container(
                            height: 300,
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: CustomText(
                              text: controller.aboutApp,
                              maxLines: 100,
                              fontSize: fontSize16,
                            ),
                          ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
