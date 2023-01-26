// ignore_for_file: non_constant_identifier_names

import 'package:flutter/foundation.dart';
import 'package:manage_app/chat/models/ModelProvider.dart';
import 'package:amplify_flutter/amplify_flutter.dart';

class MessageListViewModel with ChangeNotifier {
  Stream<QuerySnapshot<Message>> observeMessage(String chatRoomId) {
    return Amplify.DataStore.observeQuery(Message.classType,
        where: Message.CHATROOMID.eq(chatRoomId));
  }

  Future<void> addMessage(
      {required String message,
      required String time_stamp,
      required String chatRoomId,
      required String userId}) async {
    Message messageToSave = Message(
        chatroomID: chatRoomId,
        userID: userId,
        message: message,
        time_stamp: time_stamp);
    await Amplify.DataStore.save(messageToSave);
    notifyListeners();
  }
}
