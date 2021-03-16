import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sokia_app/api/api_service.dart';
import 'package:sokia_app/controllers/user_controller.dart';
import 'package:sokia_app/data/responses/home_response.dart';
import 'package:sokia_app/helper/custom_widgets/data_state_views/network_view.dart';
import 'package:sokia_app/helper/data_states.dart';

class HomeController extends GetxController {
  List<Category> categories = [];
  List<Mosque> mosques = [];
  List<Mosque> searchList = [];

  bool loading = false;
  bool error = false;
  bool emptyCategories = false;
  bool emptyMosques = false;

  var searchQuery = ''.obs;
  bool isSearching = false;

  var userController = Get.put(UserController());

  @override
  void onInit() {
    super.onInit();
    _getData();
    userController.loadProfile();

    //every time search query changes that callback will fire
    ever(
      searchQuery,
      (_) {
        if (searchQuery.isNotEmpty) {
          print('searching');

          isSearching = true;
          searchList.clear();
          mosques.forEach((element) {
            if (element.mosqueName.toLowerCase().contains(searchQuery) ||
                element.mosqueAdress.toLowerCase().contains(searchQuery)) {
              searchList.add(element);
            }
          });
          emptyMosques = searchList.isEmpty;
          update();
        } else {
          print('not searching');

          isSearching = false;
          update();
        }
      },
    );
  }

  search(String query) {
    searchQuery.value = query;
  }

  _getData() async {
    loading = true;
    update();
    categories.clear();
    mosques.clear();
    await ApiService().getHomeData(
      state: (dataState) {
        if (dataState is SuccessState) {
          HomeResponse homeResponse = dataState.data as HomeResponse;

          categories.addAll(homeResponse.categories);
          mosques.addAll(homeResponse.mosques);
          loading = false;
          emptyCategories = categories.isEmpty;
          emptyMosques = mosques.isEmpty;
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
