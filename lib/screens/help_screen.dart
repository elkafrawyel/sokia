import 'package:expandable_group/expandable_group.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sokia_app/controllers/general_controller.dart';
import 'package:sokia_app/helper/Constant.dart';
import 'package:sokia_app/helper/custom_widgets/main_screen.dart';
import 'package:sokia_app/helper/custom_widgets/text/custom_text.dart';
import 'package:sokia_app/helper/local_storage.dart';

class HelpScreen extends StatelessWidget {
  final controller = Get.put(GeneralController());

  HelpScreen() {
    controller.getHelpList();
  }

  @override
  Widget build(BuildContext context) {
    return MainScreen(
      title: 'help'.tr,
      pageBackground: kBackgroundColor,
      body: Container(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  elevation: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(
                          'src/images/about.png',
                          fit: BoxFit.fill,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: CustomText(
                          fontSize: fontSize16,
                          text: 'أهلا بك ,كيف يمكننا مساعدتك ؟',
                          alignment: AlignmentDirectional.center,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  elevation: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsetsDirectional.only(
                            start: 20, top: 20),
                        child: CustomText(
                          fontSize: fontSize16,
                          text: 'محادثة فورية',
                          alignment: AlignmentDirectional.centerStart,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Divider(
                          thickness: 1,
                        ),
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset(
                              'src/images/support.png',
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                CustomText(
                                  fontSize: fontSize16,
                                  text: 'خدمة العملاء',
                                  alignment: AlignmentDirectional.centerStart,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: CustomText(
                                    fontSize: fontSize16,
                                    text: 'أهلا بك ,كيف يمكننا مساعدتك ؟',
                                    color: Colors.grey.shade500,
                                    alignment: AlignmentDirectional.centerStart,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                GetBuilder<GeneralController>(
                  init: GeneralController(),
                  builder: (controller) => controller.loading
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : Card(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0)),
                          elevation: 3,
                          shadowColor: Colors.grey,
                          child: Column(
                            children: controller.helpList.map((question) {
                              return ExpandableGroup(
                                headerBackgroundColor: Colors.white,
                                collapsedIcon: Icon(
                                  LocalStorage().isArabicLanguage()
                                      ? Icons.keyboard_arrow_left
                                      : Icons.keyboard_arrow_right,
                                ),
                                expandedIcon: Icon(Icons.keyboard_arrow_down),
                                header: _header(question.title),
                                items: _buildItems(context, [question.body]),
                                headerEdgeInsets:
                                    EdgeInsets.only(left: 16.0, right: 16.0),
                              );
                            }).toList(),
                          ),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _header(String title) => CustomText(
        text: title,
        fontSize: fontSize16,
        color: Colors.black,
        maxLines: 2,
      );

  List<ListTile> _buildItems(BuildContext context, List<String> items) => items
      .map(
        (e) => ListTile(
          tileColor: kBackgroundColor,
          title: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomText(
              text: e,
              fontSize: fontSize16,
              color: Colors.grey.shade700,
              maxLines: 100,
            ),
          ),
        ),
      )
      .toList();
}
