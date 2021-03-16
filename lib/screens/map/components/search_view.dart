import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sokia_app/helper/Constant.dart';
import 'package:sokia_app/helper/custom_widgets/text/custom_text.dart';

class SearchGoogleMap extends StatelessWidget {
  SearchGoogleMap({
    this.onSubmitted,
    this.onSearchTapped,
  });

  final Function(String value) onSubmitted;
  final Function(String value) onSearchTapped;
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:
          EdgeInsetsDirectional.only(end: 10, start: 10, bottom: 10, top: 50),
      padding: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              onSubmitted: (value) {
                if (value.isNotEmpty) onSubmitted(value);
              },
              style: TextStyle(color: Colors.black, fontSize: 16),
              decoration: InputDecoration(
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                hintText: 'searchGoogleMap'.tr,
                hintStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          TextButton(
            style: TextButton.styleFrom(
              primary: Colors.white,
              onSurface: Colors.grey,
              backgroundColor: Colors.white,
              // side: BorderSide(color: Colors.black, width: 1),
              // shape: const BeveledRectangleBorder(
              //     borderRadius: BorderRadius.all(Radius.circular(10))),
              // shape: const RoundedRectangleBorder(
              //   borderRadius: BorderRadius.all(
              //     Radius.circular(50),
              //   ),
              // ),
            ),
            onPressed: () {
              onSubmitted(controller.text);
            },
            child: CustomText(
              text: 'go'.tr,
              color: kAccentColor,
              fontSize: fontSize16,
              alignment: AlignmentDirectional.center,
            ),
          ),
        ],
      ),
    );
  }
}
