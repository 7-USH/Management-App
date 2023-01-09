// ignore_for_file: prefer_const_constructors, prefer_final_fields, library_private_types_in_public_api, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:manage_app/attendance/attendance.dart';
import 'package:manage_app/chat/chat.dart';
import 'package:manage_app/home/home.dart';
import 'package:manage_app/utils/manage_theme.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);

  void takeOrders() {
    _controller.jumpToTab(2);
  }

  void takeExplore() {
    _controller.jumpToTab(0);
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      backgroundColor: ManageTheme.backgroundWhite,
      screenTransitionAnimation: ScreenTransitionAnimation(
        animateTabTransition: true,
        curve: Curves.easeIn,
      ),
      decoration: NavBarDecoration(
          border: Border(top: BorderSide(color: Colors.grey.withOpacity(0.2)))),
      screens: [
        Home(),
        Chat(),
        Attendance(),
      ],
      items: [
        PersistentBottomNavBarItem(
            icon: Icon(
              CupertinoIcons.house,
            ),
            inactiveColorPrimary: Colors.grey,
            activeColorSecondary: Colors.white,
            activeColorPrimary: ManageTheme.nearlyBlack,
            title: "Home",
            textStyle:
                ManageTheme.insideAppText(size: 12, weight: FontWeight.w400)),
        PersistentBottomNavBarItem(
            icon: Icon(
              CupertinoIcons.chat_bubble_2,
            ),
            inactiveColorPrimary: Colors.grey,
            activeColorSecondary: Colors.white,
            activeColorPrimary: ManageTheme.nearlyBlack,
            title: "Chats",
            textStyle:
                ManageTheme.insideAppText(size: 12, weight: FontWeight.w400)),
        PersistentBottomNavBarItem(
            icon: Icon(
              CupertinoIcons.calendar_badge_plus,
            ),
            inactiveColorPrimary: Colors.grey,
            activeColorSecondary: Colors.white,
            activeColorPrimary: ManageTheme.nearlyBlack,
            title: "Attendance",
            textStyle:
                ManageTheme.insideAppText(size: 12, weight: FontWeight.w400)),
      ],
      controller: _controller,
      confineInSafeArea: true,
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      hideNavigationBarWhenKeyboardShows: false,
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      navBarStyle: NavBarStyle.style10,
    );
  }
}
