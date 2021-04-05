import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sokia_app/controllers/user_controller.dart';
import 'package:sokia_app/helper/Constant.dart';
import 'package:sokia_app/helper/custom_widgets/text/custom_text.dart';
import 'package:sokia_app/helper/language_screen.dart';
import 'package:sokia_app/screens/about_screen.dart';
import 'package:sokia_app/screens/account_screen.dart';
import 'package:sokia_app/screens/auth/social/social.dart';
import 'package:sokia_app/screens/contact_us.dart';
import 'package:sokia_app/screens/help_screen.dart';
import 'package:sokia_app/screens/rate_app.dart';

class MoreTab extends StatefulWidget {
  @override
  _MoreTabState createState() => _MoreTabState();
}

class _MoreTabState extends State<MoreTab> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'menu'.tr,
          style: Theme.of(context)
              .textTheme
              .headline6
              .copyWith(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Container(
        color: kBackgroundColor,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: GetBuilder<UserController>(
              builder: (controller) => Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      controller.user != null
                          ? Get.to(()=>AccountScreen())
                          : Get.to(()=>SocialLogin());
                    },
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Image.asset(
                            'src/images/logo.png',
                            fit: BoxFit.fill,
                          ),
                          radius: 25,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: GetBuilder<UserController>(
                            builder: (controller) => CustomText(
                              text: controller.user != null
                                  ? controller.user.name
                                  : 'appName'.tr,
                              fontSize: fontSize18,
                              alignment: AlignmentDirectional.centerStart,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      controller.user != null
                          ? Get.to(()=>AccountScreen())
                          : Get.to(()=>SocialLogin());
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            controller.user != null
                                ? 'profile'.tr
                                : 'signIn'.tr,
                            style: TextStyle(
                                fontSize: fontSize14,
                                color: Colors.grey.shade500),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.grey.shade500,
                            size: 20,
                          )
                        ],
                      ),
                    ),
                  ),
                  // _line(),
                  // Padding(
                  //   padding: const EdgeInsets.all(4.0),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: [
                  //       Text(
                  //         'طلب مخصص',
                  //         style: TextStyle(
                  //             fontSize: 14, color: Colors.grey.shade500),
                  //       ),
                  //       Icon(
                  //         Icons.arrow_forward_ios,
                  //         color: Colors.grey.shade500,
                  //         size: 20,
                  //       )
                  //     ],
                  //   ),
                  // ),
                  _line(),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'orderList'.tr,
                          style: TextStyle(
                              fontSize: fontSize14,
                              color: Colors.grey.shade500),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: Colors.white),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              '20',
                              style: TextStyle(
                                  fontSize: fontSize16, color: kPrimaryColor),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // _line(),
                  // GestureDetector(
                  //   onTap: () {
                  //     Get.to(PaymentScreen());
                  //   },
                  //   child: Padding(
                  //     padding: const EdgeInsets.all(8.0),
                  //     child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.start,
                  //       children: [
                  //         Text(
                  //           'payment'.tr,
                  //           style: TextStyle(
                  //               fontSize: 16, color: Colors.grey.shade500),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  _line(),
                  GestureDetector(
                    onTap: () {
                      Get.to(()=>LanguageScreen());
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'language'.tr,
                            style: TextStyle(
                                fontSize: fontSize14,
                                color: Colors.grey.shade500),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.grey.shade500,
                            size: 20,
                          )
                        ],
                      ),
                    ),
                  ),
                  _line(),
                  GestureDetector(
                    onTap: () {
                      Get.to(()=>HelpScreen());
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'help'.tr,
                            style: TextStyle(
                              fontSize: fontSize14,
                              color: Colors.grey.shade500,
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.grey.shade500,
                            size: 20,
                          )
                        ],
                      ),
                    ),
                  ),
                  _line(),
                  GestureDetector(
                    onTap: () {
                      Get.to(()=>AboutScreen());
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'about'.tr,
                            style: TextStyle(
                                fontSize: fontSize14,
                                color: Colors.grey.shade500),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.grey.shade500,
                            size: 20,
                          )
                        ],
                      ),
                    ),
                  ),
                  _line(),
                  GestureDetector(
                    onTap: () {
                      Get.to(()=>RateAppScreen());
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'rate'.tr,
                            style: TextStyle(
                                fontSize: fontSize14,
                                color: Colors.grey.shade500),
                          ),
                        ],
                      ),
                    ),
                  ),
                  _line(),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'share'.tr,
                          style: TextStyle(
                              fontSize: fontSize14,
                              color: Colors.grey.shade500),
                        ),
                      ],
                    ),
                  ),
                  _line(),
                  GestureDetector(
                    onTap: () {
                      Get.to(()=>ContactUsScreen());
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'contactUs'.tr,
                            style: TextStyle(
                                fontSize: fontSize14,
                                color: Colors.grey.shade500),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.grey.shade500,
                            size: 20,
                          )
                        ],
                      ),
                    ),
                  ),
                  Visibility(
                    visible: controller.user != null,
                    child: Column(
                      children: [
                        _line(),
                        GestureDetector(
                          onTap: () {
                            Get.find<UserController>().logOut();
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'logOut'.tr,
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey.shade500),
                                ),
                              ],
                            ),
                          ),
                        ),
                        _line(),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('src/images/facebook.png'),
                      SizedBox(width: 9),
                      Image.asset('src/images/line.png'),
                      SizedBox(width: 9),
                      Image.asset('src/images/twitter.png'),
                      SizedBox(width: 9),
                      Image.asset('src/images/line.png'),
                      SizedBox(width: 9),
                      Image.asset('src/images/instagram.png'),
                      SizedBox(width: 9),
                      Image.asset('src/images/line.png'),
                      SizedBox(width: 9),
                      Image.asset('src/images/whatsapp.png'),
                      SizedBox(width: 9),
                      Image.asset('src/images/line.png'),
                      SizedBox(width: 9),
                      Image.asset('src/images/snapchat.png'),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _line() {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        child: Divider(
          thickness: 0.5,
          color: Colors.grey.shade300,
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
