// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:manage_app/home/models/notification_model.dart';
import 'package:manage_app/home/ui_view/notification_card.dart';
import 'package:manage_app/utils/manage_theme.dart';

class NotificationsScreen extends StatefulWidget {
  NotificationsScreen({super.key, required this.models});
  List<NotificationModel> models;

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
                "No Notifications received Yet!",
                style: ManageTheme.insideAppText(
                    size: 20, weight: FontWeight.w500),
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
                                child: NotificationCard(
                                    model: widget.models[index]))));
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
