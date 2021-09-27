import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sokia_app/api/logging_interceptor.dart';
import 'package:sokia_app/helper/CommonMethods.dart';
import 'package:sokia_app/helper/local_storage.dart';
import 'package:sokia_app/helper/payment/payment_response.dart';
import 'package:sokia_app/helper/payment/payment_status_response.dart';

class PaymentApi {
  String _checkoutId;

  static const platform = const MethodChannel('com.sokia.app');

  String _baseUrl = 'https://test.oppwa.com/v1/checkouts';
  String _paymentAccessToken =
      'OGFjN2E0Y2E3MjE4NWU0ZjAxNzIzMTZlNmEyYjU1Njd8N3NzNkdFMjhUeg==';
  String _entity = '8ac7a4ca72185e4f0172316eba32556b';
  String _madaEntity = '8ac7a4c873fb7f860173fc76c18f0279';
  String _merchantTransactionId = LocalStorage().getString(LocalStorage.token);
  String _testMode = 'EXTERNAL';

  String _developmentMode = 'TEST'; //LIVE
  String _paymentType = 'DB'; // PA DB CD CP RV RF

  //returns checkout Id
  Future<String> openPaymentUi(
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
    String _amount = amount.toStringAsFixed(2);
    String _entityId = brand == Brands.Mada ? _madaEntity : _entity;

    String myUrl = "$_baseUrl?" +
        "entityId=$_entityId" +
        "&amount=$_amount" +
        "&currency=${currency.value}" +
        "&paymentType=$_paymentType" +
        "&merchantTransactionId=$_merchantTransactionId" +
        "&testMode=$_testMode";

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

        if (transactionStatus != null && transactionStatus == "true") {
          print('Sokia transactionStatus ----> $transactionStatus');

          if (_checkoutId != null) {
            bool isCompleted = await getPaymentStatus(_checkoutId);
            if (isCompleted) {
              {
                CommonMethods().showToast(
                    message: LocalStorage().isArabicLanguage()
                        ? 'تمت عملية الدفع بنجاح'
                        : 'Payment Completed Successfully');
                return _checkoutId;
              }
            } else {
              CommonMethods().showToast(
                  message: LocalStorage().isArabicLanguage()
                      ? 'عملية الدفع لم تكتمل'
                      : 'Payment Failed');
              return null;
            }
          }
        } else if (transactionStatus == "cancelled") {
          CommonMethods().showToast(
              message: LocalStorage().isArabicLanguage()
                  ? 'تم الغاء العملية'
                  : 'Payment Cancelled');

          print('Sokia transactionStatus ----> $transactionStatus');

          return null;
        } else if (transactionStatus.contains("false")) {
          //remove false from string
          CommonMethods().showToast(
              message: LocalStorage().isArabicLanguage()
                  ? 'عملية الدفع لم تكتمل'
                  : 'Payment Failed');

          //error
          print('Sokia transactionStatus ----> $transactionStatus');
          return null;
        }
      } on PlatformException catch (e) {
        transactionStatus = "${e.message}";
        CommonMethods().showToast(
            message: LocalStorage().isArabicLanguage()
                ? 'عملية الدفع لم تكتمل'
                : 'Payment Failed');

        return null;
      }
      return null;
    } else {
      CommonMethods().showToast(
          message: LocalStorage().isArabicLanguage()
              ? 'عملية الدفع لم تكتمل'
              : 'Payment Failed');
      return null;
    }
  }

  //return if completed or not
  Future<bool> getPaymentStatus(String checkoutID) async {
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

    String myUrl = "https://test.oppwa.com/v1/checkouts/$checkoutID/payment?entityId=$_entity";
    final response = await _dio.get(
      myUrl,
    );
    PaymentStatusResponse paymentStatusResponse =
        PaymentStatusResponse.fromJson(response.data);

    if (paymentStatusResponse.result.parameterErrors == null) {
      if (paymentStatusResponse.result.code == '000.100.112') {
        print(
            "payment_status: ${paymentStatusResponse.result.description.toString()}");
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }
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
