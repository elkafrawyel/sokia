import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sokia_app/controllers/auth_controller.dart';
import 'package:sokia_app/helper/CommonMethods.dart';
import 'package:sokia_app/helper/Constant.dart';
import 'package:sokia_app/helper/custom_widgets/custom_button.dart';
import 'package:sokia_app/helper/custom_widgets/text/custom_outline_text_form_field.dart';
import 'package:sokia_app/helper/custom_widgets/text/custom_text.dart';
import 'package:sokia_app/screens/auth/register/register_screen.dart';

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
final TextEditingController phoneController = TextEditingController();
final TextEditingController passwordController = TextEditingController();

class LoginScreen extends StatelessWidget {
  final controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        toolbarHeight: 0.0,
        brightness: Brightness.dark,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
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
                  Padding(
                    padding: EdgeInsetsDirectional.only(
                        top: 10, start: 20, end: 20, bottom: 10),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          CustomOutlinedTextFormField(
                            text: 'phone'.tr,
                            controller: phoneController,
                            hintText: 'phone'.tr,
                            maxLines: 1,
                            labelText: 'phone'.tr,
                            // suffixText: '+966',
                            validateEmptyText: 'phoneIsEmpty'.tr,
                            keyboardType: TextInputType.phone,
                            labelColor: Colors.black,
                            hintColor: Colors.black,
                            textColor: Colors.black,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          CustomOutlinedTextFormField(
                            text: 'password'.tr,
                            controller: passwordController,
                            hintText: '***********',
                            isPassword: true,
                            maxLines: 1,
                            labelText: 'password'.tr,
                            validateEmptyText: 'passwordIsEmpty'.tr,
                            keyboardType: TextInputType.text,
                            labelColor: Colors.black,
                            hintColor: Colors.black,
                            textColor: Colors.black,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            height: 50,
                            width: MediaQuery.of(context).size.width,
                            child: CustomButton(
                              text: 'signIn'.tr,
                              colorText: Colors.white,
                              colorBackground: kPrimaryColor,
                              onPressed: () {
                                _login();
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.only(
                      start: 20,
                      end: 20,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'forgetPassword'.tr,
                          style: TextStyle(
                              fontSize: 14,
                              color: kAccentColor,
                              decoration: TextDecoration.underline),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.to(() => RegisterScreen());
                          },
                          child: Text(
                            'signUp'.tr,
                            style: TextStyle(
                                fontSize: 14,
                                color: kAccentColor,
                                decoration: TextDecoration.underline),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            GetBuilder<AuthController>(
              dispose: (state) {
                phoneController.text = '';
                passwordController.text = '';
              },
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

  void _login() {
    if (_formKey.currentState.validate()) {
      FocusScope.of(Get.context).unfocus();
      _formKey.currentState.save();
      controller.login(
          phone: phoneController.text, password: passwordController.text);
    }
    // controller.login(phone: '1122468456', password: '123456');
  }
}
