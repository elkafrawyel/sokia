import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sokia_app/api/api_service.dart';
import 'package:sokia_app/data/responses/about_app_response.dart';
import 'package:sokia_app/data/responses/conditions_response.dart';
import 'package:sokia_app/data/responses/help_response.dart';
import 'package:sokia_app/helper/CommonMethods.dart';
import 'package:sokia_app/helper/data_states.dart';

class GeneralController extends GetxController {
  List<HelpModel> helpList = [];
  List<ConditionModel> conditionsList = [];
  String aboutApp = '';
  bool loading = false;
  bool error = false;
  bool empty = false;

  Future<void> getHelpList() async {
    if (helpList.isEmpty) {
      loading = true;
      update();
      helpList.clear();
      await ApiService().getHelpData(
        state: (dataState) {
          if (dataState is SuccessState) {
            helpList.addAll((dataState.data as List<HelpModel>));
            loading = false;
            empty = helpList.isEmpty;
            update();
          } else if (dataState is ErrorState) {
            loading = false;
            error = true;
            update();
          } else if (dataState is NoConnectionState) {
            loading = false;
            update();
            CommonMethods().goOffline();
          }
        },
      );
    }
  }

  Future<void> getConditionsList() async {
    if (conditionsList.isEmpty) {
      loading = true;
      update();
      conditionsList.clear();
      await ApiService().getConditionsData(
        state: (dataState) {
          if (dataState is SuccessState) {
            conditionsList.addAll((dataState.data as List<ConditionModel>));
            loading = false;
            empty = conditionsList.isEmpty;
            update();
          } else if (dataState is ErrorState) {
            loading = false;
            error = true;
            update();
          } else if (dataState is NoConnectionState) {
            loading = false;
            update();
            CommonMethods().goOffline();
          }
        },
      );
    }
  }

  Future<void> getAboutApp() async {
    loading = true;
    update();
    await ApiService().getAboutAppData(
      state: (dataState) {
        if (dataState is SuccessState) {
          aboutApp = (dataState.data as AboutApp).body;
          loading = false;
          update();
        } else if (dataState is ErrorState) {
          loading = false;
          error = true;
          update();
        } else if (dataState is NoConnectionState) {
          loading = false;
          update();
          CommonMethods().goOffline();
        }
      },
    );
  }

  contactUs({
    @required String email,
    @required String title,
    @required String body,
  }) async {
    loading = true;
    update();
    await ApiService().contactUs(
      email: email,
      title: title,
      body: body,
      state: (dataState) {
        if (dataState is SuccessState) {
          loading = false;
          update();
        } else if (dataState is ErrorState) {
          loading = false;
          error = true;
          update();
        } else if (dataState is NoConnectionState) {
          loading = false;
          update();
          CommonMethods().goOffline();
        }
      },
    );
  }
}
