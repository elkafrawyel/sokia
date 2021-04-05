import 'package:dio/dio.dart';
import 'package:get/get.dart' as getX;
import 'package:sokia_app/controllers/user_controller.dart';
import 'package:sokia_app/helper/CommonMethods.dart';
import 'package:sokia_app/helper/local_storage.dart';
import 'package:sokia_app/screens/home/home_screen.dart';

class LoggingInterceptor extends Interceptor {
  int _maxCharactersPerLine = 200;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print("<-- HTTP -->");
    print("--> ${options.headers}");
    print("--> ${options.method}");
    print("--> ${options.path}");
    print("--> ${options.contentType}");
    print("<-- END HTTP -->");
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print(
        "<-- ${response.statusCode} ${response.requestOptions.method} ${response.requestOptions.path}");
    String responseAsString = response.data.toString();
    if (responseAsString.length > _maxCharactersPerLine) {
      int iterations =
          (responseAsString.length / _maxCharactersPerLine).floor();
      for (int i = 0; i <= iterations; i++) {
        int endingIndex = i * _maxCharactersPerLine + _maxCharactersPerLine;
        if (endingIndex > responseAsString.length) {
          endingIndex = responseAsString.length;
        }
        print(
            responseAsString.substring(i * _maxCharactersPerLine, endingIndex));
      }
    } else {
      print(response.data);
    }

    print("<-- END HTTP");

    return super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    print("<-- Error -->");
    if (err.error.toString().contains('Http status error [401]')) {
      LocalStorage().clear();
      getX.Get.find<UserController>().setUser(null);
      getX.Get.to(() => HomeScreen());
      // CommonMethods().showSnackBar('userNotFount'.tr);
    }
    print(err.error);
    print(err.message);
    super.onError(err, handler);
  }
}
