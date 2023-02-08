// ignore_for_file: must_be_immutable, non_constant_identifier_names, unused_import

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:manage_app/attendance/models/leave_history_model.dart';
import 'package:manage_app/utils/manage_theme.dart';

class StatusCard extends StatefulWidget {
  StatusCard({super.key, required this.model});
  LeaveHistoryModel model;

  @override
  State<StatusCard> createState() => _StatusCardState();
}

class _StatusCardState extends State<StatusCard> {
  DateFormat formatter = DateFormat("yyyy-MM-dd HH:mm");
  String starting_day = "";
  String ending_day = "";

  @override
  void initState() {
    String start_date =
        widget.model.startingDate!.replaceAll("T", ' ').replaceAll("Z", "");
    String end_date =
        widget.model.endingDate!.replaceAll("T", ' ').replaceAll("Z", "");
    var start_dateTime = formatter.parse(start_date).toLocal();
    var end_dateTime = formatter.parse(end_date).toLocal();
    starting_day =
        "${DateFormat.d().format(start_dateTime)} ${DateFormat.MMM().format(start_dateTime)}";
    ending_day =
        "${DateFormat.d().format(end_dateTime)} ${DateFormat.MMM().format(end_dateTime)}";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Color chipColor = Colors.green;
    if (widget.model.status == "approved") {
      chipColor = Colors.green;
    } else if (widget.model.status! == "awaiting") {
      chipColor = Colors.amber;
    } else {
      chipColor = Colors.redAccent;
    }
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      decoration: BoxDecoration(
        color: ManageTheme.backgroundWhite,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: ManageTheme.nearlyGrey),
      ),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: screenWidth / 1.8,
                  child: Text(
                    widget.model.leaveSubject!,
                    overflow: TextOverflow.ellipsis,
                    style: ManageTheme.insideAppText(
                        size: screenWidth / 24, weight: FontWeight.w600),
                  ),
                ),
                Chip(
                    backgroundColor: chipColor.withOpacity(0.2),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    label: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          FontAwesomeIcons.clock,
                          color: chipColor,
                          size: MediaQuery.of(context).size.width / 34,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          widget.model.status!.toUpperCase(),
                          style: ManageTheme.insideAppText(
                              color: chipColor,
                              size: MediaQuery.of(context).size.width / 40,
                              weight: FontWeight.w600),
                        )
                      ],
                    )),
              ],
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: screenWidth / 20,
                child: Icon(
                  FontAwesomeIcons.calendarDays,
                  color: Colors.black38,
                  size: screenWidth / 22,
                ),
              ),
              SizedBox(
                width: screenWidth / 35,
              ),
              RichText(
                text: TextSpan(children: [
                  TextSpan(
                    text: "Leave from :  ",
                    style: ManageTheme.insideAppText(
                        color: Colors.black38,
                        size: MediaQuery.of(context).size.width / 30,
                        weight: FontWeight.w600),
                  ),
                  TextSpan(
                    text: "$starting_day - $ending_day",
                    style: ManageTheme.insideAppText(
                        size: MediaQuery.of(context).size.width / 30,
                        weight: FontWeight.w600),
                  )
                ]),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: screenWidth / 20,
                child: CircleAvatar(
                  radius: screenWidth / 35,
                  backgroundColor: ManageTheme.nearlyBlack,
                ),
              ),
              SizedBox(
                width: screenWidth / 35,
              ),
              RichText(
                text: TextSpan(children: [
                  TextSpan(
                    text: "Manager :  ",
                    style: ManageTheme.insideAppText(
                        color: Colors.black38,
                        size: MediaQuery.of(context).size.width / 30,
                        weight: FontWeight.w600),
                  ),
                  TextSpan(
                    text: "Tushar Mali",
                    style: ManageTheme.insideAppText(
                        size: MediaQuery.of(context).size.width / 30,
                        weight: FontWeight.w600),
                  )
                ]),
              )
            ],
          ),
          Container(
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.only(top: 15),
            child: Text('“ ${widget.model.reason!.trim()} ”',
                style: ManageTheme.appText(
                    size: screenWidth / 25,
                    weight: FontWeight.w500,
                    color: Colors.black45,
                    style: FontStyle.italic)),
          )
        ],
      ),
    );
  }
}
