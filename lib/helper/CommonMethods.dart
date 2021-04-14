import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sokia_app/helper/Constant.dart';
import 'package:sokia_app/helper/custom_widgets/text/custom_text.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'local_storage.dart';

class CommonMethods {
  showToast({@required String message}) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
    );
  }

  showSnackBar(String message, {IconData iconData = Icons.info}) {
    Get.showSnackbar(
      GetBar(
        backgroundColor: Colors.black,
        messageText: Text(
          message,
          style: TextStyle(fontSize: 14, color: Colors.white),
        ),
        icon: Icon(
          iconData,
          color: Colors.white,
          size: 30,
        ),
        duration: Duration(seconds: 5),
      ),
    );
  }

  showGeneralError() {
    Get.showSnackbar(
      GetBar(
        backgroundColor: Colors.black,
        messageText: Text(
          'error'.tr,
          style: TextStyle(fontSize: 14, color: Colors.white),
        ),
        icon: Icon(
          Icons.error_outline,
          color: Colors.white,
          size: 30,
        ),
        duration: Duration(seconds: 3),
      ),
    );
  }

  showMessage(String title, String body) {
    Get.snackbar(title, body,
        messageText: Text(
          body,
          style: TextStyle(fontSize: 14),
        ),
        titleText: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        snackStyle: SnackStyle.FLOATING,
        snackPosition: SnackPosition.BOTTOM);
  }

  goOffline() {
    Get.showSnackbar(
      GetBar(
        backgroundColor: Colors.red.shade400,
        // title: 'disConnectedTitle'.tr,
        messageText: CustomText(
          text: 'disConnected'.tr,
          color: Colors.white,
        ),
        icon: Icon(
          Icons.perm_scan_wifi_outlined,
          color: Colors.white,
          size: 30,
        ),
        snackPosition: SnackPosition.TOP,
        duration: Duration(seconds: 4),
      ),
    );
  }

  goOnline() {
    Get.showSnackbar(
      GetBar(
        backgroundColor: Colors.green,
        // title: 'connectedTitle'.tr,
        messageText: CustomText(
          text: 'connected'.tr,
          color: Colors.white,
        ),
        icon: Icon(
          Icons.network_wifi,
          color: Colors.white,
          size: 30,
        ),
        snackPosition: SnackPosition.TOP,
        duration: Duration(seconds: 4),
      ),
    );
  }

  showBottomSheet(Widget bottomSheet) {
    Get.bottomSheet(
      bottomSheet,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0),
      ),
    );
  }

  hideKeyboard() {
    FocusScope.of(Get.context).unfocus();
  }

  Widget loadingWithBackground() {
    return GestureDetector(
      onTap: null,
      child: Container(
        color: Colors.black26,
        child: Center(
          child: Container(
            width: MediaQuery.of(Get.context).size.width / 2,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.white),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 20,
                ),
                CircularProgressIndicator(
                  strokeWidth: 3,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'pleaseWait'.tr,
                  style: TextStyle(fontSize: fontSize16),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String getDateStringYMd(int time) {
    initializeDateFormatting();

    var date = DateTime.fromMillisecondsSinceEpoch(time);
    if (LocalStorage().isArabicLanguage()) {
      var formatter = DateFormat.yMd('ar_SA');
      // print(formatter.locale);
      String formatted = formatter.format(date);
      // print(formatted);
      return formatted;
    } else {
      var formatter = DateFormat.yMd();
      // print(formatter.locale);
      String formatted = formatter.format(date);
      // print(formatted);
      return formatted;
    }
  }

  String getDateStringYMdHM(int time) {
    initializeDateFormatting();

    var date = DateTime.fromMillisecondsSinceEpoch(time);
    if (LocalStorage().isArabicLanguage()) {
      var formatter = DateFormat('y/M/d hh:mm a','ar_SA');
      // print(formatter.locale);
      String formatted = formatter.format(date);
      // print(formatted);
      return formatted;
    } else {
      var formatter = DateFormat('y/M/d hh:mm a');
      // print(formatter.locale);
      String formatted = formatter.format(date);
      // print(formatted);
      return formatted;
    }
  }

  String getDateStringHhMmA(int time) {
    initializeDateFormatting();

    var date = DateTime.fromMillisecondsSinceEpoch(time);
    if (LocalStorage().isArabicLanguage()) {
      var formatter = DateFormat('hh:mm a', 'ar_SA');
      // print(formatter.locale);
      String formatted = formatter.format(date);
      // print(formatted);
      return formatted;
    } else {
      var formatter = DateFormat('hh:mm a');
      // print(formatter.locale);
      String formatted = formatter.format(date);
      // print(formatted);
      return formatted;
    }
  }

  String timeAgoSinceDate(int unixDate) {
    initializeDateFormatting();

    var date = DateTime.fromMillisecondsSinceEpoch(unixDate);
    var formatter = DateFormat.yMMMMEEEEd();
    // print(formatter.locale);
    String formattedDate = formatter.format(date);
    // print(formattedDate);

    final date2 = DateTime.now();
    final difference = date2.difference(date);
    if (difference.inDays > 8) {
      return getDateStringYMd(unixDate);
    } else if ((difference.inDays / 7).floor() >= 1) {
      return getDateStringYMd(unixDate);
    } else if (difference.inDays >= 2) {
      return getDateStringYMd(unixDate);
    } else if (difference.inDays >= 1) {
      return getDateStringYMd(unixDate);
    } else if (difference.inHours >= 2) {
      return getDateStringHhMmA(unixDate);
    } else if (difference.inHours >= 1) {
      return getDateStringHhMmA(unixDate);
    } else if (difference.inMinutes >= 2) {
      return getDateStringHhMmA(unixDate);
    } else if (difference.inMinutes >= 1) {
      return getDateStringHhMmA(unixDate);
    } else if (difference.inSeconds >= 3) {
      return getDateStringHhMmA(unixDate);
    } else {
      return getDateStringHhMmA(unixDate);
    }
  }
}
