import 'dart:async';

import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sokia_app/helper/CommonMethods.dart';
import 'package:sokia_app/helper/Constant.dart';

import 'tabs/home_tab/home_tab.dart';
import 'tabs/more_tab.dart';
import 'tabs/my_orders_tab/my_orders_tab.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _selectedPageIndex;
  List<Widget> _pages;
  PageController _pageController;
  bool showAtStart = false;
  StreamSubscription<DataConnectionStatus> _checker;

  @override
  void initState() {
    super.initState();
    _checker = DataConnectionChecker().onStatusChange.listen((event) {
      switch (event) {
        case DataConnectionStatus.connected:
          if (!showAtStart) {
            showAtStart = true;
            return;
          }
          CommonMethods().goOnline();
          print('You are connected');
          break;

        case DataConnectionStatus.disconnected:
          print('You are disconnected');
          showAtStart = true;
          CommonMethods().goOffline();
          break;
      }
    });

    _selectedPageIndex = 0;
    _pages = [
      HomeTab(),
      MyOrdersTab(),
      MoreTab(),
    ];

    _pageController = PageController(initialPage: _selectedPageIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    _checker.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 0.0,
          brightness: Brightness.dark, // or use Brightness.dark
        ),
        body: PageView(
          controller: _pageController,
          // ==>> stop Swipe
          // physics: NeverScrollableScrollPhysics(),
          children: _pages,
          onPageChanged: (selectedPageIndex) {
            setState(() {
              _selectedPageIndex = selectedPageIndex;
              _pageController.jumpToPage(selectedPageIndex);
            });
          },
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: _selectedPageIndex == 0
                  ? new Image.asset('src/images/home_selected.png')
                  : new Image.asset('src/images/home.png'),
              label: 'home'.tr,
            ),
            BottomNavigationBarItem(
              icon: _selectedPageIndex == 1
                  ? new Image.asset('src/images/selected_orders.png')
                  : new Image.asset('src/images/orders.png'),
              label: 'myOrders'.tr,
            ),
            BottomNavigationBarItem(
              icon: _selectedPageIndex == 2
                  ? new Image.asset('src/images/menu_selected.png')
                  : new Image.asset('src/images/menu.png'),
              label: 'more'.tr,
            ),
          ],
          currentIndex: _selectedPageIndex,
          unselectedItemColor: Colors.grey.shade500,
          selectedItemColor: kPrimaryColor,
          type: BottomNavigationBarType.fixed,
          onTap: (selectedPageIndex) {
            setState(() {
              _selectedPageIndex = selectedPageIndex;
              _pageController.jumpToPage(selectedPageIndex);
            });
          },
        ),
      ),
    );
  }
}
