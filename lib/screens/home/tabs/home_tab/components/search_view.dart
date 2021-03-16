import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sokia_app/controllers/home_controller.dart';
import 'package:sokia_app/helper/Constant.dart';

class SearchView extends StatelessWidget {
  SearchView({
    this.onSubmitted,
    this.onSearchTapped,
    this.onChanged,
  });

  final Function(String value) onSubmitted;
  final Function(String value) onChanged;
  final Function(String value) onSearchTapped;
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    controller.text = Get.find<HomeController>().searchQuery.value;
    return Container(
      margin:
          EdgeInsetsDirectional.only(end: 10, start: 10, bottom: 10, top: 20),
      padding: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        controller: controller,
        onSubmitted: (value) => onSubmitted(value),
        onChanged: (value) => onChanged(value),
        style: TextStyle(color: Colors.black, fontSize: 16),
        decoration: InputDecoration(
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          icon: GestureDetector(
            onTap: () {
              if (controller.text.isNotEmpty) onSubmitted(controller.text);
            },
            child: Icon(
              Icons.search,
              color: kPrimaryColor,
              size: 30,
            ),
          ),
          hintText: 'search'.tr,
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
