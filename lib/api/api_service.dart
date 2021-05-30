import 'dart:io';

import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:images_picker/images_picker.dart';
import 'package:sokia_app/data/data_models/create_order_request.dart';
import 'package:sokia_app/data/responses/about_app_response.dart';
import 'package:sokia_app/data/responses/auth_response.dart';
import 'package:sokia_app/data/responses/conditions_response.dart';
import 'package:sokia_app/data/responses/help_response.dart';
import 'package:sokia_app/data/responses/home_response.dart';
import 'package:sokia_app/data/responses/info_response.dart';
import 'package:sokia_app/data/responses/messages_response.dart';
import 'package:sokia_app/data/responses/my_orders_response.dart';
import 'package:sokia_app/data/responses/notifications_response.dart';
import 'package:sokia_app/data/responses/send_message_response.dart';
import 'package:sokia_app/data/responses/static_data_response.dart';
import 'package:sokia_app/helper/CommonMethods.dart';
import 'package:sokia_app/helper/data_states.dart';
import 'package:sokia_app/helper/local_storage.dart';

import 'logging_interceptor.dart';

class ApiService {
  Future<Dio> _getDioClient() async {
    var language = LocalStorage().getLanguage();
    var apiToken = LocalStorage().getString(LocalStorage.token);
    var uuid = await LocalStorage().getUuid();
    BaseOptions options = new BaseOptions(
      baseUrl: "https://madheef.com/water/api/",
      headers: {
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.cacheControlHeader: 'no-Cache',
        HttpHeaders.acceptLanguageHeader: language,
        HttpHeaders.authorizationHeader: 'Bearer $apiToken',
        'uuid': uuid,
      },
      connectTimeout: 50000,
      receiveTimeout: 50000,
    );

    Dio _dio = Dio(options);
    _dio.interceptors.add(LoggingInterceptor());

    return _dio;
  }

  Future<bool> _checkNetwork() async {
    switch (await DataConnectionChecker().connectionStatus) {
      case DataConnectionStatus.disconnected:
        return false;
      case DataConnectionStatus.connected:
        return true;
      default:
        return false;
    }
  }

  getHomeData({Function(DataState dataState) state}) async {
    if (await _checkNetwork()) {
      try {
        Response response = await (await _getDioClient()).get(
          "/homePage",
        );

        if (response.statusCode == 200) {
          HomeResponse homeResponse = HomeResponse.fromJson(response.data);
          if (homeResponse.status) {
            state(SuccessState(homeResponse));
          } else {
            state(ErrorState());
          }
        } else {
          CommonMethods().showGeneralError();
          state(ErrorState());
        }
      } on DioError catch (ex) {
        CommonMethods().showGeneralError();
        state(ErrorState());
      }
    } else {
      state(NoConnectionState());
    }
  }

  register({
    @required String name,
    @required String email,
    @required String phone,
    @required String password,
    @required Function(DataState dataState) state,
  }) async {
    if (await _checkNetwork()) {
      try {
        Response response = await (await _getDioClient()).post(
          "/register",
          data: {
            "name": name,
            "email": email,
            "phone": phone,
            "password": password,
            "confirmPassword": password,
          },
        );

        if (response.statusCode == 200) {
          AuthResponse authResponse = AuthResponse.fromJson(response.data);
          if (authResponse.status) {
            CommonMethods().showSnackBar(authResponse.message);
            state(SuccessState(authResponse.user));
          } else {
            String errorMessage = authResponse.vErrors.getErrors();
            if (errorMessage != null) {
              CommonMethods().showSnackBar(errorMessage);
            }
            state(ErrorState());
          }
        } else {
          CommonMethods().showGeneralError();
          state(ErrorState());
        }
      } on DioError catch (ex) {
        CommonMethods().showGeneralError();
        state(ErrorState());
      }
    } else {
      state(NoConnectionState());
    }
  }

  registerWithSocialAccount({
    @required String name,
    @required String email,
    @required String socialType,
    @required Function(DataState dataState) state,
  }) async {
    if (await _checkNetwork()) {
      try {
        Response response = await (await _getDioClient()).post(
          "/socialSignUp",
          data: {
            "name": name,
            "email": email,
            "socialType": socialType,
          },
        );

        if (response.statusCode == 200) {
          AuthResponse authResponse = AuthResponse.fromJson(response.data);
          if (authResponse.status) {
            CommonMethods().showSnackBar(authResponse.message);
            state(SuccessState(authResponse.user));
          } else {
            String errorMessage = authResponse.vErrors.getErrors();
            if (errorMessage != null) {
              CommonMethods().showSnackBar(errorMessage);
            }
            state(ErrorState());
          }
        } else {
          CommonMethods().showGeneralError();
          state(ErrorState());
        }
      } on DioError catch (ex) {
        CommonMethods().showGeneralError();
        state(ErrorState());
      }
    } else {
      state(NoConnectionState());
    }
  }

