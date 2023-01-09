import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:manage_app/chat/models/Message.dart';

class MessageListViewModel with ChangeNotifier {
  Stream<QuerySnapshot<Message>> observeMessages() {
    return Amplify.DataStore.observeQuery(Message.classType);
  }
}
