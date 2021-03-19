import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:sokia_app/controllers/home_controller.dart';
import 'package:sokia_app/controllers/user_controller.dart';
import 'package:sokia_app/helper/Constant.dart';
import 'package:sokia_app/helper/custom_widgets/data_state_views/empty_view.dart';
import 'package:sokia_app/screens/home/tabs/home_tab/components/horizontal_list.dart';
import 'package:sokia_app/screens/home/tabs/home_tab/components/suggestion_item.dart';
import 'package:sokia_app/screens/home/tabs/home_tab/components/user_info.dart';

class HomeTab extends StatefulWidget {
  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> with AutomaticKeepAliveClientMixin {
  var controller = Get.put(HomeController());
  final _searchController = FloatingSearchBarController();

  _HomeTabState() {
    Get.find<UserController>().loadProfile();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Colors.grey,
      resizeToAvoidBottomInset: false,
      body: RefreshIndicator(
          onRefresh: () {
            controller.onInit();
            return Future.value();
          },
          child: Stack(
            fit: StackFit.expand,
            children: [
              Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                          'src/images/home_bg.png',
                        ),
                        fit: BoxFit.contain,
                        alignment: AlignmentDirectional.topCenter),
                    color: kBackgroundColor),
                child: Column(
                  children: [
                    UserInfo(),
                    SizedBox(
                      height: 100,
                    ),
                    _buildHorizontalList(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            'suggestions'.tr,
                            style: TextStyle(fontSize: fontSize16),
                          ),
                        ),
                      ],
                    ),
                    _buildSuggestionsInListView(),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsetsDirectional.only(top: 120),
                child: _buildFloatingSearchBar(),
                alignment: AlignmentDirectional.center,
              ),
            ],
          )),
    );
  }

  @override
  bool get wantKeepAlive => true;

  _loading() => Container(
        height: 140,
        child: Center(
          child: CircularProgressIndicator(
            backgroundColor: Colors.white,
          ),
        ),
      );

  _empty() => Container(
        alignment: AlignmentDirectional.topCenter,
        padding: EdgeInsetsDirectional.only(bottom: 40),
        height: MediaQuery.of(context).size.height / 2,
        child: EmptyView(
          emptyViews: EmptyViews.Box,
          textColor: Colors.black,
        ),
      );

  _buildHorizontalList() => GetBuilder<HomeController>(
        init: HomeController(),
        builder: (controller) => controller.loading
            ? Container(
                height: 140,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : HorizontalList(
                categories: controller.categories,
              ),
      );

  _buildSuggestions() => GetBuilder<HomeController>(
        init: HomeController(),
        builder: (controller) => SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) => controller.loading
                ? _loading()
                : controller.emptyMosques
                    ? _empty()
                    : SuggestionItem(mosque: controller.mosques[index]),
            childCount: controller.loading ? 2 : controller.mosques.length,
          ),
        ),
      );

  _buildSuggestionsInListView() => GetBuilder<HomeController>(
        init: HomeController(),
        builder: (controller) => controller.loading
            ? _loading()
            : controller.emptyMosques
                ? _empty()
                : Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) =>
                          SuggestionItem(mosque: controller.mosques[index]),
                      itemCount:
                          controller.loading ? 0 : controller.mosques.length,
                    ),
                  ),
      );

  Widget _buildFloatingSearchBar() {
    final isPortrait =
        MediaQuery.of(Get.context).orientation == Orientation.portrait;

    return GetBuilder<HomeController>(
      builder: (controller) => FloatingSearchBar(
        hint: 'search'.tr,
        scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
        transitionDuration: const Duration(milliseconds: 800),
        transitionCurve: Curves.easeInOut,
        physics: const BouncingScrollPhysics(),
        axisAlignment: isPortrait ? 0.0 : -1.0,
        openAxisAlignment: 0.0,
        width: isPortrait ? 600 : 500,
        debounceDelay: const Duration(milliseconds: 500),
        onQueryChanged: (query) {
          controller.search(query);
        },
        // Specify a custom transition to be used for
        // animating between opened and closed stated.
        transition: CircularFloatingSearchBarTransition(),
        actions: [
          // FloatingSearchBarAction(
          //   showIfOpened: true,
          //   child: CircularButton(
          //     icon: const Icon(Icons.search_off),
          //     onPressed: () {},
          //   ),
          // ),
          FloatingSearchBarAction.searchToClear(
            showIfClosed: true,
          ),
        ],
        controller: _searchController,
        builder: (context, transition) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Material(
              color: Colors.transparent,
              elevation: 4.0,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: controller.searchList.map((mosque) {
                  return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: SuggestionItem(
                      mosque: mosque,
                    ),
                  );
                }).toList(),
              ),
            ),
          );
        },
      ),
    );
  }
}
