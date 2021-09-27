import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sokia_app/helper/Constant.dart';
import 'package:sokia_app/helper/get_binding.dart';
import 'package:sokia_app/helper/language/Translation.dart';
import 'package:sokia_app/screens/home/home_screen.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      smartManagement: SmartManagement.onlyBuilder,
      defaultTransition: Transition.size,
      transitionDuration: Duration(milliseconds: 500),
      translations: Translation(),
      initialBinding: GetBinding(),
      locale: Locale('en'),
      fallbackLocale: Locale('en'),
      theme: ThemeData(
          textTheme: GoogleFonts.tajawalTextTheme(
            Theme.of(context).textTheme,
          ),
          primaryTextTheme: TextTheme(
            caption: TextStyle(
              fontSize: 14,
              color: Colors.black,
            ),
            headline6: TextStyle(
              fontSize: 16,
              color: Colors.black,
            ),
            headline5: TextStyle(
              fontSize: 20,
              color: Colors.black,
            ),
          ),
          primaryColor: kPrimaryColor,
          colorScheme:
              Theme.of(context).colorScheme.copyWith(secondary: kAccentColor)),
      home: HomeScreen(),
    );
  }
}
