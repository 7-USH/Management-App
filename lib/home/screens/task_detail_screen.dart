// ignore_for_file: unused_local_variable, prefer_const_literals_to_create_immutables, prefer_const_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:manage_app/task/models/display_task_model.dart';
import 'package:manage_app/utils/manage_theme.dart';

class TaskDetailScreen extends StatefulWidget {
  TaskDetailScreen({super.key, required this.model});
  DisplayStaffTaskModel model;

  @override
  State<TaskDetailScreen> createState() => _TaskDetailScreenState();
}

class _TaskDetailScreenState extends State<TaskDetailScreen> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    Color chipColor = ManageTheme.successGreen;
    if (widget.model.priority == "High") {
      chipColor = Colors.redAccent.shade200;
    } else if (widget.model.priority == "Medium") {
      chipColor = Colors.amber;
    }
    return Scaffold(
      backgroundColor: ManageTheme.nearlyWhite,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: ManageTheme.nearlyBlack,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
        child: Column(
          children: [
            Container(
                alignment: Alignment.topLeft,
                child: Chip(
                  backgroundColor: ManageTheme.successGreen.withOpacity(0.6),
                  label: Text(
                    widget.model.status!.toUpperCase(),
                    style: ManageTheme.insideAppText(
                        size: MediaQuery.of(context).size.width / 40,
                        weight: FontWeight.bold,
                        color: ManageTheme.nearlyBlack),
                  ),
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    alignment: Alignment.topLeft,
                    height: MediaQuery.of(context).size.height / 6,
                    margin: const EdgeInsets.only(bottom: 10),
                    child: Text(
                      widget.model.taskTitle!,
                      style: ManageTheme.insideAppText(
                          size: screenWidth / 13,
                          weight: FontWeight.w700,
                          isShadow: true),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    alignment: Alignment.bottomRight,
                    height: MediaQuery.of(context).size.height / 6,
                    margin: const EdgeInsets.only(bottom: 10),
                    child: Chip(
                      backgroundColor: ManageTheme.nearlyBlack,
                      label: Text(
                        "Jan 2021",
                        style: ManageTheme.insideAppText(
                            size: screenWidth / 30,
                            weight: FontWeight.w600,
                            color: ManageTheme.backgroundWhite,
                            isShadow: true),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            margin: EdgeInsets.only(bottom: 7),
                            child: Text(
                              "Date",
                              style: ManageTheme.insideAppText(
                                  size: screenWidth / 30,
                                  weight: FontWeight.w500,
                                  color: Colors.grey.shade500),
                            )),
                        Text(
                          "15 Monday, 2021",
                          style: ManageTheme.insideAppText(
                            size: screenWidth / 29,
                            weight: FontWeight.w600,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  height: screenHeight / 11,
                  width: 1.5,
                  color: Colors.grey.shade300,
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.centerRight,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            margin: EdgeInsets.only(bottom: 7),
                            child: Text(
                              "Time",
                              style: ManageTheme.insideAppText(
                                  size: screenWidth / 30,
                                  weight: FontWeight.w500,
                                  color: Colors.grey.shade500),
                            )),
                        Text(
                          "6:00 PM-9:00 PM",
                          style: ManageTheme.insideAppText(
                            size: screenWidth / 29,
                            weight: FontWeight.w600,
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
            Container(
              height: 1.5,
              width: screenWidth,
              color: Colors.grey.shade300,
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(bottom: 10, top: 15),
              child: Text(
                "Description",
                style: ManageTheme.insideAppText(
                    size: screenWidth / 18,
                    weight: FontWeight.w700,
                    isShadow: true),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(bottom: 15),
              child: Text(
                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum",
                textAlign: TextAlign.justify,
                style: ManageTheme.insideAppText(
                    size: screenWidth / 27,
                    weight: FontWeight.w500,
                    color: Colors.black45),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(bottom: 0),
              child: Text(
                "Priority",
                style: ManageTheme.insideAppText(
                    size: screenWidth / 18,
                    weight: FontWeight.w700,
                    isShadow: true),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: Chip(
                backgroundColor: chipColor,
                padding: EdgeInsets.symmetric(horizontal: 10),
                label: Text(widget.model.priority!.toUpperCase(),
                    style: ManageTheme.insideAppText(
                      size: MediaQuery.of(context).size.width / 32,
                      weight: FontWeight.w700,
                      color: ManageTheme.backgroundWhite,
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
