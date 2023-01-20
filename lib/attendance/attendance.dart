// ignore_for_file: unused_local_variable, unused_field, prefer_final_fields, non_constant_identifier_names, prefer_const_constructors, deprecated_member_use

import 'dart:async';
import 'package:action_slider/action_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:manage_app/attendance/models/status_enum.dart';
import 'package:manage_app/attendance/screens/history_screen.dart';
import 'package:manage_app/attendance/ui_view/leave_card.dart';
import 'package:manage_app/utils/manage_theme.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:shimmer/shimmer.dart';

class Attendance extends StatefulWidget {
  const Attendance({super.key});

  @override
  State<Attendance> createState() => _AttendanceState();
}

class _AttendanceState extends State<Attendance> {
  late Timer _timer;
  String formattedTime =
      DateFormat("hh:mm a").format(DateTime.now()).toString();
  String formattedDate =
      DateFormat("MMM dd, yyyy").format(DateTime.now()).toString();
  AttendanceStatus status = AttendanceStatus.CHECK_IN;
  ActionSliderController _controller = ActionSliderController();
  String check_in_time = "--/--";
  String check_out_time = "--/--";

  @override
  void initState() {
    super.initState();
    _timer =
        Timer.periodic(const Duration(milliseconds: 500), (timer) => _update());
  }

