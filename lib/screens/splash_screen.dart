import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'home/home_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 3), () => Get.off(() => HomeScreen()));

    return Scaffold(
      body: Image.asset(
        'src/images/splash.png',
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        fit: BoxFit.cover,
      ),
    );
  }
}
