// ignore_for_file: unused_local_variable, prefer_const_literals_to_create_immutables, prefer_const_constructors, must_be_immutable, non_constant_identifier_names, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:manage_app/home/service/home_service.dart';
import 'package:manage_app/task/models/display_admin_task_model.dart';
import 'package:manage_app/task/models/display_task_model.dart';
import 'package:manage_app/utils/manage_theme.dart';

class TaskDetailScreen extends StatefulWidget {
  TaskDetailScreen(
      {super.key,
      required this.model,
      required this.staff_details,
      required this.profile});
  DisplayStaffTaskModel model;
  String profile;
  List<StaffDetails> staff_details;

  @override
  State<TaskDetailScreen> createState() => _TaskDetailScreenState();
}

class _TaskDetailScreenState extends State<TaskDetailScreen> {
  String date = "15 Monday, 2021";
  String time_range = "6:00 PM-9:00 PM";
  String month = "Jan 2021";
  DateFormat formatter = DateFormat("yyyy-MM-dd HH:mm");
  bool _isLoading = false;
  HomeService service = HomeService();
  bool onCompletion = false;

  @override
  void initState() {
    String demo_date =
        widget.model.validFrom!.replaceAll("T", ' ').replaceAll("Z", "");
    var dateTime = formatter.parse(demo_date).toLocal();
    date =
        "${DateFormat.d().format(dateTime)} ${DateFormat.EEEE().format(dateTime)}, ${DateFormat.y().format(dateTime)}";
    month =
        "${DateFormat.MMM().format(dateTime)} ${DateFormat.y().format(dateTime)}";
    time_range =
        "${DateFormat("h:mm a").format(dateTime)}-${DateFormat("h:mm a").format(dateTime)}";
    super.initState();
  }

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
      bottomNavigationBar: onCompletion ||
              widget.model.status! != "Active" ||
              widget.profile != "staff"
          ? null
          : Container(
              margin: EdgeInsets.all(20),
              child: Row(
                children: [
                  Expanded(
                      flex: 2,
                      child: SizedBox(
                        height: 50,
                        child: ElevatedButton(
                            style: ManageTheme.buttonStyle(
                              backColor: ManageTheme.nearlyBlack,
                            ),
                            onPressed: () {
                              setState(() {
                                _isLoading = true;
                              });
                              service.updateStatusTask(
                                  context: context,
                                  requestBody: {
                                    "task_id": widget.model.id!,
                                    "status": "Completed"
                                  }).then((value) {
                                setState(() {
                                  _isLoading = false;
                                  onCompletion = true;
                                });
                              }).onError((error, stackTrace) {
                                setState(() {
                                  _isLoading = false;
                                });
                              });
                            },
                            child: _isLoading
                                ? Center(
                                    child: LoadingAnimationWidget
                                        .staggeredDotsWave(
                                    color: Colors.white,
                                    size: 20,
                                  ))
                                : Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Done",
                                        style: ManageTheme.insideAppText(
                                            size: screenWidth / 25,
                                            weight: FontWeight.w600,
                                            color: ManageTheme.backgroundWhite),
                                      ),
                                    ],
                                  )),
                      ))
                ],
              ),
            ),
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
                child: Row(
                  children: [
                    Text(
                      "status:  ",
                      style: ManageTheme.insideAppText(
                        size: screenWidth / 30,
                        weight: FontWeight.w500,
                        color: Colors.grey.shade500,
                      ),
                    ),
                    Chip(
                      backgroundColor:
                          ManageTheme.successGreen.withOpacity(0.6),
                      padding: EdgeInsets.zero,
                      label: Text(
                        widget.model.status!.toUpperCase(),
                        style: ManageTheme.insideAppText(
                            size: MediaQuery.of(context).size.width / 40,
                            weight: FontWeight.bold,
                            color: ManageTheme.nearlyBlack),
                      ),
                    ),
                  ],
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
                        month,
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
                          date,
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
                          time_range,
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
                widget.model.description!.trim(),
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
              margin: EdgeInsets.only(bottom: 10),
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
            widget.staff_details.isEmpty
                ? SizedBox()
                : Column(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: const EdgeInsets.only(bottom: 10),
                        child: Text(
                          "Assignee",
                          style: ManageTheme.insideAppText(
                              size: screenWidth / 18,
                              weight: FontWeight.w700,
                              isShadow: true),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: SizedBox(
                          height: 50,
                          child: ListView(
                              scrollDirection: Axis.horizontal,
                              physics: const BouncingScrollPhysics(),
                              shrinkWrap: true,
                              children: List.generate(
                                widget.staff_details.length,
                                (index) => Container(
                                  height: 50,
                                  width: 50,
                                  margin: const EdgeInsets.only(right: 10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                      color: ManageTheme.nearlyBlack),
                                ),
                              )),
                        ),
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
