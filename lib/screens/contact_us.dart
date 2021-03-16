import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sokia_app/controllers/general_controller.dart';
import 'package:sokia_app/controllers/main_controller.dart';
import 'package:sokia_app/controllers/user_controller.dart';
import 'package:sokia_app/helper/Constant.dart';
import 'package:sokia_app/helper/custom_widgets/custom_button.dart';
import 'package:sokia_app/helper/custom_widgets/main_screen.dart';
import 'package:sokia_app/helper/custom_widgets/text/custom_outline_text_form_field.dart';
import 'package:sokia_app/helper/custom_widgets/text/custom_text.dart';

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
final TextEditingController titleController = TextEditingController();
final TextEditingController emailController = TextEditingController();
final TextEditingController bodyController = TextEditingController();

class ContactUsScreen extends StatelessWidget {
  final controller = Get.put(GeneralController());

  @override
  Widget build(BuildContext context) {
    if (Get.find<UserController>().user != null) {
      emailController.text = Get.find<UserController>().user.email;
    }

    return MainScreen(
      title: 'contactUs'.tr,
      pageBackground: kBackgroundColor,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                GetBuilder<MainController>(
                  builder: (controller) => Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Image.asset(
                          'src/images/logo.png',
                          width: 100,
                          height: 100,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width / 2.3,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextButton.icon(
                                      icon: Image.asset(
                                        'src/images/whatsapp_contact.png',
                                      ),
                                      style: TextButton.styleFrom(
                                        primary: Colors.white,
                                        backgroundColor: Colors.grey.shade300,
                                        onSurface: Colors.grey,
                                        elevation: 5,
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))),
                                      ),
                                      onPressed: () {},
                                      label: CustomText(
                                        fontSize: 12,
                                        text: 'whatsAppCall'.tr,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width / 2.3,
                                child: TextButton.icon(
                                  icon: Image.asset(
                                    'src/images/direct_call.png',
                                  ),
                                  style: TextButton.styleFrom(
                                    primary: Colors.white,
                                    backgroundColor: Colors.grey.shade300,
                                    onSurface: Colors.grey,
                                    elevation: 5,
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                  ),
                                  onPressed: () {},
                                  label: CustomText(
                                    fontSize: 12,
                                    text: 'directCall'.tr,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.only(
                              start: 20, end: 20, bottom: 20),
                          child: CustomOutlinedTextFormField(
                            text: 'email'.tr,
                            controller: emailController,
                            hintText: 'email'.tr,
                            labelText: 'email'.tr,
                            keyboardType: TextInputType.text,
                            validateEmptyText: 'requiredField'.tr,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.only(
                              start: 20, end: 20, bottom: 20),
                          child: CustomOutlinedTextFormField(
                            text: 'title'.tr,
                            controller: titleController,
                            hintText: 'title'.tr,
                            labelText: 'title'.tr,
                            keyboardType: TextInputType.text,
                            validateEmptyText: 'requiredField'.tr,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.only(
                              start: 20, end: 20),
                          child: CustomOutlinedTextFormField(
                            text: 'description'.tr,
                            controller: bodyController,
                            hintText: 'description'.tr,
                            labelText: 'description'.tr,
                            maxLines: 6,
                            validateEmptyText: 'requiredField'.tr,
                            keyboardType: TextInputType.text,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.only(
                              start: 20, end: 20),
                          child: Container(
                            height: 50,
                            width: MediaQuery.of(context).size.width,
                            child: CustomButton(
                              text: 'confirm'.tr,
                              onPressed: () {
                                _contactUs();
                              },
                              fontSize: fontSize16,
                              colorText: Colors.white,
                              colorBackground: kPrimaryColor,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          GetBuilder<GeneralController>(
            init: GeneralController(),
            dispose: (value) {
              emailController.text = '';
              titleController.text = '';
              bodyController.text = '';
            },
            builder: (controller) => Visibility(
              visible: controller.loading,
              child: Container(
                alignment: AlignmentDirectional.center,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  _contactUs() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      controller.contactUs(
        email: emailController.text,
        title: titleController.text,
        body: bodyController.text,
      );
    }
  }
}
