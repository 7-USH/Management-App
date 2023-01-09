// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:manage_app/chat/models/chat_model.dart';
import 'package:manage_app/utils/manage_theme.dart';

class ChatCard extends StatefulWidget {
  ChatCard({super.key, required this.model});
  ChatModel model;
  @override
  State<ChatCard> createState() => _ChatCardState();
}

class _ChatCardState extends State<ChatCard> {
  @override
  Widget build(BuildContext context) {
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
                      Text(
                        widget.model.name,
                        style: ManageTheme.insideAppText(
                            size: 18, weight: FontWeight.bold),
                      ),
                      Text(
                        widget.model.time,
                        style: ManageTheme.insideAppText(
                            size: 10,
                            color: Colors.grey,
                            weight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Text(
                  widget.model.tag,
                  style: ManageTheme.insideAppText(
                      size: 11, color: Colors.grey, weight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 7,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.63,
                  child: Text(
                    widget.model.last_chat,
                    overflow: TextOverflow.ellipsis,
                    style: ManageTheme.insideAppText(
                        size: 12, weight: FontWeight.w600),
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