  login({
    @required String phone,
    @required String password,
    @required Function(DataState dataState) state,
  }) async {
    if (await _checkNetwork()) {
      try {
        Response response = await (await _getDioClient()).post(
          "/login",
          data: {
            "userInfo": phone,
            "password": password,
          },
        );

        if (response.statusCode == 200) {
          AuthResponse authResponse = AuthResponse.fromJson(response.data);
          if (authResponse.status) {
            CommonMethods().showSnackBar(authResponse.message);
            state(SuccessState(authResponse.user));
          } else {
            CommonMethods().showSnackBar(authResponse.message);
            state(ErrorState());
          }
        } else {
          CommonMethods().showGeneralError();
          state(ErrorState());
        }
      } on DioError catch (ex) {
        CommonMethods().showGeneralError();
        state(ErrorState());
      }
    } else {
      state(NoConnectionState());
    }
  }

  profile({
    @required Function(DataState dataState) state,
  }) async {
    if (await _checkNetwork()) {
      try {
        Response response = await (await _getDioClient()).get(
          "/profile",
        );

        if (response.statusCode == 200) {
          AuthResponse authResponse = AuthResponse.fromJson(response.data);
          if (authResponse.status) {
            state(SuccessState(authResponse.user));
          } else {
            CommonMethods().showSnackBar(authResponse.message);
            state(ErrorState());
          }
        } else {
          CommonMethods().showGeneralError();
          state(ErrorState());
        }
      } on DioError catch (ex) {
        CommonMethods().showGeneralError();
        state(ErrorState());
      }
    } else {
      state(NoConnectionState());
    }
  }

  editProfile({
    @required String name,
    @required String email,
    @required String phone,
    @required Function(DataState dataState) state,
  }) async {
    if (await _checkNetwork()) {
      try {
        Response response = await (await _getDioClient()).post(
          "/editProfile",
          data: {
            "name": name,
            "email": email,
            "phone": phone,
          },
        );

        if (response.statusCode == 200) {
          AuthResponse authResponse = AuthResponse.fromJson(response.data);
          if (authResponse.status) {
            CommonMethods().showSnackBar(authResponse.message);
            state(SuccessState(authResponse.user));
          } else {
            CommonMethods().showSnackBar(authResponse.message);
            state(ErrorState());
          }
        } else {
          CommonMethods().showGeneralError();
          state(ErrorState());
        }
      } on DioError catch (ex) {
        CommonMethods().showGeneralError();
        state(ErrorState());
      }
    } else {
      state(NoConnectionState());
    }
  }

  sendFirebaseToken({
    @required String firebaseToken,
  }) async {
    await (await _getDioClient()).post(
      "/createFireBaseToken",
      data: {
        "firebase_token": firebaseToken,
      },
    );
    print("Firebase token sent to server!");
  }

  changePassword({
    @required String oldPassword,
    @required String newPassword,
    @required String confirmNewPassword,
    @required Function(DataState dataState) state,
  }) async {
    if (await _checkNetwork()) {
      try {
        Response response = await (await _getDioClient()).post(
          "/changePassword",
          data: {
            "oldPassword": oldPassword,
            "password": newPassword,
            "confirmPassword": confirmNewPassword,
          },
        );

        if (response.statusCode == 200) {
          InfoResponse infoResponse = InfoResponse.fromJson(response.data);
          if (infoResponse.status) {
            CommonMethods().showSnackBar(infoResponse.message);
            state(SuccessState(true));
          } else {
            CommonMethods().showSnackBar(infoResponse.message);
            state(ErrorState());
          }
        } else {
          CommonMethods().showGeneralError();
          state(ErrorState());
        }
      } on DioError catch (ex) {
        CommonMethods().showGeneralError();
        state(ErrorState());
      }
    } else {
      state(NoConnectionState());
    }
  }

