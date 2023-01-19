// ignore_for_file: use_build_context_synchronously, prefer_final_fields, unused_import
import 'package:flutter/material.dart';
import 'package:manage_app/common/api.dart';
import 'package:manage_app/signup/models/activate_model.dart';
import 'package:manage_app/signup/models/plan_model.dart';
import 'package:manage_app/signup/models/register_model.dart';
import 'package:manage_app/utils/manage_theme.dart';

import '../../login/models/session_model.dart';

class SignUpService {
  ApiService _service = ApiService();

  Future<dynamic> registerUser(
      {required RegisterModel model, required BuildContext context}) async {
    String endpoint = "user/register";
    var response = await _service.postData(endpoint, model.toJson());
    if (response.isLeft) {
      return ManageTheme.moveToError(
          context: context, text: response.left.message!);
    } else {
      return RegisterModel.fromJson(response.right);
    }
  }

  Future<dynamic> activateCode(
      {required ActivateModel model, required BuildContext context}) async {
    String endpoint = "login/activate-user";
    var response = await _service.postData(endpoint, model.toJson());
    if (response.isLeft) {
      return ManageTheme.moveToError(
          context: context, text: response.left.message!);
    } else {
      return SessionModel.fromJson(response.right);
    }
  }

  Future<List<PlanModel>> getSubPlans({required BuildContext context}) async {
    String endpoint = "subscriptions/get-plans";
    var response = await _service.getAllData(endpoint);
    if (response.isLeft) {
      ManageTheme.moveToError(context: context, text: response.left.message!);
      return [];
    } else {
      return response.right
          .map<PlanModel>((e) => PlanModel.fromJson(e as Map<String, dynamic>))
          .toList();
    }
  }

  Future<dynamic> createPlan(
      {required BuildContext context, required PlanModel model}) async {
    String endpoint = "subscriber/create";
    var response = await _service.postData(endpoint, model.toJson());
    if (response.isLeft) {
      ManageTheme.moveToError(context: context, text: response.left.message!);
      return [];
    } else {
      return AdminPlan.fromJson(response.right);
    }
  }

  Future<dynamic> getMyPlan({required BuildContext context}) async {
    String endpoint = "subscriber/get";
    var response = await _service.getData(endpoint);
    if (response.isLeft) {
      ManageTheme.moveToError(context: context, text: response.left.message!);
    } else {
      return response.right;
    }
  }
}
