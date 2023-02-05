// ignore_for_file: unused_local_variable

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:manage_app/attendance/service/attendance_service.dart';
import 'package:manage_app/utils/manage_theme.dart';

class ApplicationStatusSreen extends StatefulWidget {
  const ApplicationStatusSreen({super.key});

  @override
  State<ApplicationStatusSreen> createState() => _ApplicationStatusSreenState();
}

class _ApplicationStatusSreenState extends State<ApplicationStatusSreen> {
  AttendanceService service = AttendanceService();

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: ManageTheme.nearlyWhite,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: ManageTheme.nearlyBlack,
        elevation: 0.0,
        title: Text(
          "Application Status",
          style: ManageTheme.insideAppText(size: 25, weight: FontWeight.bold),
        ),
      ),
      body: FutureBuilder(
          future: service.getAllLeaveApplications(context: context),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return SizedBox();
                  });
            } else {
              return Center(
                child: Container(
                  height: screenWidth / 9,
                  width: screenWidth / 9,
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
              );
            }
          }),
    );
  }
}