  contactUs({
    @required String email,
    @required String title,
    @required String body,
    @required Function(DataState dataState) state,
  }) async {
    if (await _checkNetwork()) {
      try {
        Response response = await (await _getDioClient()).post(
          "/contactUs",
          data: {
            "title": title,
            "message": body,
            "email": email,
          },
        );

        if (response.statusCode == 200) {
          InfoResponse infoResponse = InfoResponse.fromJson(response.data);
          if (infoResponse.status) {
            CommonMethods().showSnackBar(infoResponse.message);

            state(SuccessState(true));

          } else {
            String errorMessage = infoResponse.vErrors.getErrors();
            if (errorMessage != null) {
              CommonMethods().showSnackBar(errorMessage);
            }
            state(ErrorState());
          }
        } else {
          CommonMethods().showGeneralError();
          state(ErrorState());
        }
      } on DioError catch (ex) {
        CommonMethods().showGeneralError();
        state(ErrorState());
      }
    } else {
      state(NoConnectionState());
    }
  }

  logOut({
    @required Function(DataState dataState) state,
  }) async {
    if (await _checkNetwork()) {
      try {
        Response response = await (await _getDioClient()).get(
          "/logOut",
        );

        if (response.statusCode == 200) {
          InfoResponse infoResponse = InfoResponse.fromJson(response.data);
          if (infoResponse.status) {
            CommonMethods().showSnackBar(infoResponse.message);
            state(SuccessState(true));
          } else {
            CommonMethods().showSnackBar(infoResponse.message);
            state(ErrorState());
          }
        } else {
          CommonMethods().showGeneralError();
          state(ErrorState());
        }
      } on DioError catch (ex) {
        CommonMethods().showGeneralError();
        state(ErrorState());
      }
    } else {
      state(NoConnectionState());
    }
  }

  getNotifications({
    @required Function(DataState dataState) state,
  }) async {
    if (await _checkNetwork()) {
      try {
        Response response = await (await _getDioClient()).get(
          "/myNotifi",
        );

        if (response.statusCode == 200) {
          NotificationsResponse notificationsResponse =
              NotificationsResponse.fromJson(response.data);
          if (notificationsResponse.status) {
            state(SuccessState(notificationsResponse.notifications));
          } else {
            CommonMethods().showGeneralError();
            state(ErrorState());
          }
        } else {
          CommonMethods().showGeneralError();
          state(ErrorState());
        }
      } on DioError catch (ex) {
        CommonMethods().showGeneralError();
        state(ErrorState());
      }
    } else {
      state(NoConnectionState());
    }
  }

  getHelpData({
    @required Function(DataState dataState) state,
  }) async {
    if (await _checkNetwork()) {
      try {
        Response response = await (await _getDioClient()).get(
          "/privacy_policies/help",
        );

        if (response.statusCode == 200) {
          HelpResponse helpResponse = HelpResponse.fromJson(response.data);
          if (helpResponse.status) {
            state(SuccessState(helpResponse.data));
          } else {
            CommonMethods().showGeneralError();
            state(ErrorState());
          }
        } else {
          CommonMethods().showGeneralError();
          state(ErrorState());
        }
      } on DioError catch (ex) {
        CommonMethods().showGeneralError();
        state(ErrorState());
      }
    } else {
      state(NoConnectionState());
    }
  }

  getMyOrders({
    @required Function(DataState dataState) state,
  }) async {
    if (await _checkNetwork()) {
      try {
        Response response = await (await _getDioClient()).get(
          "/getOrders",
        );

        if (response.statusCode == 200) {
          MyOrdersResponse myOrdersResponse =
              MyOrdersResponse.fromJson(response.data);
          if (myOrdersResponse.status) {
            state(SuccessState(myOrdersResponse.orders));
          } else {
            CommonMethods().showGeneralError();
            state(ErrorState());
          }
        } else {
          CommonMethods().showGeneralError();
          state(ErrorState());
        }
      } on DioError catch (ex) {
        CommonMethods().showGeneralError();
        state(ErrorState());
      }
    } else {
      state(NoConnectionState());
    }
  }

  getConditionsData({
    @required Function(DataState dataState) state,
  }) async {
    if (await _checkNetwork()) {
      try {
        Response response = await (await _getDioClient()).get(
          "/privacy_policies/policies",
        );

        if (response.statusCode == 200) {
          ConditionsResponse conditionsResponse =
              ConditionsResponse.fromJson(response.data);
          if (conditionsResponse.status) {
            state(SuccessState(conditionsResponse.data));
          } else {
            CommonMethods().showGeneralError();
            state(ErrorState());
          }
        } else {
          CommonMethods().showGeneralError();
          state(ErrorState());
        }
      } on DioError catch (ex) {
        CommonMethods().showGeneralError();
        state(ErrorState());
      }
    } else {
      state(NoConnectionState());
    }
  }

