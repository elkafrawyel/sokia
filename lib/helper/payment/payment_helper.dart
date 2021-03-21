import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sokia_app/api/logging_interceptor.dart';
import 'package:sokia_app/helper/CommonMethods.dart';
import 'package:sokia_app/helper/local_storage.dart';
import 'package:sokia_app/helper/payment/payment_response.dart';

class PaymentHelper {
  String _checkoutId = '';
  static const platform = const MethodChannel('com.sokia.app');

  String _baseUrl = 'https://test.oppwa.com/v1/checkouts';
  String _paymentAccessToken =
      'OGE4Mjk0MTc0ZDA1OTViYjAxNGQwNWQ4MjllNzAxZDF8OVRuSlBjMm45aA==';
  String _entity = '8a8294174d0595bb014d05d82e5b01d2';
  String _developmentMode = 'TEST'; //LIVE
  String _paymentType = 'CD'; // PA DB CD CP RV RF

  Future <String> openPaymentUi(
      {@required Brands brand,
      @required double amount,
      @required Currency currency}) async {
    //  requestCheckoutId();
    BaseOptions options = new BaseOptions(
      headers: {
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $_paymentAccessToken'
      },
      connectTimeout: 10000,
      receiveTimeout: 10000,
    );

    Dio _dio = Dio(options);
    _dio.interceptors.add(LoggingInterceptor());

    //toStringAsFixed(2) to make 200.0 become 200.00
    String myUrl =
        "$_baseUrl?entityId=$_entity&amount=${amount.toStringAsFixed(2)}&currency=${currency.value}&paymentType=$_paymentType";

    final response = await _dio.post(
      myUrl,
    );

    PaymentResponse paymentResponse = PaymentResponse.fromJson(response.data);

    if (paymentResponse.result.parameterErrors == null) {
      //Success

      _checkoutId = paymentResponse.id;

      String transactionStatus;
      try {
        print('Sokia checkoutId : $_checkoutId');
        print('Sokia method : ${brand.value}');
        final String result = await platform.invokeMethod('getPaymentMethod', {
          "developmentMode": _developmentMode,
          "checkoutId": _checkoutId,
          "brand": brand.value,
          "language": LocalStorage().isArabicLanguage() ? "ar" : "en" //ar en
        });
        transactionStatus = '$result';
      } on PlatformException catch (e) {
        transactionStatus = "${e.message}";
      }
      return transactionStatus;
    }else{
      return null;
    }
  }

// Future<void> getPaymentStatus() async {
//   BaseOptions options = new BaseOptions(
//     headers: {
//       HttpHeaders.acceptHeader: 'application/json',
//     },
//     connectTimeout: 10000,
//     receiveTimeout: 10000,
//   );
//
//   Dio _dio = Dio(options);
//
//   var status;
//
//   String myUrl =
//       "http://dev.hyperpay.com/hyperpay-demo/getpaymentstatus.php?id=$_checkoutId";
//   final response = await _dio.post(
//     myUrl,
//   );
//   status = response.data.contains('error');
//
//   var data = json.decode(response.data);
//
//   print("payment_status: ${data["result"].toString()}");
//
//   print(data["result"].toString());
// }
}

enum Currency {
  USD, // United States
  AED, // United Arab Emirates
  EGP, // Egypt
  JOD, // Jordan
  KWD, // Kuwait
  QAR, // Qatar
  SAR, // Saudi Arabia
}

extension CurrencyExtension on Currency {
  String get value {
    switch (this) {
      case Currency.USD:
        return 'USD';
      case Currency.AED:
        return 'AED';
      case Currency.EGP:
        return 'EGP';
      case Currency.JOD:
        return 'JOD';
      case Currency.KWD:
        return 'KWD';
      case Currency.QAR:
        return 'QAR';
      case Currency.SAR:
        return 'SAR';

      default:
        return null;
    }
  }
}

enum Brands {
  Visa,
  Mada,
  MasterCard,
  PAYPAL,
  Apple,
  Google,
}

extension BrandsExtension on Brands {
  String get value {
    switch (this) {
      case Brands.Visa:
        return 'VISA';
      case Brands.Mada:
        return 'MADA';
      case Brands.PAYPAL:
        return 'PAYPAL';
      case Brands.MasterCard:
        return 'MASTER';
      case Brands.Apple:
        return 'apple';
      case Brands.Google:
        return 'google';
      default:
        return null;
    }
  }
}