  void _update() {
    setState(() {
      formattedTime = DateFormat("hh:mm a").format(DateTime.now()).toString();
      formattedDate =
          DateFormat("MMM dd, yyyy").format(DateTime.now()).toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: ManageTheme.nearlyWhite,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Welcome,",
                          style: ManageTheme.insideAppText(
                              size: screenWidth / 19,
                              weight: FontWeight.w400,
                              color: Colors.black38),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Tushar Mali",
                          style: ManageTheme.insideAppText(
                              size: screenWidth / 16, weight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                      onPressed: () {
                        PersistentNavBarNavigator.pushNewScreen(context,
                            screen: HistoryScreen(),
                            withNavBar: true,
                            pageTransitionAnimation:
                                PageTransitionAnimation.scale);
                      },
                      icon: Icon(
                        FontAwesomeIcons.calendar,
                        size: screenWidth / 15,
                        color: Colors.black38,
                      ))
                ],
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.only(top: 32),
                child: Text(
                  "Today's Status",
                  style: ManageTheme.insideAppText(
                    size: screenWidth / 18,
                    weight: FontWeight.w600,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 12, bottom: 32),
                height: 200,
                decoration: BoxDecoration(
                    color: ManageTheme.backgroundWhite,
                    border: Border.all(color: ManageTheme.nearlyBlack),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.black26,
                          blurRadius: 2,
                          offset: Offset(2, 2))
                    ]),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          FontAwesomeIcons.signInAlt,
                          size: screenWidth / 15,
                          color: Colors.black38,
                        ),
                        SizedBox(
                          height: screenHeight / 50,
                        ),
                        Text(
                          "Check In",
                          style: ManageTheme.insideAppText(
                              size: screenWidth / 20,
                              weight: FontWeight.w400,
                              color: Colors.black38),
                        ),
                        Text(
                          check_in_time,
                          style: ManageTheme.insideAppText(
                            size: screenWidth / 18,
                            weight: FontWeight.w600,
                          ),
                        ),
                      ],
                    )),
                    Expanded(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          FontAwesomeIcons.signOutAlt,
                          size: screenWidth / 15,
                          color: Colors.black38,
                        ),
                        SizedBox(
                          height: screenHeight / 50,
                        ),
                        Text(
                          "Check Out",
                          style: ManageTheme.insideAppText(
                              size: screenWidth / 20,
                              weight: FontWeight.w400,
                              color: Colors.black38),
                        ),
                        Text(
                          check_out_time,
                          style: ManageTheme.insideAppText(
                            size: screenWidth / 18,
                            weight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ))
                  ],
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  formattedDate,
                  style: ManageTheme.insideAppText(
                    size: screenWidth / 22,
                    weight: FontWeight.w600,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.only(bottom: 40),
                child: Text(
                  formattedTime,
                  style: ManageTheme.insideAppText(
                      size: screenWidth / 25,
                      weight: FontWeight.w500,
                      color: Colors.black38),
                ),
              ),
              Builder(builder: (context) {
                return status != AttendanceStatus.FINISHED
                    ? ActionSlider.standard(
                        controller: _controller,
                        backgroundColor: ManageTheme.backgroundWhite,
                        height: 70,
                        loadingIcon: const CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 1.5,
                        ),
                        successIcon: const Icon(
                          Icons.check_rounded,
                          color: Colors.white,
                        ),
                        toggleColor: status == AttendanceStatus.CHECK_IN
                            ? ManageTheme.successGreen
                            : Colors.redAccent,
                        icon: Icon(
                          Icons.keyboard_arrow_right,
                          color: ManageTheme.backgroundWhite,
                          size: screenWidth / 13,
                        ),
                        child: Shimmer.fromColors(
                          baseColor: Colors.black12,
                          highlightColor: Colors.grey,
                          child: Text(
                            status == AttendanceStatus.CHECK_OUT
                                ? "Slide to Check Out"
                                : "Slide to Check In",
                            style: ManageTheme.insideAppText(
                                size: screenWidth / 21,
                                weight: FontWeight.w600,
                                color: status == AttendanceStatus.CHECK_IN
                                    ? ManageTheme.successGreen
                                    : Colors.redAccent),
                          ),
                        ),
                        action: (controller) async {
                          controller.loading();
                          await Future.delayed(const Duration(seconds: 3));
                          controller.success();
                          if (status == AttendanceStatus.CHECK_IN) {
                            setState(() {
                              check_in_time = formattedTime.split(" ")[0];
                            });
                          } else {
                            setState(() {
                              check_out_time = formattedTime.split(" ")[0];
                            });
                          }
                          if (status != AttendanceStatus.CHECK_OUT) {
                            await Future.delayed(const Duration(seconds: 2))
                                .then((value) {
                              _controller.reset();
                              setState(() {
                                status = AttendanceStatus.CHECK_OUT;
                              });
                            });
                          } else {
                            await Future.delayed(const Duration(seconds: 2))
                                .then((value) {
                              setState(() {
                                status = AttendanceStatus.FINISHED;
                              });
                            });
                          }
                          //starts success animation
                        },
                      )
                    : Center(
                        child: SizedBox(
                          height: 70,
                          child: Text(
                            "You have Completed this day!",
                            style: ManageTheme.insideAppText(
                                size: screenWidth / 22,
                                weight: FontWeight.w500,
                                color: Colors.black38),
                          ),
                        ),
                      );
              }),
              Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.only(top: 32),
                child: Text(
                  "Leave Status",
                  style: ManageTheme.insideAppText(
                    size: screenWidth / 18,
                    weight: FontWeight.w600,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 12),
                height: 200,
                decoration: BoxDecoration(
                    color: ManageTheme.backgroundWhite,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    border: Border.all(color: ManageTheme.nearlyBlack),
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.black26,
                          blurRadius: 2,
                          offset: Offset(2, 2))
                    ]),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    LeaveCard(
                      text: "Leaves \nTaken",
                      number: "2",
                      color: Colors.redAccent.shade100,
                    ),
                    LeaveCard(
                        text: "Applied \nLeaves",
                        number: "5",
                        color: Colors.redAccent.shade700),
                    LeaveCard(
                        text: "Leaves \nLeft",
                        number: "0",
                        color: Colors.black26),
                  ],
                ),
              ),
              SizedBox(
                height: screenHeight / 30,
              ),
              SizedBox(
                width: screenWidth,
                height: screenHeight / 15,
                child: ElevatedButton(
                    onPressed: () {},
                    style: ManageTheme.buttonStyle(
                        backColor: ManageTheme.backgroundWhite,
                        borderColor: ManageTheme.nearlyBlack
                        ),
                    child: Text(
                      "Request Leave",
                      style: ManageTheme.insideAppText(
                          size: screenWidth / 25,
                          weight: FontWeight.w600,
                          color: ManageTheme.nearlyBlack),
                    )),
              ),
              SizedBox(
                height: screenHeight / 40,
              ),
              SizedBox(
                width: screenWidth,
                height: screenHeight / 15,
                child: ElevatedButton(
                    onPressed: () {},
                    style: ManageTheme.buttonStyle(
                        backColor: ManageTheme.backgroundWhite,
                        borderColor: ManageTheme.nearlyBlack),
                    child: Text(
                      "Application Status",
                      style: ManageTheme.insideAppText(
                          size: screenWidth / 25,
                          weight: FontWeight.w600,
                          color: ManageTheme.nearlyBlack),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
