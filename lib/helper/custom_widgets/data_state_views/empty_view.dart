import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sokia_app/helper/Constant.dart';

class EmptyView extends StatelessWidget {
  final String message;
  final EmptyViews emptyViews;
  final Color textColor;

  EmptyView({this.message, this.emptyViews, this.textColor = Colors.white});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _emptyImage(),
          SizedBox(
            height: 20,
          ),
          Text(
            message == null ? 'empty'.tr : message,
            style: TextStyle(fontSize: fontSize16, color: textColor),
            maxLines: 3,
          ),
          SizedBox(
            height: 40,
          ),
        ],
      ),
    );
  }

  Widget _emptyImage() {
    switch (emptyViews) {
      case EmptyViews.Box:
        return Lottie.asset(emptyImageBox,
            width: 200, height: 200, repeat: false);
      case EmptyViews.Face:
        return Lottie.asset(emptyImageFace, repeat: false);
      case EmptyViews.Magnifier:
        return Lottie.asset(emptyImageMagnifier, repeat: true);
        break;
    }
    return Lottie.asset(emptyImageBox, width: 300, height: 300, repeat: false);
  }
}

const emptyImageMagnifier = 'src/json/empty_magnifier.json';
const emptyImageBox = 'src/json/empty_box.json';
const emptyImageFace = 'src/json/empty.json';

enum EmptyViews {
  Box,
  Face,
  Magnifier,
}
