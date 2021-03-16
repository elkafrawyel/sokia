import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:get/get.dart';
import 'package:pin_entry_field/pin_entry_field.dart';
import 'package:pin_entry_field/pin_entry_style.dart';
import 'package:pin_entry_field/pin_input_type.dart';
import 'package:sokia_app/helper/Constant.dart';
import 'package:sokia_app/helper/custom_widgets/custom_button.dart';
import 'package:sokia_app/helper/custom_widgets/main_screen.dart';
import 'package:sokia_app/helper/custom_widgets/text/custom_text.dart';
import 'package:sokia_app/screens/home/home_screen.dart';

class VerifyPhoneScreen extends StatefulWidget {
  final String phone;

  const VerifyPhoneScreen({Key key, @required this.phone}) : super(key: key);

  @override
  _VerifyPhoneScreenState createState() => _VerifyPhoneScreenState();
}

class _VerifyPhoneScreenState extends State<VerifyPhoneScreen> {
  final TextEditingController codeController = TextEditingController();
  bool codeSent = false;

  @override
  Widget build(BuildContext context) {
    int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 180;
    CountdownTimerController controller = CountdownTimerController(
      endTime: endTime,
    );

    return MainScreen(
      title: 'verifyPhone'.tr,
      pageBackground: kBackgroundColor,
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                CustomText(
                  text: 'code'.tr,
                  fontSize: fontSize18,
                  alignment: AlignmentDirectional.center,
                ),
                SizedBox(
                  height: 10,
                ),
                CustomText(
                  text: 'enterCode'.tr,
                  fontSize: fontSize14,
                  color: Colors.grey.shade500,
                  alignment: AlignmentDirectional.center,
                ),
                SizedBox(
                  height: 20,
                ),
                CustomText(
                  text: widget.phone,
                  fontSize: fontSize18,
                  color: kPrimaryColor,
                  alignment: AlignmentDirectional.center,
                ),
                SizedBox(
                  height: 20,
                ),
                PinEntryField(
                  inputType: PinInputType.none,
                  pinInputCustom: "*",
                  onSubmit: (text) {
                    codeController.text = text;
                  },
                  fieldCount: 4,
                  fieldWidth: 60,
                  height: 60,
                  fieldStyle: PinEntryStyle(
                      textStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                      fieldBorder: Border.all(color: Colors.black, width: 0.5),
                      fieldBorderRadius: BorderRadius.circular(5),
                      fieldPadding: 10),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomText(
                      text: 'reSendAfter'.tr,
                      color: Colors.grey,
                      alignment: AlignmentDirectional.center,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    CountdownTimer(
                      controller: controller,
                      widgetBuilder: (_, CurrentRemainingTime time) {
                        if (time == null) {
                          return CustomButton(
                            text: 'reSend'.tr,
                            fontSize: 12,
                            colorBackground: kPrimaryColor,
                            colorText: Colors.white,
                            onPressed: () {
                              //start timer and send code
                              setState(() {
                                controller.start();
                              });
                            },
                          );
                        }
                        return Text(
                            '${_getNumberAddZero(time.min ?? 0)} : ${_getNumberAddZero(time.sec ?? 0)}');
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: 40,
                ),
                Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  child: CustomButton(
                    text: 'confirm'.tr,
                    colorBackground: kPrimaryColor,
                    colorText: Colors.white,
                    fontSize: 18,
                    onPressed: () {
                      _sendCode();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// 1 -> 01
  String _getNumberAddZero(int number) {
    if (number < 10) {
      return "0" + number.toString();
    }
    return number.toString();
  }

  _sendCode() {
    Get.offAll(() => HomeScreen());
    if (codeController.text.isNotEmpty) {}
  }
}
