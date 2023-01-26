// ignore_for_file: unused_local_variable, unused_field, must_be_immutable

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:manage_app/home/models/profile_detail_model.dart';
import 'package:manage_app/utils/manage_theme.dart';

class Task extends StatefulWidget {
  Task({super.key, required this.model});
  ProfileDetailModel model;

  @override
  State<Task> createState() => _TaskState();
}

class _TaskState extends State<Task> {
  late Timer _timer;
  String formattedTime =
      DateFormat("hh:mm a").format(DateTime.now()).toString();
  String formattedDate =
      DateFormat("MMM dd, yyyy").format(DateTime.now()).toString();

  @override
  void initState() {
    _timer =
        Timer.periodic(const Duration(milliseconds: 500), (timer) => _update());
    super.initState();
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
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
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
                        widget.model.fullName!,
                        style: ManageTheme.insideAppText(
                            size: screenWidth / 16, weight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        formattedDate,
                        style: ManageTheme.insideAppText(
                          size: screenWidth / 25,
                          weight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        formattedTime,
                        style: ManageTheme.insideAppText(
                            size: screenWidth / 25,
                            weight: FontWeight.w500,
                            color: Colors.black38),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                margin: const EdgeInsets.only(top: 20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.black26)),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                        height: 30,
                        width: 30,
                        margin: const EdgeInsets.only(right: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: ManageTheme.nearlyBlack),
                        child: const Icon(
                          FontAwesomeIcons.plus,
                          color: ManageTheme.backgroundWhite,
                          size: 15,
                        )),
                    Container(
                      margin: const EdgeInsets.only(right: 7),
                      child: Text(
                        "Create New Task",
                        style: ManageTheme.insideAppText(
                            size: screenWidth / 25,
                            weight: FontWeight.w500,
                            color: ManageTheme.nearlyBlack),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
