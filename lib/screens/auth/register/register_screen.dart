import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sokia_app/controllers/auth_controller.dart';
import 'package:sokia_app/helper/CommonMethods.dart';
import 'package:sokia_app/helper/Constant.dart';
import 'package:sokia_app/helper/custom_widgets/custom_button.dart';
import 'package:sokia_app/helper/custom_widgets/text/custom_outline_text_form_field.dart';
import 'package:sokia_app/helper/custom_widgets/text/custom_text.dart';

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
final TextEditingController nameController = TextEditingController();
final TextEditingController phoneController = TextEditingController();
final TextEditingController emailController = TextEditingController();
final TextEditingController passwordController = TextEditingController();

class RegisterScreen extends StatelessWidget {
  final controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        leading: BackButton(color: Colors.black,),
        backgroundColor: Colors.white,
        // toolbarHeight: 0.0,
                elevation: 0.0,

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
                        start: 20, end: 20, bottom: 10),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          CustomOutlinedTextFormField(
                            text: 'name'.tr,
                            controller: nameController,
                            hintText: 'name'.tr,
                            maxLines: 1,
                            labelText: 'name'.tr,
                            validateEmptyText: 'nameIsEmpty'.tr,
                            keyboardType: TextInputType.text,
                            labelColor: Colors.black,
                            hintColor: Colors.black,
                            textColor: Colors.black,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          CustomOutlinedTextFormField(
                            text: 'email'.tr,
                            controller: emailController,
                            hintText: 'email'.tr,
                            maxLines: 1,
                            labelText: 'email'.tr,
                            validateEmptyText: 'emailIsEmpty'.tr,
                            keyboardType: TextInputType.emailAddress,
                            labelColor: Colors.black,
                            hintColor: Colors.black,
                            textColor: Colors.black,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          CustomOutlinedTextFormField(
                            text: 'phone'.tr,
                            controller: phoneController,
                            hintText: 'phone'.tr,
                            // suffixText: '00966',
                            maxLines: 1,
                            labelText: 'phone'.tr,
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
                            isPassword: true,
                            controller: passwordController,
                            hintText: '**********',
                            maxLines: 1,
                            labelText: 'password'.tr,
                            validateEmptyText: 'passwordIsEmpty'.tr,
                            keyboardType: TextInputType.visiblePassword,
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
                              text: 'signUp'.tr,
                              colorText: Colors.white,
                              colorBackground: kPrimaryColor,
                              onPressed: () {
                                _register();
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            GetBuilder<AuthController>(
              dispose: (state) {
                nameController.text = '';
                emailController.text = '';
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

  void _register() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      controller.register(
        name: nameController.text,
        email: emailController.text,
        phone: phoneController.text,
        password: passwordController.text,
      );
    }

    // controller.register(
    //   name: 'mahmoud',
    //   email: 'mahmoud@gmail.com',
    //   phone: '123456789',
    //   password: '123456',
    // );
  }
}
