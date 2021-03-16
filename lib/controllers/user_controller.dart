import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sokia_app/api/api_service.dart';
import 'package:sokia_app/data/data_models/user_model.dart';
import 'package:sokia_app/helper/CommonMethods.dart';
import 'package:sokia_app/helper/data_states.dart';
import 'package:sokia_app/helper/local_storage.dart';
import 'package:sokia_app/screens/auth/social/social.dart';

class UserController extends GetxController {
  bool editing = false;
  UserModel user;
  bool loading = false;
  bool error = false;
  bool noConnection = false;

  setUser(UserModel userModel) {
    user = userModel;
    if (user != null)
      print('User ${userModel.name} saved to user controller!');
    else
      print('you loggedOut!');

    update();
  }

  loadProfile() {
    if (LocalStorage().getBool(LocalStorage.loginKey)) {
      ApiService().profile(
        state: (dataState) {
          if (dataState is SuccessState) {
            UserModel userModel = dataState.data as UserModel;
            setUser(userModel);
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
  }

  void startEditingProfile() {
    editing = true;
    update();
  }

  void cancelEditingProfile() {
    editing = false;
    update();
  }

  editProfile({
    @required String name,
    @required String email,
    @required String phone,
  }) {
    loading = true;
    update();

    ApiService().editProfile(
      name: name.trim(),
      email: email.trim(),
      phone: phone.trim(),
      state: (dataState) {
        if (dataState is SuccessState) {
          UserModel userModel = dataState.data as UserModel;
          setUser(userModel);
          loading = false;
          editing = false;
          update();
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

  changePassword({
    @required String oldPassword,
    @required String newPassword,
    @required String confirmNewPassword,
  }) {
    loading = true;
    update();

    ApiService().changePassword(
      oldPassword: oldPassword,
      newPassword: newPassword,
      confirmNewPassword: confirmNewPassword,
      state: (dataState) {
        if (dataState is SuccessState) {
          loading = false;
          update();

          Future.delayed(Duration(seconds: 5), () {
            Get.back();
          });
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

  logOut() {
    ApiService().logOut(
      state: (dataState) {
        if (dataState is SuccessState) {
          _logOut();
        } else if (dataState is ErrorState) {
        } else if (dataState is NoConnectionState) {
          CommonMethods().goOffline();
        }
      },
    );
  }

  _logOut() {
    LocalStorage().clear();
    setUser(null);
    Get.to(() => SocialLogin());
  }
}
