import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sokia_app/controllers/user_controller.dart';
import 'package:sokia_app/helper/CommonMethods.dart';
import 'package:sokia_app/helper/Constant.dart';
import 'package:sokia_app/helper/custom_widgets/custom_button.dart';
import 'package:sokia_app/helper/custom_widgets/main_screen.dart';
import 'package:sokia_app/helper/custom_widgets/text/custom_outline_text_form_field.dart';
import 'package:sokia_app/helper/custom_widgets/text/custom_text.dart';

final TextEditingController passwordController = TextEditingController();
final TextEditingController newPasswordController = TextEditingController();
final TextEditingController confirmNewPasswordController =
    TextEditingController();
final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

class ChangePasswordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MainScreen(
      title: 'changePassword'.tr,
      pageBackground: kBackgroundColor,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
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
                      CustomOutlinedTextFormField(
                        text: 'newPassword'.tr,
                        controller: newPasswordController,
                        hintText: '***********',
                        isPassword: true,
                        maxLines: 1,
                        labelText: 'newPassword'.tr,
                        validateEmptyText: 'passwordIsEmpty'.tr,
                        keyboardType: TextInputType.text,
                        labelColor: Colors.black,
                        hintColor: Colors.black,
                        textColor: Colors.black,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      CustomOutlinedTextFormField(
                        text: 'confirmNewPassword'.tr,
                        controller: confirmNewPasswordController,
                        hintText: '***********',
                        isPassword: true,
                        maxLines: 1,
                        labelText: 'confirmNewPassword'.tr,
                        validateEmptyText: 'passwordIsEmpty'.tr,
                        keyboardType: TextInputType.text,
                        labelColor: Colors.black,
                        hintColor: Colors.black,
                        textColor: Colors.black,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CustomText(
                        text: 'forgetPassword'.tr,
                        color: kPrimaryColor,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        child: CustomButton(
                          text: 'change'.tr,
                          colorText: Colors.white,
                          colorBackground: kPrimaryColor,
                          onPressed: () {
                            _confirm();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            GetBuilder<UserController>(
              dispose: (state) {
                newPasswordController.text = '';
                confirmNewPasswordController.text = '';
                passwordController.text = '';
              },
              builder: (controller) => Container(
                alignment: AlignmentDirectional.center,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
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

  void _confirm() {
    if (_formKey.currentState.validate()) {
      FocusScope.of(Get.context).unfocus();

      if (newPasswordController.text != confirmNewPasswordController.text) {
        CommonMethods().showSnackBar('passwordMismatch'.tr);
        return;
      }

      _formKey.currentState.save();
      Get.find<UserController>().changePassword(
        oldPassword: passwordController.text,
        newPassword: newPasswordController.text,
        confirmNewPassword: confirmNewPasswordController.text,
      );
    }
  }
}
