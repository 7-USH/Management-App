// ignore_for_file: prefer_const_constructors, must_be_immutable, non_constant_identifier_names, unused_local_variable, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:manage_app/home/models/staff_leave_application_model.dart';
import 'package:manage_app/home/service/home_service.dart';
import 'package:manage_app/utils/manage_theme.dart';

class LeaveRequestCard extends StatefulWidget {
  LeaveRequestCard({super.key, required this.model});
  StaffLeaveApplicationModel model;
  @override
  State<LeaveRequestCard> createState() => _LeaveRequestCardState();
}

class _LeaveRequestCardState extends State<LeaveRequestCard> {
  DateFormat formatter = DateFormat("yyyy-MM-dd HH:mm");
  String starting_day = "";
  String status = "awaiting";
  String ending_day = "";
  HomeService service = HomeService();

  @override
  void initState() {
    status = widget.model.leaveApplication!.status!;
    String start_date = widget.model.leaveApplication!.startingDate!
        .replaceAll("T", ' ')
        .replaceAll("Z", "");
    String end_date = widget.model.leaveApplication!.endingDate!
        .replaceAll("T", ' ')
        .replaceAll("Z", "");
    var start_dateTime = formatter.parse(start_date).toLocal();
    var end_dateTime = formatter.parse(end_date).toLocal();
    starting_day =
        "${DateFormat.d().format(start_dateTime)} ${DateFormat.MMMM().format(start_dateTime)}";
    ending_day =
        "${DateFormat.d().format(end_dateTime)} ${DateFormat.MMMM().format(end_dateTime)}";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Color chipColor = Colors.green;
    if (widget.model.leaveApplication!.status != "rejected") {
      chipColor = Colors.green;
    } else {
      chipColor = Colors.redAccent;
    }

    return Container(
      padding: const EdgeInsets.all(14),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const CircleAvatar(
                backgroundColor: ManageTheme.nearlyBlack,
                radius: 25,
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: RichText(
                        text: TextSpan(children: [
                          TextSpan(
                              text: widget.model.staffDetails!.fullName,
                              style: ManageTheme.appText(
                                  size: 14, weight: FontWeight.bold)),
                          TextSpan(
                              text: " Applied for",
                              style: ManageTheme.appText(
                                  size: 14, weight: FontWeight.w500)),
                          TextSpan(
                              text: " Leave from $starting_day to $ending_day.",
                              style: ManageTheme.appText(
                                  size: 14, weight: FontWeight.w400))
                        ]),
                      )),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      margin: const EdgeInsets.only(top: 10),
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: widget.model.leaveApplication!.status! ==
                              "awaiting"
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () {
                                      service
                                          .approveApplication(
                                              context: context,
                                              leave_id: widget
                                                  .model.leaveApplication!.id!)
                                          .then((value) {
                                        setState(() {
                                          widget.model.leaveApplication!
                                              .status = "approved";
                                        });
                                      });
                                    },
                                    style: ManageTheme.buttonStyle(
                                        backColor: ManageTheme.successGreen),
                                    child: Text(
                                      "Approve",
                                      style: ManageTheme.insideAppText(
                                          size: 11,
                                          weight: FontWeight.w600,
                                          color: ManageTheme.backgroundWhite),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 14,
                                ),
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () {
                                      service
                                          .rejectApplication(
                                              context: context,
                                              leave_id: widget
                                                  .model.leaveApplication!.id!)
                                          .then((value) {
                                        setState(() {
                                          widget.model.leaveApplication!
                                              .status = "rejected";
                                        });
                                      });
                                    },
                                    style: ManageTheme.buttonStyle(
                                        backColor: Colors.redAccent.shade400),
                                    child: Text(
                                      "Reject",
                                      style: ManageTheme.insideAppText(
                                          size: 11,
                                          weight: FontWeight.w600,
                                          color: ManageTheme.nearlyWhite),
                                    ),
                                  ),
                                )
                              ],
                            )
                          : Align(
                              alignment: Alignment.centerLeft,
                              child: Chip(
                                  backgroundColor: chipColor.withOpacity(0.2),
                                  label: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        FontAwesomeIcons.clock,
                                        color: chipColor,
                                        size:
                                            MediaQuery.of(context).size.width /
                                                34,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        widget.model.leaveApplication!.status!
                                            .toUpperCase(),
                                        style: ManageTheme.insideAppText(
                                            color: chipColor,
                                            size: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                38,
                                            weight: FontWeight.w500),
                                      )
                                    ],
                                  )),
                            ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.only(top: 10),
                    child: InkWell(
                      onTap: () {},
                      child: Row(
                        children: [
                          Icon(Icons.info,
                              size: MediaQuery.of(context).size.width / 25,
                              color: Colors.grey.shade700),
                          const SizedBox(
                            width: 6,
                          ),
                          Text(
                            "View details",
                            style: ManageTheme.appText(
                                size: MediaQuery.of(context).size.width / 36,
                                weight: FontWeight.w400,
                                color: Colors.grey.shade700),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              "12/3/22",
              style: ManageTheme.insideAppText(
                  size: 9, weight: FontWeight.w500, color: Colors.grey),
            ),
          )
        ],
      ),
    );
  }
}
