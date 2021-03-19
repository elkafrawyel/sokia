import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:sokia_app/controllers/home_controller.dart';
import 'package:sokia_app/controllers/user_controller.dart';
import 'package:sokia_app/helper/Constant.dart';
import 'package:sokia_app/helper/custom_widgets/data_state_views/empty_view.dart';
import 'package:sokia_app/screens/home/tabs/home_tab/components/suggestion_item.dart';

import 'components/horizontal_list.dart';
import 'components/search_view.dart';
import 'components/user_info.dart';

class HomeTab extends StatefulWidget {
  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> with AutomaticKeepAliveClientMixin {
  var controller = Get.put(HomeController());

  _HomeTabState() {
    Get.find<UserController>().loadProfile();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () {
          controller.onInit();
          return Future.value();
        },
        child: CustomScrollView(
          slivers: [
            SliverPersistentHeader(
              delegate: CustomSliverAppBarDelegate(expandedHeight: 280),
              pinned: false,
              floating: true,
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  SizedBox(
                    height: 40,
                  ),
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
                ],
              ),
            ),
            _buildSuggestions(),
          ],
        ),
      ),
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
}

class CustomSliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final double expandedHeight;

  CustomSliverAppBarDelegate({@required this.expandedHeight});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final size = 550;
    final top = expandedHeight - shrinkOffset - size / 2;

    return SizedBox.expand(
      child: Stack(
        fit: StackFit.expand,
        overflow: Overflow.visible,
        children: [
          buildBackground(shrinkOffset),
          Positioned(
            top: top,
            right: 0,
            left: 0,
            child: buildFloating(shrinkOffset),
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;

  appear(double shrinkOffset) => shrinkOffset / expandedHeight;

  buildBackground(double shrinkOffset) => Image.asset(
        'src/images/home_bg.png',
        fit: BoxFit.fill,
        width: MediaQuery.of(Get.context).size.width,
      );

  disappear(double shrinkOffset) => 1 - shrinkOffset / expandedHeight;

  buildFloating(double shrinkOffset) => Column(children: [
        UserInfo(),
        Container(
          child: buildFloatingSearchBar(),
          height: 60,
        ),
        GetBuilder<HomeController>(
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
        ),
      ]);
}

final _searchController = FloatingSearchBarController();

Widget buildFloatingSearchBar() {
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
        if (query.isNotEmpty) controller.search(query);
      },
      // Specify a custom transition to be used for
      // animating between opened and closed stated.
      transition: CircularFloatingSearchBarTransition(),
      actions: [
        FloatingSearchBarAction(
          showIfOpened: false,
          child: CircularButton(
            icon: const Icon(Icons.place),
            onPressed: () {},
          ),
        ),
        FloatingSearchBarAction.searchToClear(
          showIfClosed: false,
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
                return SuggestionItem(
                  mosque: mosque,
                );
              }).toList(),
            ),
          ),
        );
      },
    ),
  );
}
