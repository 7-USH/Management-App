// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:manage_app/attendance/models/attendance_model.dart';

import '../../utils/manage_theme.dart';

class AttendanceCard extends StatelessWidget {
  AttendanceCard({super.key, required this.model});
  AttendanceModel model;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      height: 200,
      margin: const EdgeInsets.only(bottom: 20),
      decoration: const BoxDecoration(
          color: ManageTheme.backgroundWhite,
          borderRadius: BorderRadius.all(Radius.circular(20)),
          boxShadow: [
            BoxShadow(
                color: Colors.black26, blurRadius: 7, offset: Offset(2, 2))
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
              child: Container(
            decoration: BoxDecoration(
                color: ManageTheme.nearlyBlack,
                boxShadow: const [
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 5,
                      offset: Offset(2, 2))
                ],
                borderRadius: BorderRadius.circular(20)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  model.day,
                  style: ManageTheme.insideAppText(
                      size: screenWidth / 15,
                      weight: FontWeight.bold,
                      color: ManageTheme.backgroundWhite),
                ),
                Text(
                  model.date,
                  style: ManageTheme.appText(
                      size: screenWidth / 15,
                      weight: FontWeight.bold,
                      color: ManageTheme.backgroundWhite),
                ),
              ],
            ),
          )),
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Check In",
                style: ManageTheme.insideAppText(
                    size: screenWidth / 24,
                    weight: FontWeight.w400,
                    color: Colors.black38),
              ),
              Text(
                model.check_in_time,
                style: ManageTheme.insideAppText(
                  size: screenWidth / 20,
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
              Text(
                "Check Out",
                style: ManageTheme.insideAppText(
                    size: screenWidth / 24,
                    weight: FontWeight.w400,
                    color: Colors.black38),
              ),
              Text(
                model.check_out_time,
                style: ManageTheme.insideAppText(
                  size: screenWidth / 20,
                  weight: FontWeight.w600,
                ),
              ),
            ],
          ))
        ],
      ),
    );
  }
}
