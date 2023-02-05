// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, must_be_immutable, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:image_stack/image_stack.dart';
import 'package:intl/intl.dart';
import 'package:manage_app/task/models/display_admin_task_model.dart';
import 'package:manage_app/task/screens/task_update.dart';
import 'package:manage_app/utils/manage_theme.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class HistoryTaskCard extends StatefulWidget {
  HistoryTaskCard({super.key, required this.model});
  DisplayAdminTaskModel model;

  @override
  State<HistoryTaskCard> createState() => _HistoryTaskCardState();
}

class _HistoryTaskCardState extends State<HistoryTaskCard> {
  List<String> images = [
    "https://img.freepik.com/free-photo/pleasant-looking-serious-man-stands-profile-has-confident-expression-wears-casual-white-t-shirt_273609-16959.jpg?w=2000",
    "https://media.istockphoto.com/id/1338134336/photo/headshot-portrait-african-30s-man-smile-look-at-camera.jpg?b=1&s=170667a&w=0&k=20&c=j-oMdWCMLx5rIx-_W33o3q3aW9CiAWEvv9XrJQ3fTMU=",
    "https://newprofilepic2.photo-cdn.net//assets/images/article/profile.jpg",
    "https://media.istockphoto.com/id/1351147752/photo/studio-portrait-of-attractive-20-year-old-bearded-man.jpg?b=1&s=170667a&w=0&k=20&c=N-Uwgbn8qhGypoXFB6keEEC3mW0qhNynAqBqd8oNJw0="
  ];

  String date = "15 Monday, 2021";
  String time_range = "6:00 PM-9:00 PM";
  DateFormat formatter = DateFormat("yyyy-MM-dd HH:mm");

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    String demo_date =
        widget.model.validFrom!.replaceAll("T", ' ').replaceAll("Z", "");
    var dateTime = formatter.parse(demo_date).toLocal();
    date =
        "${DateFormat.d().format(dateTime)} ${DateFormat.MMM().format(dateTime)}, ${DateFormat.y().format(dateTime)}";
    time_range =
        "${DateFormat("h:mm a").format(dateTime)}-${DateFormat("h:mm a").format(dateTime)}";

    Color chipColor = ManageTheme.successGreen;
    if (widget.model.priority == "High") {
      chipColor = Colors.redAccent.shade200;
    } else if (widget.model.priority == "Medium") {
      chipColor = Colors.amber;
    }

    return Container(
      decoration: BoxDecoration(
        color: ManageTheme.backgroundWhite,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: ManageTheme.nearlyGrey),
      ),
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.topLeft,
                child: Chip(
                    padding: EdgeInsets.zero,
                    backgroundColor: ManageTheme.successGreen.withOpacity(0.7),
                    label: Text(
                      widget.model.status!.toUpperCase(),
                      style: ManageTheme.insideAppText(
                          size: screenWidth / 34, weight: FontWeight.bold),
                    )),
              ),
              IconButton(
                  onPressed: () {
                    PersistentNavBarNavigator.pushNewScreen(
                      context,
                      screen: TaskUpdateScreen(
                        model: widget.model,
                        id: widget.model.id!,
                      ),
                      withNavBar: false,
                      pageTransitionAnimation: PageTransitionAnimation.scale,
                    );
                  },
                  icon: Icon(
                    Icons.edit,
                    size: 20,
                    color: Colors.grey,
                  ))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: screenWidth / 1.5,
                child: Text(
                  widget.model.taskTitle!,
                  overflow: TextOverflow.ellipsis,
                  style: ManageTheme.insideAppText(
                      size: screenWidth / 19, weight: FontWeight.bold),
                ),
              ),
              Chip(
                  padding: EdgeInsets.zero,
                  backgroundColor: chipColor,
                  label: Text(
                    widget.model.priority!.toUpperCase(),
                    style: ManageTheme.insideAppText(
                        size: screenWidth / 40,
                        weight: FontWeight.bold,
                        color: ManageTheme.backgroundWhite),
                  ))
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          margin: EdgeInsets.only(bottom: 7),
                          child: Text(
                            "Date",
                            style: ManageTheme.insideAppText(
                                size: screenWidth / 30,
                                weight: FontWeight.w500,
                                color: Colors.grey.shade500),
                          )),
                      Text(
                        date,
                        style: ManageTheme.insideAppText(
                          size: screenWidth / 29,
                          weight: FontWeight.w600,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                height: screenHeight / 15,
                width: 1.5,
                color: Colors.grey.shade300,
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.centerRight,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          margin: EdgeInsets.only(bottom: 7),
                          child: Text(
                            "Time",
                            style: ManageTheme.insideAppText(
                                size: screenWidth / 30,
                                weight: FontWeight.w500,
                                color: Colors.grey.shade500),
                          )),
                      Text(
                        time_range,
                        style: ManageTheme.insideAppText(
                          size: screenWidth / 29,
                          weight: FontWeight.w600,
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: ImageStack(
              imageBorderColor: Colors.transparent,
              extraCountBorderColor: Colors.grey.shade500,
              imageList: images,
              totalCount: images
                  .length, // If larger than images.length, will show extra empty circle
              imageRadius: screenWidth / 12, // Radius of each images
              imageCount: 3, // Maximum number of images to be shown in stack
              imageBorderWidth: 1.5, // Border width around the images
            ),
          ),
        ],
      ),
    );
  }
}
