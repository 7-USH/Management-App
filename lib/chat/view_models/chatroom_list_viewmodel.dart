// ignore_for_file: non_constant_identifier_names

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:manage_app/chat/models/ModelProvider.dart';

class ChatRoomListViewModel with ChangeNotifier {
  Stream<QuerySnapshot<ChatRoom>> observeChatRooms({required String user_id}) {
    return Amplify.DataStore.observeQuery(ChatRoom.classType,
        where: ChatRoom.USERID.eq(user_id));
  }
}
