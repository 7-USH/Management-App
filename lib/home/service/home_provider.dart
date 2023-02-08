// ignore_for_file: unused_field, prefer_final_fields, use_build_context_synchronously, unused_local_variable

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:manage_app/home/models/staff_leave_application_model.dart';
import 'package:manage_app/home/service/home_service.dart';
import 'package:manage_app/task/models/display_task_model.dart';
import 'package:manage_app/task/service/task_service.dart';

import '../../task/models/display_admin_task_model.dart';

class HomeAdminProvider with ChangeNotifier {
  List<DisplayAdminTaskModel> _adminTasks = [];
  StreamController<List<DisplayAdminTaskModel>> _adminController =
      StreamController.broadcast();
  TaskService service = TaskService();
  Timer? _timer;

  HomeAdminProvider({required BuildContext context}) {
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      getAdminTask(context: context).onError((error, stackTrace) {
        closeAdminStream();
        timer.cancel();
      });
    });
  }

  @override
  void dispose() {
    _timer!.cancel();
    closeAdminStream();
    super.dispose();
  }


  void closeAdminStream() async {
    await _adminController.close();
  }

  Stream<List<DisplayAdminTaskModel>> get streamGetter =>
      _adminController.stream;

  Future<void> getAdminTask({required BuildContext context}) async {
    try {
      List<DisplayAdminTaskModel> models =
          await service.getGroupTasks(context: context);
      models.removeWhere((element) => element.validFrom == null);
      _adminController.sink.add(models);
    } catch (e) {
      throw e.toString();
    }
  }
}

class HomeStaffProvider with ChangeNotifier {
  List<DisplayStaffTaskModel> _staffTasks = [];
  StreamController<List<DisplayStaffTaskModel>> _staffController =
      StreamController();
  TaskService service = TaskService();
  Timer? _timer;

  HomeStaffProvider({required BuildContext context}) {
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      getStaffTask(context: context).onError((error, stackTrace) {
        closeStaffStream();
        timer.cancel();
      });
    });
  }

  @override
  void dispose() {
    _timer!.cancel();
    closeStaffStream();
    super.dispose();
  }

  void closeStaffStream() async {
    await _staffController.close();
  }

  Stream<List<DisplayStaffTaskModel>> get streamGetter =>
      _staffController.stream;

  Future<void> getStaffTask({required BuildContext context}) async {
    try {
      List<DisplayStaffTaskModel> models =
          await service.getGroupTasks(context: context);
      models.removeWhere((element) => element.validFrom == null);
      _staffController.sink.add(models);
    } catch (e) {
      throw e.toString();
    }
  }
}

class StaffLeaveApplicationProvider with ChangeNotifier {
  List<StaffLeaveApplicationModel> _leaves = [];
  StreamController<List<StaffLeaveApplicationModel>> _leavesController =
      StreamController.broadcast();
  HomeService service = HomeService();
  Timer? _timer;

  StaffLeaveApplicationProvider({required BuildContext context}) {
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      getLeaves(context: context).onError((error, stackTrace) {
        closeLeaveStream();
        timer.cancel();
      });
    });
  }

  @override
  void dispose() {
    _timer!.cancel();
    closeLeaveStream();
    super.dispose();
  }

  void closeLeaveStream() async {
    await _leavesController.close();
  }

  Stream<List<StaffLeaveApplicationModel>> get streamGetter =>
      _leavesController.stream;

  Future<void> getLeaves({required BuildContext context}) async {
    try {
      List<StaffLeaveApplicationModel> models =
          await service.getAllLeaveApplications(context: context);
      _leavesController.sink.add(models);
    } catch (e) {
      throw e.toString();
    }
  }
}

class StaffMembersProvider with ChangeNotifier {
  
}