  getAboutAppData({
    @required Function(DataState dataState) state,
  }) async {
    if (await _checkNetwork()) {
      try {
        Response response = await (await _getDioClient()).get(
          "/privacy_policies/about_app",
        );

        if (response.statusCode == 200) {
          AboutAppResponse aboutAppResponse =
              AboutAppResponse.fromJson(response.data);
          if (aboutAppResponse.status) {
            state(SuccessState(aboutAppResponse.data));
          } else {
            CommonMethods().showGeneralError();
            state(ErrorState());
          }
        } else {
          CommonMethods().showGeneralError();
          state(ErrorState());
        }
      } on DioError catch (ex) {
        CommonMethods().showGeneralError();
        state(ErrorState());
      }
    } else {
      state(NoConnectionState());
    }
  }

  createOrder({
    @required CreateOrderRequest createOrderRequest,
    @required Function(DataState dataState) state,
  }) async {
    //order details
    if (await _checkNetwork()) {
      try {
        Response response = await (await _getDioClient()).post(
          "/createOrder",
          data: {
            "orderPrice": createOrderRequest.orderPrice,
            "orderType": createOrderRequest.orderType,
            "paymentMethod": createOrderRequest.paymentMethod,
            "note": createOrderRequest.note,
            "fee": createOrderRequest.fee,
            "shippingPrice": createOrderRequest.shipping,
            "orderDetails": createOrderRequest.orderDetails
          },
        );

        if (response.statusCode == 200) {
          InfoResponse infoResponse = InfoResponse.fromJson(response.data);
          if (infoResponse.status) {
            state(SuccessState(infoResponse));
          } else {
            CommonMethods().showSnackBar(infoResponse.vErrors.getErrors());
            state(ErrorState());
          }
        } else {
          CommonMethods().showGeneralError();
          state(ErrorState());
        }
      } on DioError catch (ex) {
        CommonMethods().showGeneralError();
        state(ErrorState());
      }
    } else {
      state(NoConnectionState());
    }
  }

  sendMessage({
    @required String message,
    @required List<Media> media,
    @required Function(DataState dataState) state,
  }) async {
    if (await _checkNetwork()) {
      try {
        List<MultipartFile> files = [];
        for (var file in media) {
          files.add(
            await MultipartFile.fromFile(file.path),
          );
        }

        FormData formData =
            FormData.fromMap({"message": message, "media[]": files});

        Response response = await (await _getDioClient()).post(
          "/sendMessage",
          data: formData,
          onSendProgress: (count, total) {
            final progress = ((count / total) * 100).toStringAsFixed(0);
            // onUploadProgress(progress);
          },
        );

        if (response.statusCode == 200) {
          SendMessageResponse sendMessageResponse =
              SendMessageResponse.fromJson(response.data);
          if (sendMessageResponse.status) {
            state(SuccessState(sendMessageResponse.chatMessage));
          } else {
            state(ErrorState());
          }
        } else {
          CommonMethods().showGeneralError();
          state(ErrorState());
        }
      } on DioError catch (ex) {
        CommonMethods().showGeneralError();
        state(ErrorState());
      }
    } else {
      state(NoConnectionState());
    }
  }

  getChatMessage({
    @required int page,
    @required Function(DataState dataState) state,
  }) async {
    if (await _checkNetwork()) {
      try {
        Response response = await (await _getDioClient()).get(
          "/myMessages?page=$page",
        );

        if (response.statusCode == 200) {
          MessagesResponse messagesResponse =
              MessagesResponse.fromJson(response.data);
          if (messagesResponse.status) {
            state(SuccessState(messagesResponse.chat));
          } else {
            state(ErrorState());
          }
        } else {
          CommonMethods().showGeneralError();
          state(ErrorState());
        }
      } on DioError catch (ex) {
        CommonMethods().showGeneralError();
        state(ErrorState());
      }
    } else {
      state(NoConnectionState());
    }
  }

  getStaticData({
    @required Function(DataState dataState) state,
  }) async {
    if (await _checkNetwork()) {
      try {
        Response response = await (await _getDioClient()).get(
          "/project_constInfo",
        );

        if (response.statusCode == 200) {
          StaticData staticData = StaticData.fromJson(response.data);
          if (staticData.status) {
            state(SuccessState(staticData.data));
          } else {
            state(ErrorState());
          }
        } else {
          CommonMethods().showGeneralError();
          state(ErrorState());
        }
      } on DioError catch (ex) {
        CommonMethods().showGeneralError();
        state(ErrorState());
      }
    } else {
      state(NoConnectionState());
    }
  }
}
