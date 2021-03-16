import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sokia_app/controllers/auth_controller.dart';
import 'package:sokia_app/helper/CommonMethods.dart';
import 'package:sokia_app/helper/Constant.dart';
import 'package:sokia_app/helper/custom_widgets/text/custom_text.dart';
import 'package:sokia_app/helper/social_button.dart';
import 'package:sokia_app/screens/auth/login/login_screen.dart';
import 'package:sokia_app/screens/terms_screen.dart';

class SocialLogin extends StatelessWidget {
  final controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        toolbarHeight: 0.0,
        brightness: Brightness.dark,
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 300,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.fitHeight,
                          image: AssetImage(
                            'src/images/login_head.png',
                          ),
                        ),
                      ),
                    ),
                    PositionedDirectional(
                      child: Center(
                        child: Column(
                          children: [
                            Image.asset(
                              'src/images/logo.png',
                              fit: BoxFit.contain,
                              width: 100,
                              height: 100,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CustomText(
                                text: 'charity'.tr,
                                alignment: AlignmentDirectional.center,
                              ),
                            )
                          ],
                        ),
                      ),
                      top: 20,
                      end: 0,
                      start: 0,
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                SocialButton(
                  imageAsset: 'src/images/phone.png',
                  text: 'loginWithPhone'.tr,
                  onTap: () {
                    Get.to(() => LoginScreen());
                  },
                ),
                SocialButton(
                  imageAsset: 'src/images/snapchat_social.png',
                  text: 'loginWithSnap'.tr,
                  onTap: () {},
                ),
                SocialButton(
                  imageAsset: 'src/images/google.png',
                  text: 'loginWithGoogle'.tr,
                  onTap: () {
                    controller.signInGoogle();
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                CustomText(
                  text: 'agreeTo'.tr,
                  fontSize: 12,
                  maxLines: 2,
                  alignment: AlignmentDirectional.center,
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(() => TermsScreen());
                  },
                  child: Text(
                    'termsAndConditions'.tr,
                    style: TextStyle(
                        fontSize: 14,
                        color: kAccentColor,
                        decoration: TextDecoration.underline),
                  ),
                )
              ],
            ),
            GetBuilder<AuthController>(
              builder: (controller) => Container(
                alignment: AlignmentDirectional.center,
                child: Visibility(
                  visible: controller.loading,
                  child: CommonMethods().loadingWithBackground(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
