// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:manage_app/chat/models/ModelProvider.dart';
import 'package:manage_app/utils/manage_theme.dart';

class ChatCard extends StatefulWidget {
  ChatCard({super.key, required this.model});
  User model;
  @override
  State<ChatCard> createState() => _ChatCardState();
}

class _ChatCardState extends State<ChatCard> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: ManageTheme.nearlyGrey),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: ManageTheme.nearlyBlack)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.63,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Text(
                          widget.model.name!,
                          overflow: TextOverflow.ellipsis,
                          style: ManageTheme.insideAppText(
                              size: screenWidth / 25, weight: FontWeight.bold),
                        ),
                      ),
                      Text(
                        "9:34",
                        style: ManageTheme.insideAppText(
                            size: screenWidth / 40,
                            color: Colors.grey,
                            weight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Text(
                  widget.model.tag!,
                  style: ManageTheme.insideAppText(
                      size: screenWidth / 40,
                      color: Colors.grey,
                      weight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 7,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.63,
                  child: Text(
                    "Hii There",
                    overflow: TextOverflow.ellipsis,
                    style: ManageTheme.insideAppText(
                        size: screenWidth / 39, weight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
