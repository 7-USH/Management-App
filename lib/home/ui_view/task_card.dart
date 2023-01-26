// ignore_for_file: must_be_immutable, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:manage_app/home/models/task_model.dart';
import 'package:manage_app/utils/manage_theme.dart';

class TaskCard extends StatefulWidget {
  TaskCard({super.key, required this.model, this.isCurrent = false});
  TaskModel model;
  bool isCurrent;

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(.5),
              blurRadius: 3.0, // soften the shadow
              spreadRadius: 1.0, //extend the shadow
              offset: Offset(
                3.0, // Move to right 10  horizontally
                0.0, // Move to bottom 10 Vertically
              ),
            ),
          ],
          color: widget.isCurrent
              ? ManageTheme.nearlyBlack
              : ManageTheme.nearlyGrey,
          borderRadius: BorderRadius.circular(40)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.model.task_number,
            style: ManageTheme.insideAppText(
              size: 35,
              weight: FontWeight.bold,
              color: widget.isCurrent
                  ? ManageTheme.nearlyWhite
                  : ManageTheme.nearlyBlack,
            ),
          ),
          Text(widget.model.task_message,
              style: ManageTheme.insideAppText(
                size: 15,
                weight: FontWeight.w400,
                color: widget.isCurrent
                    ? ManageTheme.nearlyWhite
                    : ManageTheme.nearlyBlack,
              )),
          const Spacer(),
          Text("-  ${widget.model.task_given_by}",
              style: ManageTheme.insideAppText(
                size: 15,
                weight: FontWeight.w500,
                color: widget.isCurrent
                    ? ManageTheme.nearlyWhite
                    : ManageTheme.nearlyBlack,
              ))
        ],
      ),
    );
  }
}
