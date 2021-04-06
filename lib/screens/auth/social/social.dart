import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
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
                  text: 'loginWithPhone'.tr,
                  onTap: () {
                    Get.to(() => LoginScreen());
                  },
                  icon: Icon(
                    MdiIcons.phone,
                    color: Colors.black,
                    size: 40,
                  ),
                ),
                SocialButton(
                  text: 'loginWithGoogle'.tr,
                  onTap: () {
                    controller.signInGoogle();
                  },
                  imageAsset: 'src/images/google_login.png',
                ),
                SocialButton(
                  text: 'loginWithApple'.tr,
                  onTap: () {
                    controller.signInApple();
                  },
                  imageAsset: 'src/images/apple_login.png',
                  icon: Icon(
                    MdiIcons.apple,
                    color: Colors.black,
                    size: 40,
                  ),
                ),
                SocialButton(
                  text: 'loginWithFacebook'.tr,
                  onTap: () {
                    controller.signInFacebook();
                  },
                  icon: Icon(
                    MdiIcons.facebook,
                    color: Colors.blue,
                    size: 40,
                  ),
                ),
                SocialButton(
                  text: 'loginWithTwitter'.tr,
                  onTap: () {
                    controller.signInTwitter();
                  },
                  icon: Icon(
                    MdiIcons.twitter,
                    color: Colors.lightBlue,
                    size: 40,
                  ),
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
