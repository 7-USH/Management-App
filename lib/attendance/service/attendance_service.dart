// ignore_for_file: use_build_context_synchronously, body_might_complete_normally_nullable

import 'package:flutter/cupertino.dart';
import 'package:manage_app/attendance/models/attendance_time_model.dart';
import 'package:manage_app/attendance/models/check_status_model.dart';
import 'package:manage_app/attendance/models/create_leave_model.dart';
import 'package:manage_app/attendance/models/leave_history_model.dart';
import 'package:manage_app/common/api.dart';

import '../../utils/manage_theme.dart';

class AttendanceService {
  final ApiService _service = ApiService();

  Future<CheckStatusModel> checkIn({required BuildContext context}) async {
    String endpoint = "staff-attendance/check-in";
    var response = await _service.postData(endpoint, {});
    if (response.isLeft) {
      return ManageTheme.moveToError(
          context: context,
          text: response.left.message!,
          statusCode: response.left.statusCode);
    } else {
      return CheckStatusModel.fromJson(response.right);
    }
  }

  Future<CheckStatusModel> checkOut({required BuildContext context}) async {
    String endpoint = "staff-attendance/check-out";
    var response = await _service.postData(endpoint, {});
    if (response.isLeft) {
      return ManageTheme.moveToError(
          context: context,
          text: response.left.message!,
          statusCode: response.left.statusCode);
    } else {
      return CheckStatusModel.fromJson(response.right);
    }
  }

  Future<AttendanceTimeModel> getAttendaceStatus(
      {required BuildContext context}) async {
    String endpoint = "staff-attendance/get-attendance-status";
    var response = await _service.getData(endpoint);
    if (response.isLeft) {
      return ManageTheme.moveToError(
          context: context,
          text: response.left.message!,
          statusCode: response.left.statusCode);
    } else {
      return AttendanceTimeModel.fromJson(response.right);
    }
  }

  Future<CreateLeaveModel> createLeave(
      {required BuildContext context, required CreateLeaveModel model}) async {
    String endpoint = "staff-leave/create-leave-application";
    var response = await _service.postData(endpoint, model.toJson());
    if (response.isLeft) {
      return ManageTheme.moveToError(
          context: context,
          text: response.left.message!,
          statusCode: response.left.statusCode);
    } else {
      return CreateLeaveModel.fromJson(response.right);
    }
  }

  Future<dynamic> getLeaveStatus({required BuildContext context}) async {
    String endpoint = "staff-leave/get-leave-application-status";
    var response = await _service.getData(endpoint);
    if (response.isLeft) {
      return ManageTheme.moveToError(
          context: context,
          text: response.left.message!,
          statusCode: response.left.statusCode);
    } else {
      return response.right;
    }
  }

  Future<List<LeaveHistoryModel>> getAllLeaveApplications(
      {required BuildContext context}) async {
    String endpoint = "staff-leave/get-leave-applications-by-staff";
    var response = await _service.getAllData(endpoint);
    if (response.isLeft) {
      return ManageTheme.moveToError(
          context: context,
          text: response.left.message!,
          statusCode: response.left.statusCode);
    } else {
      return response.right
          .map<LeaveHistoryModel>(
              (e) => LeaveHistoryModel.fromJson(e as Map<String, dynamic>))
          .toList();
    }
  }

}
