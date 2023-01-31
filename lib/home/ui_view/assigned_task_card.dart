// ignore_for_file: must_be_immutable, prefer_const_constructors, unused_local_variable, avoid_print, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:manage_app/utils/manage_theme.dart';

import '../../task/models/display_admin_task_model.dart';

class AssignedTaskCard extends StatefulWidget {
  AssignedTaskCard(
      {super.key,
      required this.model,
      this.isCurrent = false,
      required this.index});
  DisplayAdminTaskModel model;
  bool isCurrent;
  String index;

  @override
  State<AssignedTaskCard> createState() => _AssignedTaskCardState();
}

class _AssignedTaskCardState extends State<AssignedTaskCard> {
  DateFormat formatter = DateFormat("yyyy-MM-dd HH:mm");
  String display_date = "";

  @override
  void initState() {
    if (widget.model.validFrom!.isNotEmpty) {
      String date =
          widget.model.validFrom!.replaceAll("T", ' ').replaceAll("Z", "");
      var dateTime = formatter.parse(date, true).toLocal();
      setState(() {
        display_date = DateFormat("h:mm a").format(dateTime);
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Color chipColor = ManageTheme.successGreen;
    if (widget.model.priority == "High") {
      chipColor = Colors.redAccent.shade200;
    } else if (widget.model.priority == "Medium") {
      chipColor = Colors.amber;
    }
    return Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          padding:
              const EdgeInsets.only(top: 25, bottom: 15, left: 25, right: 25),
          margin: EdgeInsets.symmetric(vertical: 5),
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(.5),
                  blurRadius: 3.0, // soften the shadow
                  spreadRadius: 1.0, //extend the shadow
                  offset: Offset(
                    3.0, // Move to right 10  horizontally
                    2.0, // Move to bottom 10 Vertically
                  ),
                ),
              ],
              color: !widget.isCurrent
                  ? ManageTheme.nearlyBlack
                  : ManageTheme.nearlyGrey,
              borderRadius: BorderRadius.circular(40)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.topLeft,
                height: MediaQuery.of(context).size.height / 7,
                margin: EdgeInsets.only(bottom: 10),
                child: Text(
                  "${widget.index}. ${widget.model.taskTitle!}",
                  style: ManageTheme.insideAppText(
                    size: MediaQuery.of(context).size.width / 15,
                    weight: FontWeight.bold,
                    color: !widget.isCurrent
                        ? ManageTheme.nearlyWhite
                        : ManageTheme.nearlyBlack,
                  ),
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        FontAwesomeIcons.clock,
                        size: MediaQuery.of(context).size.width / 16.5,
                        color: ManageTheme.nearlyBlack,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "${widget.model.validFor!} HR",
                        style: ManageTheme.insideAppText(
                          size: MediaQuery.of(context).size.width / 21,
                          weight: FontWeight.bold,
                          color: ManageTheme.nearlyBlack,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const Spacer(),
              widget.model.priority!.isEmpty
                  ? SizedBox()
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Chip(
                          elevation: 3,
                          padding: EdgeInsets.zero,
                          label: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                FontAwesomeIcons.businessTime,
                                size: MediaQuery.of(context).size.width / 40,
                                color: ManageTheme.nearlyBlack,
                              ),
                              SizedBox(width: 7),
                              Text(
                                display_date,
                                style: ManageTheme.insideAppText(
                                  size: MediaQuery.of(context).size.width / 40,
                                  weight: FontWeight.bold,
                                  color: ManageTheme.nearlyBlack,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Chip(
                          elevation: 3,
                          backgroundColor: chipColor,
                          label: Text(widget.model.priority!.toUpperCase(),
                              style: ManageTheme.insideAppText(
                                size: MediaQuery.of(context).size.width / 32,
                                weight: FontWeight.w700,
                                color: !widget.isCurrent
                                    ? ManageTheme.nearlyBlack
                                    : ManageTheme.backgroundWhite,
                              )),
                        ),
                      ],
                    )
            ],
          ),
        ),
        widget.isCurrent
            ? Align(
                alignment: Alignment.topRight,
                child: Chip(
                  backgroundColor: ManageTheme.successGreen.withOpacity(0.7),
                  elevation: 3,
                  label: Text(
                    widget.model.status!.toUpperCase(),
                    style: ManageTheme.insideAppText(
                      size: MediaQuery.of(context).size.width / 40,
                      weight: FontWeight.bold,
                      color: !widget.isCurrent
                          ? ManageTheme.nearlyWhite
                          : ManageTheme.nearlyBlack,
                    ),
                  ),
                ),
              )
            : SizedBox()
      ],
    );
  }
}
