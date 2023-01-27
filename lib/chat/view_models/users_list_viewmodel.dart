// ignore_for_file: non_constant_identifier_names, body_might_complete_normally_nullable

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:manage_app/chat/models/User.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UsersListViewModel with ChangeNotifier {
  Stream<QuerySnapshot<User>> observeUsers({required String subscriber_id}) {
    return Amplify.DataStore.observeQuery(User.classType,
        where: User.SUBSCRIBER_ID.eq(subscriber_id).and(User.TAG.ne("admin")));
  }

  Future<List<User>?> getCurrentUser() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    try {
      final List<User> user = await Amplify.DataStore.query(User.classType,
          where: User.SUBSCRIBER_ID
              .eq(pref.getString("session"))
              .and(User.TAG.eq("admin")));
      return user;
    } catch (e) {
      if (kDebugMode) {
        print("There was an error");
      }
    }
  }

  Future<void> addUser(
      {required String tag,
      String? id,
      required int index,
      required String profile_image_url,
      required String name,
      required String email,
      required bool is_online}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    User userToSave = User(
        profile_img_url: profile_image_url,
        tag: tag,
        name: name,
        index: index,
        email_id: email,
        is_online: is_online,
        subscriber_id: id ?? pref.getString("session"));
    await Amplify.DataStore.save(userToSave);
    notifyListeners();
  }
}
