import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class LoadingView extends StatelessWidget {
  final Color backgroundColor;
  final LoadingViews loadingViews;

  LoadingView({this.backgroundColor = Colors.white, this.loadingViews});

  @override
  Widget build(BuildContext context) {
    return _loadingImage();
  }

  Widget _loadingImage() {
    switch (loadingViews) {
      case LoadingViews.Circle:
        return Container(
          height: MediaQuery.of(Get.context).size.height,
          width: MediaQuery.of(Get.context).size.width,
          child: Center(
            child: Lottie.asset(loadingImage),
          ),
        );
        break;
      case LoadingViews.FullScreen:
        return Lottie.asset(
          loadingFullScreenImage,
          fit: BoxFit.fill,
          height: MediaQuery.of(Get.context).size.height,
          width: MediaQuery.of(Get.context).size.width,
        );
        break;
      case LoadingViews.Dots:
        return Lottie.asset(
          loadingDotsImage,
          fit: BoxFit.fill,
          height: MediaQuery.of(Get.context).size.height,
          width: MediaQuery.of(Get.context).size.width,
        );
    }
    return Container(
      height: MediaQuery.of(Get.context).size.height,
      width: MediaQuery.of(Get.context).size.width,
      child: Center(
        child: Lottie.asset(loadingImage),
      ),
    );
  }
}

enum LoadingViews { Circle, FullScreen, Dots }
const loadingImage = 'src/json/loading.json';
const loadingFullScreenImage = 'src/json/loading_full_screen.json';
const loadingDotsImage = 'src/json/loading_dots.json';
