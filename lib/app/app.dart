// ignore_for_file: prefer_const_constructors, prefer_final_fields, library_private_types_in_public_api, prefer_const_literals_to_create_immutables, unnecessary_type_check, unused_local_variable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:manage_app/attendance/attendance.dart';
import 'package:manage_app/chat/chat.dart';
import 'package:manage_app/chat/view_models/users_list_viewmodel.dart';
import 'package:manage_app/home/home.dart';
import 'package:manage_app/home/models/profile_detail_model.dart';
import 'package:manage_app/home/service/home_provider.dart';
import 'package:manage_app/home/service/home_service.dart';
import 'package:manage_app/task/task.dart';
import 'package:manage_app/utils/manage_theme.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';

import '../chat/view_models/chatroom_list_viewmodel.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);
  HomeService service = HomeService();
  late ProfileDetailModel model;
  bool _isLoading = true;

  @override
  void initState() {
    getProfileDetails();
    super.initState();
  }

  void getProfileDetails() {
    setState(() {
      _isLoading = true;
    });
    service.getMyDetails(context: context).then((value) {
      if (value is ProfileDetailModel) {
        model = value;
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Builder(builder: (_) {
      if (_isLoading) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/manage.png",
                  width: MediaQuery.of(context).size.width / 5,
                  height: MediaQuery.of(context).size.width / 5,
                  fit: BoxFit.contain,
                ),
                Container(
                  height: screenWidth / 9,
                  width: screenWidth / 9,
                  margin: EdgeInsets.only(top: 10),
                  padding: const EdgeInsets.all(7),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(screenWidth / 18),
                      color: ManageTheme.backgroundWhite,
                      border: Border.all(color: Colors.black26, width: 1)),
                  child: const CircularProgressIndicator(
                    strokeWidth: 1.8,
                    color: ManageTheme.nearlyBlack,
                  ),
                ),
              ],
            ),
          ),
        );
      } else {
        return buildWidget(context);
      }
    });
  }

  Widget buildWidget(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UsersListViewModel>(
            create: (_) => UsersListViewModel()),
        ChangeNotifierProvider<ChatRoomListViewModel>(
            create: (_) => ChatRoomListViewModel()),
        ChangeNotifierProvider<HomeAdminProvider>(
            create: (_) => HomeAdminProvider(context: context)),
        ChangeNotifierProvider<HomeStaffProvider>(
            create: (_) => HomeStaffProvider(context: context)),
        ChangeNotifierProvider<StaffLeaveApplicationProvider>(
            create: (_) => StaffLeaveApplicationProvider(context: context)),
      ],
      child: WillPopScope(
        onWillPop: () async => false,
        child: PersistentTabView(
          context,
          backgroundColor: ManageTheme.backgroundWhite,
          screenTransitionAnimation: ScreenTransitionAnimation(
            animateTabTransition: true,
            curve: Curves.easeIn,
          ),
          decoration: NavBarDecoration(
              border:
                  Border(top: BorderSide(color: Colors.grey.withOpacity(0.2)))),
          screens: [
            Home(
              model: model,
            ),
            Chat(
              model: model,
            ),
            model.profile == "staff"
                ? Attendance(
                    model: model,
                  )
                : Task(
                    model: model,
                  )
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
                textStyle: ManageTheme.insideAppText(
                    size: 12, weight: FontWeight.w400)),
            PersistentBottomNavBarItem(
                icon: Icon(
                  CupertinoIcons.chat_bubble_2,
                ),
                inactiveColorPrimary: Colors.grey,
                activeColorSecondary: Colors.white,
                activeColorPrimary: ManageTheme.nearlyBlack,
                title: "Chats",
                textStyle: ManageTheme.insideAppText(
                    size: 12, weight: FontWeight.w400)),
            model.profile == "staff"
                ? PersistentBottomNavBarItem(
                    icon: Icon(
                      CupertinoIcons.calendar_badge_plus,
                    ),
                    inactiveColorPrimary: Colors.grey,
                    activeColorSecondary: Colors.white,
                    activeColorPrimary: ManageTheme.nearlyBlack,
                    title: "Attendance",
                    textStyle: ManageTheme.insideAppText(
                        size: 12, weight: FontWeight.w400))
                : PersistentBottomNavBarItem(
                    icon: Icon(
                      FontAwesomeIcons.listOl,
                    ),
                    inactiveColorPrimary: Colors.grey,
                    activeColorSecondary: Colors.white,
                    activeColorPrimary: ManageTheme.nearlyBlack,
                    title: "Task",
                    textStyle: ManageTheme.insideAppText(
                        size: 12, weight: FontWeight.w400)),
          ],
          controller: _controller,
          confineInSafeArea: true,
          handleAndroidBackButtonPress: true,
          resizeToAvoidBottomInset: true,
          hideNavigationBarWhenKeyboardShows: false,
          popAllScreensOnTapOfSelectedTab: true,
          popActionScreens: PopActionScreensType.all,
          navBarStyle: NavBarStyle.style10,
        ),
      ),
    );
  }
}
