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
  bool searchFocus = false;

  _HomeTabState() {
    Get.find<UserController>().loadProfile();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: RefreshIndicator(
          onRefresh: () {
            controller.onInit();
            return Future.value();
          },
          child: CustomScrollView(
            slivers: [
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(
                                'src/images/home_bg.png',
                              ),
                              fit: BoxFit.fitWidth,
                              alignment: AlignmentDirectional.topCenter),
                          color: kBackgroundColor),
                      child: Column(
                        children: [
                          Visibility(
                            visible: !searchFocus,
                            replacement: SizedBox(
                              height: 30,
                            ),
                            child: UserInfo(),
                          ),
                          Visibility(
                            visible: !searchFocus,
                            child: SizedBox(
                              height: 20,
                            ),
                          ),
                          _buildFloatingSearchBar(),
                          Visibility(
                            visible: !searchFocus,
                            replacement: SizedBox(
                              height: 20,
                            ),
                            child: _buildHorizontalList(),
                          ),
                          Visibility(
                            visible: !searchFocus,
                            replacement: SizedBox(
                              height: 20,
                            ),
                            child: Row(
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
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              _buildSuggestions(),
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

  Widget _buildHorizontalList() => GetBuilder<HomeController>(
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

  Widget _buildSuggestions() => GetBuilder<HomeController>(
        init: HomeController(),
        builder: (controller) => searchFocus
            ? SliverList(delegate: SliverChildListDelegate([Container()]))
            : SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) => controller.loading
                      ? _loading()
                      : controller.emptyMosques
                          ? _empty()
                          : SuggestionItem(mosque: controller.mosques[index]),
                  childCount:
                      controller.loading ? 2 : controller.mosques.length,
                ),
              ),
      );

  Widget _buildFloatingSearchBar() {
    final isPortrait =
        MediaQuery.of(Get.context).orientation == Orientation.portrait;

    return GetBuilder<HomeController>(
      builder: (controller) => Container(
        height: searchFocus ? MediaQuery.of(context).size.height : 70,
        child: FloatingSearchBar(
          onFocusChanged: (isFocused) {
            setState(() {
              searchFocus = isFocused;
            });
          },
          hint: 'search'.tr,
          scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
          transitionDuration: const Duration(milliseconds: 800),
          transitionCurve: Curves.easeInOut,
          physics: const BouncingScrollPhysics(),
          axisAlignment: isPortrait ? 0.0 : -1.0,
          openAxisAlignment: 0.0,
          shadowColor: Colors.white,
          backgroundColor: Colors.white,
          backdropColor: Colors.white,
          width: isPortrait ? 600 : 500,
          debounceDelay: const Duration(milliseconds: 500),
          onQueryChanged: (query) {
            controller.search(query);
          },
          // Specify a custom transition to be used for
          // animating between opened and closed stated.
          transition: CircularFloatingSearchBarTransition(),
          actions: [
            FloatingSearchBarAction.searchToClear(
              showIfClosed: true,
            ),
          ],
          controller: _searchController,
          builder: (context, transition) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Material(
                color: Colors.white,
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
      ),
    );
  }
}
