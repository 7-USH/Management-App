// ignore_for_file: non_constant_identifier_names, must_be_immutable, prefer_const_constructors, unused_field, prefer_final_fields, unused_element, avoid_unnecessary_containers, depend_on_referenced_packages, unused_import, unnecessary_import

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:manage_app/chat/chat.dart';
import 'package:manage_app/chat/models/chat_model.dart';
import 'package:manage_app/utils/manage_theme.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart' as message;

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
  List<types.Message> _messages = [];
  final _user = const types.User(id: '82091008-a484-4a89-ae75-a22bf8d6f3ac');

  void _addMessage(types.Message message) {
    setState(() {
      _messages.insert(0, message);
    });
  }

  void _handleSendPressed(types.PartialText message) {
    final textMessage = types.TextMessage(
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: "id",
      text: message.text,
    );

    _addMessage(textMessage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          backgroundColor: ManageTheme.backgroundWhite,
          foregroundColor: ManageTheme.nearlyBlack,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
              side: BorderSide(color: Colors.black12)),
          elevation: 0.0,
          automaticallyImplyLeading: true,
          bottom: PreferredSize(
              preferredSize: Size.fromHeight(15),
              child: Container(
                decoration: BoxDecoration(
                    color: ManageTheme.backgroundWhite,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30))),
              )),
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
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2,
                        child: Text(
                          widget.model.name,
                          overflow: TextOverflow.ellipsis,
                          style: ManageTheme.insideAppText(
                              size: 17, weight: FontWeight.bold),
                        ),
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
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.call_outlined,
                    color: Colors.grey.withOpacity(0.7),
                  ))
            ],
          )),
      backgroundColor: ManageTheme.nearlyWhite,
      body: SafeArea(
        bottom: false,
        child: message.Chat(
          messages: _messages,
          useTopSafeAreaInset: true,
          l10n: const ChatL10nEn(
            inputPlaceholder: 'Type here...',
          ),
          isAttachmentUploading: true,
          theme: DefaultChatTheme(
              inputBackgroundColor: ManageTheme.backgroundWhite,
              inputTextColor: ManageTheme.nearlyBlack,
              inputContainerDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.grey.withOpacity(0.6))),
              inputTextCursorColor: ManageTheme.nearlyBlack,
              inputMargin: EdgeInsets.all(10),
              backgroundColor: ManageTheme.nearlyGrey.withOpacity(0.4)),
          user: _user,
          onSendPressed: _handleSendPressed,
        ),
      ),
    );
  }
}
