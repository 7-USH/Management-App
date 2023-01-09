import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:manage_app/chat/models/Friends.dart';

class FriendListViewModel with ChangeNotifier {
  Stream<QuerySnapshot<Friends>> observeFriends() {
    return Amplify.DataStore.observeQuery(Friends.classType);
  }
}
