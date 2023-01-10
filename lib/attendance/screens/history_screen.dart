// ignore_for_file: unused_local_variable, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:manage_app/attendance/models/attendance_model.dart';
import 'package:manage_app/attendance/ui_view/attendance_card.dart';
import 'package:manage_app/utils/manage_theme.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: ManageTheme.nearlyWhite,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: ManageTheme.nearlyBlack,
        elevation: 0.0,
        title: Text(
          "My Attendance",
          style: ManageTheme.insideAppText(size: 25, weight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "January",
                    style: ManageTheme.insideAppText(
                      size: screenWidth / 18,
                      weight: FontWeight.w500,
                    ),
                  ),
                ),
                ElevatedButton(
                    onPressed: () {},
                    style: ManageTheme.buttonStyle(
                        backColor: ManageTheme.backgroundWhite,
                        borderColor: ManageTheme.nearlyBlack),
                    child: Text(
                      "Pick a Month",
                      style: ManageTheme.appText(
                        size: screenWidth / 27,
                        weight: FontWeight.w600,
                      ),
                    ))
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: AnimationLimiter(
                child: ListView.builder(
                  itemCount: 10,
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.all(10),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return AnimationConfiguration.staggeredList(
                      position: index,
                      duration: const Duration(milliseconds: 800),
                      child: SlideAnimation(
                        horizontalOffset: 120,
                        child: FadeInAnimation(
                          child: AttendanceCard(
                            model: AttendanceModel(
                                check_in_time: "09:30",
                                check_out_time: "10:32",
                                date: "07",
                                day: "Fri"),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
