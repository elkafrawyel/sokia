import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sokia_app/api/api_service.dart';
import 'package:sokia_app/controllers/user_controller.dart';
import 'package:sokia_app/data/data_models/search_model.dart';
import 'package:sokia_app/data/responses/home_response.dart';
import 'package:sokia_app/helper/CommonMethods.dart';
import 'package:sokia_app/helper/custom_widgets/data_state_views/network_view.dart';
import 'package:sokia_app/helper/data_states.dart';

class HomeController extends GetxController {
  List<Category> categories = [];
  List<SearchModel> mosques = [];
  List<SearchModel> occasions = [];
  List<SearchModel> searchList = [];

  bool loading = false;
  bool error = false;
  bool emptyCategories = false;
  bool emptyMosques = false;
  bool emptyOccasions = false;

  var userController = Get.put(UserController());

  @override
  void onInit() {
    super.onInit();
    _getData();
    userController.loadProfile();
  }

  search(String query) {
    if (mosques.isEmpty) {
      CommonMethods().showToast(message: 'Data not loaded yet');
      return;
    }
    if (query.isEmpty) {
      searchList.addAll(mosques);

      searchList.addAll(occasions);
      update();
    } else {
      searchList.addAll(mosques.where((element) {
        final title = element.name.toLowerCase();
        final address = element.adress.toLowerCase();
        final searchQuery = query.toLowerCase();

        return title.contains(searchQuery) || address.contains(searchQuery);
      }).toList());

      searchList.addAll(occasions.where((element) {
        final title = element.name.toLowerCase();
        final address = element.adress.toLowerCase();
        final searchQuery = query.toLowerCase();

        return title.contains(searchQuery) || address.contains(searchQuery);
      }).toList());

      update();
    }
  }

  _getData() async {
    loading = true;
    update();
    categories.clear();
    mosques.clear();
    occasions.clear();
    await ApiService().getHomeData(
      state: (dataState) {
        if (dataState is SuccessState) {
          HomeResponse homeResponse = dataState.data as HomeResponse;

          categories.addAll(homeResponse.categories);

          mosques.addAll(homeResponse.mosques.map((e) => SearchModel(
              e.id,
              e.mosqueName,
              e.mosqueImage,
              e.mosqueAdress,
              e.availableFastShipping,
              e.mosqueOpen,
              e.mosqueLongitude,
              e.mosqueLatitude)));

          occasions.addAll(homeResponse.occasions.map((e) => SearchModel(
              e.id,
              e.occasionName,
              e.occasionImage,
              e.occasionAdress,
              e.availableFastShipping,
              e.occasionOpen,
              e.occasionLongitude,
              e.occasionLatitude)));

          loading = false;
          emptyCategories = categories.isEmpty;
          emptyMosques = mosques.isEmpty;
          emptyOccasions = occasions.isEmpty;
          update();
        } else if (dataState is ErrorState) {
          loading = false;
          error = true;
          update();
        } else if (dataState is NoConnectionState) {
          loading = false;
          update();
          // CommonMethods().goOffline();
          showDialog(
            context: Get.context,
            barrierDismissible: false,
            builder: (ctx) => Dialog(
              backgroundColor: Colors.black87,
              insetPadding: EdgeInsets.all(10),
              child: NetworkView(
                onPress: () {
                  Get.back();
                  _getData();
                },
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          );
        }
      },
    );
  }
}
