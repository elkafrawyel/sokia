import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sokia_app/helper/Constant.dart';

import '../custom_button.dart';

class NetworkView extends StatelessWidget {
  final Function onPress;

  NetworkView({this.onPress});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        color: Colors.white,
        height: 400,
        width: MediaQuery.of(context).size.width * 0.8,
        alignment: AlignmentDirectional.center,
        child: Stack(
          children: [
            Lottie.asset(noNetworkImage,
                fit: BoxFit.contain,
                height: 400,
                width: MediaQuery.of(context).size.width,
                options: LottieOptions(enableMergePaths: true)),
            Container(
              alignment: AlignmentDirectional.topCenter,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'noNetwork'.tr,
                  style: TextStyle(fontSize: fontSize18, color: Colors.black),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Container(
                alignment: AlignmentDirectional.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width / 3,
                    child: CustomButton(
                        text: 'retry'.tr,
                        colorText: Colors.white,
                        colorBackground: kPrimaryColor,
                        onPressed: () {
                          onPress.call();
                        }),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}

const noNetworkImage = 'src/json/no_internet.json';
