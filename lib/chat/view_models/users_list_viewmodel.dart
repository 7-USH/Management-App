// ignore_for_file: non_constant_identifier_names

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:manage_app/chat/models/User.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UsersListViewModel with ChangeNotifier {

  Stream<QuerySnapshot<User>> observeUsers({required String subscriber_id}) {
    return Amplify.DataStore.observeQuery(User.classType,
        where: User.SUBSCRIBER_ID.eq(subscriber_id));
  }

  Future<void> addUser(
      {required String tag,
      required String profile_image_url,
      required String name,
      required bool is_online}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    User userToSave = User(
        profile_img_url: profile_image_url,
        tag: tag,
        name: name,
        is_online: is_online,
        subscriber_id: pref.getString("session"));
    await Amplify.DataStore.save(userToSave);
    notifyListeners();
  }
}
