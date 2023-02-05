// ignore_for_file: must_be_immutable, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:manage_app/home/models/notification_model.dart';
import 'package:manage_app/utils/manage_theme.dart';

class NotificationCard extends StatefulWidget {
  NotificationCard({super.key, required this.model});
  NotificationModel model;

  @override
  State<NotificationCard> createState() => _NotificationCardState();
}

class _NotificationCardState extends State<NotificationCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CircleAvatar(
                backgroundColor: ManageTheme.nearlyBlack,
                radius: 25,
              ),
              const SizedBox(
                width: 10,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                child: Text(
                  widget.model.notify_message,
                  style: ManageTheme.appText(
                      size: 14, weight: FontWeight.w500),
                ),
              )
            ],
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              widget.model.date,
              style: ManageTheme.insideAppText(
                  size: 10, weight: FontWeight.w500, color: Colors.grey),
            ),
          )
        ],
      ),
    );
  }
}
