// ignore_for_file: non_constant_identifier_names, prefer_interpolation_to_compose_strings, unused_local_variable

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:manage_app/chat/models/ModelProvider.dart';
import 'package:manage_app/chat/view_models/users_list_viewmodel.dart';

class ChatRoomListViewModel with ChangeNotifier {
  Stream<QuerySnapshot<ChatRoom>> observeChatRooms(
      {required String chatRoomID}) {
    return Amplify.DataStore.observeQuery(ChatRoom.classType,
        where: ChatRoom.ID.eq(chatRoomID));
  }

  Future<void> createNewChatRoom({
    required String chatRoomID,
    required String clicked_user_id,
  }) async {
    UsersListViewModel model = UsersListViewModel();
    List<User>? users = await model.getCurrentUser();
    ChatRoom chatRoomToSave = ChatRoom(id: chatRoomID + "Tushar");
    await Amplify.DataStore.save(chatRoomToSave).then((value) async {
      UserChatRoom clickedUserChatRoomToSave = UserChatRoom(
          chatRoom: ChatRoom(id: chatRoomID + "Tushar"),
          user: User(id: clicked_user_id));
      await Amplify.DataStore.save(clickedUserChatRoomToSave);
      UserChatRoom myUserChatRoomToSave = UserChatRoom(
          chatRoom: ChatRoom(id: chatRoomID + "Tushar"),
          user: User(id: users![0].id));
      await Amplify.DataStore.save(myUserChatRoomToSave);
    });
    notifyListeners();
  }

  Future<List<ChatRoom>> fetchChatRooms() async {
    try {
      List<ChatRoom> chatRooms =
          await Amplify.DataStore.query(ChatRoom.classType);
      return chatRooms;
    } catch (e) {
      print("Could not query DataStore: " + e.toString());
      return [];
    }
  }
}
