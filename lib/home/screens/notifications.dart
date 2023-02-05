// ignore_for_file: must_be_immutable, prefer_const_constructors, unused_import

import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:manage_app/home/models/notification_model.dart';
import 'package:manage_app/home/models/staff_leave_application_model.dart';
import 'package:manage_app/home/service/home_service.dart';
import 'package:manage_app/home/ui_view/leave_request_card.dart';
import 'package:manage_app/utils/manage_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationsScreen extends StatefulWidget {
  NotificationsScreen({super.key, required this.models});
  List<StaffLeaveApplicationModel> models;

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ManageTheme.nearlyWhite,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: ManageTheme.nearlyBlack,
        elevation: 0.0,
        title: Text(
          "Notifications",
          style: ManageTheme.insideAppText(size: 25, weight: FontWeight.bold),
        ),
      ),
      body: widget.models.isEmpty
          ? Center(
              child: Text(
                "No Notifications received yet!",
                style: ManageTheme.appText(size: 17, weight: FontWeight.w500),
              ),
            )
          : AnimationLimiter(
              child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return AnimationConfiguration.staggeredList(
                        position: index,
                        duration: const Duration(milliseconds: 500),
                        child: SlideAnimation(
                            horizontalOffset: 80.0,
                            child: FadeInAnimation(
                                child: LeaveRequestCard(
                              model: widget.models[index],
                            ))));
                  },
                  separatorBuilder: (context, index) {
                    return Container(
                      height: 1.5,
                      color: Colors.grey.withOpacity(0.18),
                    );
                  },
                  itemCount: widget.models.length),
            ),
    );
  }
}
