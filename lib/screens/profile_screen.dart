import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sokia_app/controllers/user_controller.dart';
import 'package:sokia_app/helper/CommonMethods.dart';
import 'package:sokia_app/helper/Constant.dart';
import 'package:sokia_app/helper/custom_widgets/custom_button.dart';
import 'package:sokia_app/helper/custom_widgets/text/custom_outline_text_form_field.dart';

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
final TextEditingController nameController = TextEditingController();
final TextEditingController phoneController = TextEditingController();
final TextEditingController emailController = TextEditingController();

class ProfileScreen extends StatelessWidget {
  final controller = Get.find<UserController>();

  _setProfileData() {
    nameController.text = controller.user.name;
    emailController.text = controller.user.email;
    phoneController.text = controller.user.phone;
  }

  @override
  Widget build(BuildContext context) {
    _setProfileData();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'profile'.tr,
          style: Theme.of(context)
              .textTheme
              .headline6
              .copyWith(color: Colors.white),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              icon: Icon(
                Icons.edit,
                color: Colors.white,
                size: 30,
              ),
              onPressed: () {
                controller.startEditingProfile();
              },
            ),
          )
        ],
        centerTitle: true,
        brightness: Brightness.dark,
      ),
      backgroundColor: kBackgroundColor,
      body: SingleChildScrollView(
        child: GetBuilder<UserController>(
          dispose: (state) {
            nameController.text = '';
            phoneController.text = '';
            emailController.text = '';
          },
          builder: (controller) => Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
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
                        enabled: controller.editing,
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
                        enabled: controller.editing,
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
                        maxLines: 1,
                        labelText: 'phone'.tr,
                        enabled: controller.editing,
                        validateEmptyText: 'phoneIsEmpty'.tr,
                        keyboardType: TextInputType.phone,
                        labelColor: Colors.black,
                        hintColor: Colors.black,
                        textColor: Colors.black,
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Visibility(
                        visible: controller.editing,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 50,
                              width: MediaQuery.of(context).size.width / 3,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CustomButton(
                                  text: 'save'.tr,
                                  colorText: Colors.white,
                                  colorBackground: kPrimaryColor,
                                  onPressed: () {
                                    _editProfile();
                                  },
                                ),
                              ),
                            ),
                            Container(
                              height: 50,
                              width: MediaQuery.of(context).size.width / 3,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CustomButton(
                                  text: 'cancel'.tr,
                                  colorText: Colors.white,
                                  colorBackground: kPrimaryColor,
                                  onPressed: () {
                                    _setProfileData();
                                    controller.cancelEditingProfile();
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                alignment: AlignmentDirectional.center,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Visibility(
                  visible: controller.loading,
                  child: CommonMethods().loadingWithBackground(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _editProfile() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      controller.editProfile(
        name: nameController.text,
        email: emailController.text,
        phone: phoneController.text,
      );
    }
  }
}
