// ignore_for_file: non_constant_identifier_names, must_be_immutable, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:manage_app/chat/models/chat_model.dart';
import 'package:manage_app/utils/manage_theme.dart';

class ChatScreen extends StatefulWidget {
  ChatScreen({
    super.key,
    required this.model,
  });
  ChatModel model;
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          foregroundColor: ManageTheme.nearlyBlack,
          elevation: 0.0,
          automaticallyImplyLeading: true,
          title: Row(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: ManageTheme.nearlyBlack,
                    radius: 22,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.model.name,
                        style: ManageTheme.insideAppText(
                            size: 17, weight: FontWeight.bold),
                      ),
                      Text(
                        widget.model.tag,
                        style: ManageTheme.insideAppText(
                            size: 10,
                            weight: FontWeight.w500,
                            color: Colors.grey),
                      )
                    ],
                  ),
                ],
              ),
              Spacer(),
              IconButton(onPressed: () {}, icon: Icon(Icons.call_outlined))
            ],
          )),
      backgroundColor: ManageTheme.nearlyWhite,
      body: Column(
        children: [
          Container(
            height: 1.5,
            color: Colors.grey.withOpacity(0.18),
          ),
        ],
      ),
    );
  }
}
