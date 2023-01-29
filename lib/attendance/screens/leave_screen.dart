// ignore_for_file: unused_local_variable, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:manage_app/utils/manage_theme.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class LeaveScreen extends StatefulWidget {
  const LeaveScreen({super.key});

  @override
  State<LeaveScreen> createState() => _LeaveScreenState();
}

class _LeaveScreenState extends State<LeaveScreen> {
  bool _isLoading = false;
  TextEditingController fromController = TextEditingController();
  TextEditingController toController = TextEditingController();

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      fromController.text =
          DateFormat("dd/MM/yy").format(args.value.startDate).toString();
      toController.text = DateFormat("dd/MM/yy")
          .format(args.value.endDate ?? args.value.startDate)
          .toString();
    });
  }

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
          "Request Leave",
          style: ManageTheme.insideAppText(size: 25, weight: FontWeight.bold),
        ),
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.all(20),
        child: Row(
          children: [
            Expanded(
                child: SizedBox(
              height: 50,
              child: ElevatedButton(
                  style: ManageTheme.buttonStyle(
                    backColor: ManageTheme.nearlyBlack,
                  ),
                  onPressed: () {},
                  child: _isLoading
                      ? Center(
                          child: LoadingAnimationWidget.staggeredDotsWave(
                          color: Colors.white,
                          size: 20,
                        ))
                      : Center(
                          child: Text(
                            "Apply for Leave",
                            style: ManageTheme.insideAppText(
                                size: screenWidth / 25,
                                weight: FontWeight.w600,
                                color: ManageTheme.backgroundWhite),
                          ),
                        )),
            ))
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        physics: const BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.only(bottom: 10),
                  child: Text(
                    "Leave Subject",
                    style: ManageTheme.insideAppText(
                        size: screenWidth / 21, weight: FontWeight.w600),
                  ),
                ),
                TextFormField(
                  cursorColor: ManageTheme.nearlyBlack,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter leave title";
                    }
                    return null;
                  },
                  decoration: ManageTheme.faInputDecoration(
                      hint: "Enter Leave Title", fontSize: 16, radius: 7),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.only(bottom: 10),
                  child: Text(
                    "Reason",
                    style: ManageTheme.insideAppText(
                        size: screenWidth / 21, weight: FontWeight.w600),
                  ),
                ),
                TextFormField(
                  maxLines: 5,
                  cursorColor: ManageTheme.nearlyBlack,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter reason";
                    }
                    return null;
                  },
                  decoration: ManageTheme.faInputDecoration(
                      hint: "Enter Reason For Taking Leave",
                      fontSize: 16,
                      radius: 7),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: const EdgeInsets.only(bottom: 10),
                        child: Text(
                          "From",
                          style: ManageTheme.insideAppText(
                              size: screenWidth / 21, weight: FontWeight.w600),
                        ),
                      ),
                      TextFormField(
                        cursorColor: ManageTheme.nearlyBlack,
                        enabled: false,
                        controller: fromController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter date";
                          }
                          return null;
                        },
                        decoration: ManageTheme.faInputDecoration(
                            hint: "Select Date from", fontSize: 16, radius: 7),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: const EdgeInsets.only(bottom: 10),
                        child: Text(
                          "To",
                          style: ManageTheme.insideAppText(
                              size: screenWidth / 21, weight: FontWeight.w600),
                        ),
                      ),
                      TextFormField(
                        cursorColor: ManageTheme.nearlyBlack,
                        enabled: false,
                        controller: toController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter date";
                          }
                          return null;
                        },
                        decoration: ManageTheme.faInputDecoration(
                            hint: "Select Date to", fontSize: 16, radius: 7),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
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
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10)),
              child: SfDateRangePicker(
                headerHeight: 50,
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
                            size: screenWidth / 30, weight: FontWeight.bold))),
                monthCellStyle: DateRangePickerMonthCellStyle(
                    textStyle: ManageTheme.insideAppText(
                        size: screenWidth / 30, weight: FontWeight.w500)),
                selectionMode: DateRangePickerSelectionMode.range,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
