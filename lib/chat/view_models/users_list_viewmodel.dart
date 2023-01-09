// ignore_for_file: non_constant_identifier_names

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:manage_app/chat/models/User.dart';

class UsersListViewModel with ChangeNotifier {
  Stream<QuerySnapshot<User>> observeUsers({required String subscriber_id}) {
    return Amplify.DataStore.observeQuery(User.classType,
        where: User.SUBSCRIBER_ID.eq(subscriber_id));
  }
}
