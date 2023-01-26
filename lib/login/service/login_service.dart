// ignore_for_file: unused_field, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:manage_app/common/api.dart';
import 'package:manage_app/login/models/login_model.dart';
import 'package:manage_app/login/models/reset_pass_model.dart';
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

  Future<bool> sendForgotOTP(
      {required Map<String, dynamic> requestBody,
      required BuildContext context}) async {
    String endpoint = "login/send-forgot-password-otp";
    var response = await _service.postData(endpoint, requestBody);
    if (response.isLeft) {
      return ManageTheme.moveToError(
          context: context, text: response.left.message!);
    } else {
      return true;
    }
  }

  Future<dynamic> validateOTP(
      {required BuildContext context, required ResetPassModel model}) async {
    String endpoint = "login/validate-reset-password-otp";
    var response = await _service.postData(endpoint, model.toJson());
    if (response.isLeft) {
      if (response.left.message == "Invalid / Expired Code") {
        final snackBar = SnackBar(
            backgroundColor: ManageTheme.nearlyBlack,
            content: Text(
               "Invalid OTP, please try again!",
              style: ManageTheme.appText(
                  size: 12,
                  weight: FontWeight.w600,
                  color: ManageTheme.backgroundWhite),
            ));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else {
        return ManageTheme.moveToError(
            context: context, text: response.left.message!);
      }
    } else {
      SessionModel token = SessionModel.fromJson(response.right);
      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setString('session', token.session!);
      return token;
    }
  }

  Future<dynamic> resetPassword(
      {required ResetPassModel model, required BuildContext context}) async {
    String endpoint = "login/reset-password";
    var response = await _service.postData(endpoint, model.toJson());
    if (response.isLeft) {
      return ManageTheme.moveToError(
          context: context, text: response.left.message!);
    } else {
      return response;
    }
  }
}
