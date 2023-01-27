// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:manage_app/common/api.dart';
import 'package:manage_app/task/models/display_task_model.dart';
import 'package:manage_app/task/models/task_model.dart';
import 'package:manage_app/utils/manage_theme.dart';

class TaskService {
  final ApiService _service = ApiService();

  Future<dynamic> createTask(
      {required BuildContext context, required StaffTaskModel model}) async {
    String endpoint = "staff/create-task";
    var response = await _service.postData(endpoint, model.toJson());
    if (response.isLeft) {
      return ManageTheme.moveToError(
          context: context, text: response.left.message!);
    } else {
      return response.right;
    }
  }

  Future<List<DisplayStaffTaskModel>> getAllTasks(
      {required BuildContext context}) async {
    String endpoint = "staff/get-tasks";
    var response = await _service.getAllData(endpoint);
    if (response.isLeft) {
      return ManageTheme.moveToError(
          context: context, text: response.left.message!);
    } else {
      return response.right
          .map<DisplayStaffTaskModel>(
              (e) => DisplayStaffTaskModel.fromJson(e as Map<String, dynamic>))
          .toList();
    }
  }
}

class TaskStream {
  List<DisplayStaffTaskModel> models = [];
  final ApiService _service = ApiService();

  final StreamController<List<DisplayStaffTaskModel>> _taskController =
      StreamController();

  TaskStream({required BuildContext context}) {
    getAllTasks(context: context);
  }

  Stream<List<DisplayStaffTaskModel>> get taskStream => _taskController.stream;
  StreamSink<List<DisplayStaffTaskModel>> get counterSink =>
      _taskController.sink;

  Future<void> getAllTasks({required BuildContext context}) async {
    String endpoint = "staff/get-tasks";
    var response = await _service.getAllData(endpoint);
    if (response.isLeft) {
      counterSink.add(models);
    } else {
      models = response.right
          .map<DisplayStaffTaskModel>(
              (e) => DisplayStaffTaskModel.fromJson(e as Map<String, dynamic>))
          .toList();
      counterSink.add(models);
    }
  }

  Future<void> closeStream() => _taskController.close();
}
