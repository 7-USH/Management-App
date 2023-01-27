// ignore_for_file: unused_local_variable, prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_field, avoid_print

import 'dart:math';

import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:manage_app/task/models/task_model.dart';
import 'package:manage_app/task/service/task_service.dart';
import 'package:manage_app/utils/manage_theme.dart';

class TaskAddScreen extends StatefulWidget {
  const TaskAddScreen({super.key});

  @override
  State<TaskAddScreen> createState() => _TaskAddScreenState();
}

class _TaskAddScreenState extends State<TaskAddScreen> {
  String value = "Low";
  final TextEditingController _taskTitleController = TextEditingController();
  final TextEditingController _taskDescriptionController =
      TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _validityController = TextEditingController();
  final TextEditingController _validTimeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  TaskService service = TaskService();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      bottomNavigationBar: Container(
        margin: EdgeInsets.all(20),
        child: Row(
          children: [
            Expanded(
                flex: 1,
                child: SizedBox(
                    height: 50,
                    child: ElevatedButton(
                        style: ManageTheme.buttonStyle(
                            backColor: ManageTheme.nearlyWhite,
                            borderColor: ManageTheme.nearlyBlack),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Cancel",
                          style: ManageTheme.insideAppText(
                              size: screenWidth / 25, weight: FontWeight.w600),
                        )))),
            SizedBox(
              width: 15,
            ),
            Expanded(
                flex: 2,
                child: SizedBox(
                  height: 50,
                  child: ElevatedButton(
                      style: ManageTheme.buttonStyle(
                        backColor: ManageTheme.nearlyBlack,
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            _isLoading = true;
                          });
                          service
                              .createTask(
                                  context: context,
                                  model: StaffTaskModel(
                                    validFor:
                                        int.parse(_validityController.text),
                                    validFrom:
                                        "${_dateController.text} ${_validTimeController.text}",
                                    staffEmails: ["ewhfbevwd@gmail.com"],
                                    taskTitle: _taskTitleController.text,
                                    description:
                                        _taskDescriptionController.text,
                                    priority: value,
                                  ))
                              .then((value) {
                            setState(() {
                              _isLoading = false;
                            });
                            Navigator.pop(context);
                          });
                        }
                      },
                      child: _isLoading
                          ? Center(
                              child: LoadingAnimationWidget.staggeredDotsWave(
                              color: Colors.white,
                              size: 20,
                            ))
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(Icons.check),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Create Task",
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
      backgroundColor: ManageTheme.nearlyWhite,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: ManageTheme.nearlyBlack,
        elevation: 0.0,
        title: Text(
          "Create New Task",
          style: ManageTheme.insideAppText(size: 25, weight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Column(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(bottom: 10),
                    child: Text(
                      "Task Title",
                      style: ManageTheme.insideAppText(
                          size: screenWidth / 20, weight: FontWeight.w600),
                    ),
                  ),
                  TextFormField(
                    cursorColor: ManageTheme.nearlyBlack,
                    controller: _taskTitleController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter task title";
                      }
                      return null;
                    },
                    decoration: ManageTheme.faInputDecoration(
                        hint: "Enter Task Title", fontSize: 16, radius: 7),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Column(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(bottom: 10),
                    child: Text(
                      "Task Description",
                      style: ManageTheme.insideAppText(
                          size: screenWidth / 20, weight: FontWeight.w600),
                    ),
                  ),
                  TextFormField(
                    cursorColor: ManageTheme.nearlyBlack,
                    controller: _taskDescriptionController,
                    maxLines: 6,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter description";
                      }
                      return null;
                    },
                    decoration: ManageTheme.faInputDecoration(
                        hint: "Enter Task Description",
                        fontSize: 16,
                        radius: 7),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Column(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(bottom: 10),
                    child: Text(
                      "Date & Time",
                      style: ManageTheme.insideAppText(
                          size: screenWidth / 20, weight: FontWeight.w600),
                    ),
                  ),
                  TextFormField(
                    cursorColor: ManageTheme.nearlyBlack,
                    controller: _dateController,
                    keyboardType: TextInputType.datetime,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter date";
                      }
                      return null;
                    },
                    decoration: ManageTheme.faInputDecoration(
                        hint: "Enter a Date",
                        fontSize: 16,
                        radius: 7,
                        suffixIcon: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              FontAwesomeIcons.clock,
                              color: Colors.black45,
                            ))),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      cursorColor: ManageTheme.nearlyBlack,
                      keyboardType: TextInputType.datetime,
                      controller: _validTimeController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter valid time";
                        }
                        return null;
                      },
                      decoration: ManageTheme.faInputDecoration(
                          fontSize: 16,
                          radius: 7,
                          hint: "Enter valid from",
                          suffixIcon: IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.close,
                                color: Colors.black45,
                              ))),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: TextFormField(
                      cursorColor: ManageTheme.nearlyBlack,
                      controller: _validityController,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter valid due";
                        }
                        return null;
                      },
                      decoration: ManageTheme.faInputDecoration(
                          fontSize: 16,
                          radius: 7,
                          hint: "Enter valid for",
                          suffixIcon: IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.close,
                                color: Colors.black45,
                              ))),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Column(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(bottom: 10),
                    child: Text(
                      "Priority",
                      style: ManageTheme.insideAppText(
                          size: screenWidth / 20, weight: FontWeight.w600),
                    ),
                  ),
                  AnimatedToggleSwitch<String>.size(
                    current: value,
                    borderRadius: BorderRadius.circular(16),
                    values: const ["Low", "Medium", "High"],
                    iconOpacity: 0.2,
                    indicatorSize: Size.fromWidth(screenWidth),
                    iconBuilder: (value, size) {
                      return Center(
                        child: Text(
                          value,
                          style: ManageTheme.insideAppText(
                              size: min(size.width / 1.8, size.height),
                              weight: FontWeight.w600),
                        ),
                      );
                    },
                    borderColor: Colors.grey,
                    borderWidth: 1,
                    colorBuilder: (i) {
                      if (i == "Low") {
                        return ManageTheme.successGreen;
                      } else if (i == "Medium") {
                        return Colors.amber;
                      } else {
                        return Colors.redAccent.shade400;
                      }
                    },
                    onChanged: (i) => setState(() => value = i),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(bottom: 10),
                    child: Text(
                      "Assignee",
                      style: ManageTheme.insideAppText(
                          size: screenWidth / 20, weight: FontWeight.w600),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                    child: ListView(
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        children: List.generate(
                          3,
                          (index) => Container(
                            height: 50,
                            width: 50,
                            margin: const EdgeInsets.only(right: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                color: ManageTheme.nearlyBlack),
                          ),
                        )..add(
                            Container(
                                height: 50,
                                width: 50,
                                margin: const EdgeInsets.only(right: 10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                    color: ManageTheme.nearlyBlack),
                                child: Icon(
                                  FontAwesomeIcons.plus,
                                  color: ManageTheme.backgroundWhite,
                                  size: screenWidth / 25,
                                )),
                          )),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
