// ignore_for_file: unused_field, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:manage_app/common/api.dart';
import 'package:manage_app/login/models/login_model.dart';
import 'package:manage_app/login/models/session_model.dart';
import 'package:manage_app/utils/manage_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginService {
  final ApiService _service = ApiService();

  Future<dynamic> loginUser(
      {required LoginModel model, required BuildContext context}) async {
    String endpoint = "login/auth";
    var response = await _service.postData(endpoint, model.toJson());
    if (response.isLeft) {
      return ManageTheme.moveToError(
          context: context, text: response.left.message!);
    } else {
      SessionModel token = SessionModel.fromJson(response.right);
      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setString('session', token.session!);
      return token;
    }
  }
}
