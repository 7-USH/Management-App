// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:manage_app/common/api.dart';
import 'package:manage_app/task/models/display_admin_task_model.dart';
import 'package:manage_app/task/models/display_task_model.dart';
import 'package:manage_app/task/models/task_model.dart';
import 'package:manage_app/utils/manage_theme.dart';

class TaskService {
  final ApiService _service = ApiService();

  Future<dynamic> createTask(
      {required BuildContext context, required StaffTaskModel model}) async {
    String endpoint = "staff-task/create-task";
    var response = await _service.postData(endpoint, model.toJson());
    if (response.isLeft) {
      return ManageTheme.moveToError(
          context: context,
          text: response.left.message!,
          statusCode: response.left.statusCode);
    } else {
      return response.right;
    }
  }

  Future<List<DisplayStaffTaskModel>> getStaffTasks(
      {required BuildContext context}) async {
    String endpoint = "staff-task/get-tasks-by-staff";
    var response = await _service.getAllData(endpoint);
    if (response.isLeft) {
      return ManageTheme.moveToError(
          context: context,
          text: response.left.message!,
          statusCode: response.left.statusCode);
    } else {
      return response.right
          .map<DisplayStaffTaskModel>(
              (e) => DisplayStaffTaskModel.fromJson(e as Map<String, dynamic>))
          .toList();
    }
  }

  Future<List<DisplayAdminTaskModel>> getGroupTasks(
      {required BuildContext context}) async {
    String endpoint = "staff-task/get-tasks-by-group";
    var response = await _service.getAllData(endpoint);
    if (response.isLeft) {
      return ManageTheme.moveToError(
          context: context,
          text: response.left.message!,
          statusCode: response.left.statusCode);
    } else {
      return response.right
          .map<DisplayAdminTaskModel>(
              (e) => DisplayAdminTaskModel.fromJson(e as Map<String, dynamic>))
          .toList();
    }
  }

}
