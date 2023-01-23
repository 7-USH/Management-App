// ignore_for_file: non_constant_identifier_names

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:manage_app/chat/models/User.dart';

class UsersListViewModel with ChangeNotifier {
  Stream<QuerySnapshot<User>> observeUsers({required String subscriber_id}) {
    return Amplify.DataStore.observeQuery(User.classType,
        where: User.SUBSCRIBER_ID.eq(subscriber_id));
  }

  Future<void> addUser(
      {required String tag,
      required String profile_image_url,
      required String name,
      required String sub_id,
      required bool is_online}) async {
    User userToSave = User(
        profile_img_url: profile_image_url,
        tag: tag,
        name: name,
        is_online: is_online,
        subscriber_id: sub_id);
    await Amplify.DataStore.save(userToSave);
    notifyListeners();
  }
}
