import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sokia_app/api/api_service.dart';
import 'package:sokia_app/controllers/user_controller.dart';
import 'package:sokia_app/data/data_models/user_model.dart';
import 'package:sokia_app/helper/CommonMethods.dart';
import 'package:sokia_app/helper/data_states.dart';
import 'package:sokia_app/helper/local_storage.dart';
import 'package:sokia_app/screens/auth/verify_phone/verify_phone_screen.dart';
import 'package:sokia_app/screens/home/home_screen.dart';

class AuthController extends GetxController {
  bool loading = false;
  bool error = false;
  bool noConnection = false;

  register({
    @required String name,
    @required String email,
    @required String phone,
    @required String password,
  }) {
    loading = true;
    update();

    ApiService().register(
      name: name,
      email: email,
      phone: phone,
      password: password,
      state: (dataState) {
        if (dataState is SuccessState) {
          UserModel userModel = dataState.data as UserModel;

          saveUserState(userModel);

          loading = false;
          update();

          userModel.approved
              ? Get.offAll(() => VerifyPhoneScreen(
                    phone: userModel.phone,
                  ))
              : Get.offAll(() => HomeScreen());
        } else if (dataState is ErrorState) {
          loading = false;
          error = true;
          update();
        } else if (dataState is NoConnectionState) {
          loading = false;
          CommonMethods().goOffline();
          update();
        }
      },
    );
  }

  login({
    @required String phone,
    @required String password,
  }) {
    loading = true;
    update();

    ApiService().login(
      phone: phone,
      password: password,
      state: (dataState) {
        if (dataState is SuccessState) {
          UserModel userModel = dataState.data as UserModel;

          saveUserState(userModel);

          loading = false;
          update();

          userModel.approved
              ? Get.offAll(() => VerifyPhoneScreen(
                    phone: userModel.phone,
                  ))
              : Get.offAll(() => HomeScreen());
        } else if (dataState is ErrorState) {
          loading = false;
          error = true;
          update();
        } else if (dataState is NoConnectionState) {
          loading = false;
          CommonMethods().goOffline();
          update();
        }
      },
    );
  }

  signInGoogle() async {
    switch (await DataConnectionChecker().connectionStatus) {
      case DataConnectionStatus.disconnected:
        CommonMethods().goOffline();
        break;
      case DataConnectionStatus.connected:
        final GoogleSignInAccount user =
            await GoogleSignIn(scopes: ['profile']).signIn();
        ApiService().registerWithSocialAccount(
          name: user.displayName,
          email: user.email,
          socialType: 'google',
          state: (dataState) async {
            if (dataState is SuccessState) {
              UserModel userModel = dataState.data as UserModel;

              saveUserState(userModel);

              loading = false;
              update();

              await Get.offAll(() => HomeScreen());
            } else if (dataState is ErrorState) {
              loading = false;
              error = true;
              update();
            } else if (dataState is NoConnectionState) {
              loading = false;
              CommonMethods().goOffline();
              update();
            }
          },
        );
        break;
    }
  }

  signInApple() async {
    switch (await DataConnectionChecker().connectionStatus) {
      case DataConnectionStatus.disconnected:
        CommonMethods().goOffline();
        break;
      case DataConnectionStatus.connected:
        // final credential = await SignInWithApple.getAppleIDCredential(
        //   scopes: [
        //     AppleIDAuthorizationScopes.email,
        //     AppleIDAuthorizationScopes.fullName,
        //   ],
        // );
        //
        // print(credential);
        // ApiService().registerWithSocialAccount(
        //   name: credential.givenName,
        //   email: credential.email,
        //   socialType: 'apple',
        //   state: (dataState) async {
        //     if (dataState is SuccessState) {
        //       UserModel userModel = dataState.data as UserModel;
        //
        //       saveUserState(userModel);
        //
        //       loading = false;
        //       update();
        //
        //       await Get.offAll(() => HomeScreen());
        //     } else if (dataState is ErrorState) {
        //       loading = false;
        //       error = true;
        //       update();
        //     } else if (dataState is NoConnectionState) {
        //       loading = false;
        //       CommonMethods().goOffline();
        //       update();
        //     }
        //   },
        // );
        break;
    }
  }

  saveUserState(UserModel userModel) {
    LocalStorage().setBool(LocalStorage.loginKey, true);
    LocalStorage().setString(LocalStorage.token, userModel.apiToken);
    LocalStorage().setString(LocalStorage.userId, userModel.id.toString());
    Get.find<UserController>().setUser(userModel);
  }
}
