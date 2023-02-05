// ignore_for_file: unused_local_variable, prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_field, avoid_print, body_might_complete_normally_nullable, prefer_const_constructors_in_immutables, non_constant_identifier_names

import 'dart:math';

import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:manage_app/task/models/display_admin_task_model.dart';
import 'package:manage_app/task/models/task_model.dart';
import 'package:manage_app/task/service/task_service.dart';
import 'package:manage_app/utils/manage_theme.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class TaskUpdateScreen extends StatefulWidget {
  TaskUpdateScreen({super.key, required this.model, required this.id});
  final DisplayAdminTaskModel model;
  final String id;

  @override
  State<TaskUpdateScreen> createState() => _TaskUpdateScreenState();
}

class _TaskUpdateScreenState extends State<TaskUpdateScreen> {
  String value = "Low";
  final TextEditingController _taskTitleController = TextEditingController();
  final TextEditingController _taskDescriptionController =
      TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _validFromController = TextEditingController();
  final TextEditingController _validForController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  TaskService service = TaskService();
  bool _isLoading = false;
  TimeOfDay selectedTime = TimeOfDay.now();
  DateFormat formatter = DateFormat("yyyy-MM-dd HH:mm");
  Future<TimeOfDay?> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedS = await showTimePicker(
      context: context,
      initialTime: selectedTime,
      initialEntryMode: TimePickerEntryMode.dialOnly,
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: ColorScheme.light(
              primary: ManageTheme.nearlyBlack,
              // change the text color
              onSurface: Colors.grey,
            ),
          ),
          child: MediaQuery(
              data:
                  MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
              child: child!),
        );
      },
    );
    if (pickedS != null && pickedS != selectedTime) {
      setState(() {
        selectedTime = pickedS;
      });
      return selectedTime;
    }
  }

  @override
  void initState() {
    print(widget.model.validFrom!);
    value = widget.model.priority!;
    String demo_date =
        widget.model.validFrom!.replaceAll("T", ' ').replaceAll("Z", "");
    var dateTime = formatter.parse(demo_date).toLocal();
    _taskTitleController.text = widget.model.taskTitle!;
    _dateController.text = DateFormat("dd/MM/yy").format(dateTime).toString();
    _validForController.text = widget.model.validFor!.toInt().toString();
    _validFromController.text = DateFormat("HH:MM").format(dateTime).toString();
    _taskDescriptionController.text = widget.model.description!;
    super.initState();
  }

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      _dateController.text =
          DateFormat("dd/MM/yy").format(args.value).toString();
    });
  }

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
                              .updateTask(
                                  context: context,
                                  model: StaffTaskModel(
                                    id: widget.id,
                                    validFor:
                                        int.parse(_validForController.text),
                                    validFrom:
                                        "${_dateController.text} ${_validFromController.text}",
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
                                Icon(Icons.update),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Update Task",
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
          "Update Task",
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
                    enabled: false,
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
              Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.only(bottom: 10),
                child: Row(
                  children: [
                    Icon(
                      Icons.info,
                      size: screenWidth / 22,
                    ),
                    const SizedBox(
                      width: 6,
                    ),
                    Text(
                      "Select date from the picker",
                      style: ManageTheme.appText(
                          size: screenWidth / 34, weight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10)),
                child: SfDateRangePicker(
                  headerHeight: 50,
                  selectionColor: ManageTheme.nearlyBlack,
                  onSelectionChanged: _onSelectionChanged,
                  view: DateRangePickerView.month,
                  headerStyle: DateRangePickerHeaderStyle(
                      textStyle: ManageTheme.insideAppText(
                          size: screenWidth / 21, weight: FontWeight.w600)),
                  selectionTextStyle: const TextStyle(color: Colors.white),
                  startRangeSelectionColor: ManageTheme.nearlyBlack,
                  endRangeSelectionColor: ManageTheme.nearlyBlack,
                  rangeSelectionColor: Colors.grey.shade300,
                  enablePastDates: false,
                  todayHighlightColor: ManageTheme.nearlyBlack,
                  monthViewSettings: DateRangePickerMonthViewSettings(
                      viewHeaderStyle: DateRangePickerViewHeaderStyle(
                          textStyle: ManageTheme.insideAppText(
                              size: screenWidth / 30,
                              weight: FontWeight.bold))),
                  monthCellStyle: DateRangePickerMonthCellStyle(
                      textStyle: ManageTheme.insideAppText(
                          size: screenWidth / 30, weight: FontWeight.w500)),
                  selectionMode: DateRangePickerSelectionMode.single,
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      cursorColor: ManageTheme.nearlyBlack,
                      keyboardType: TextInputType.none,
                      controller: _validFromController,
                      onTap: () async {
                        TimeOfDay? timeOfDay = await _selectTime(context);
                        if (timeOfDay != null) {
                          _validFromController.text =
                              "${timeOfDay.hour.toString().padLeft(2, "0")}:${timeOfDay.minute.toString().padLeft(2, "0")}";
                        }
                      },
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
                              onPressed: () {
                                _validFromController.clear();
                              },
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
                      controller: _validForController,
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
                              onPressed: () {
                                _validForController.clear();
                              },
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
