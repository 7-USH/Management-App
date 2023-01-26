// ignore_for_file: use_build_context_synchronously, body_might_complete_normally_nullable

import 'package:flutter/cupertino.dart';
import 'package:manage_app/attendance/models/attendance_time_model.dart';
import 'package:manage_app/attendance/models/check_status_model.dart';
import 'package:manage_app/common/api.dart';

import '../../utils/manage_theme.dart';

class AttendanceService {
  final ApiService _service = ApiService();

  Future<CheckStatusModel> checkIn({required BuildContext context}) async {
    String endpoint = "staff/check-in";
    var response = await _service.postData(endpoint, {});
    if (response.isLeft) {
      return ManageTheme.moveToError(
          context: context, text: response.left.message!);
    } else {
      return CheckStatusModel.fromJson(response.right);
    }
  }

  Future<CheckStatusModel> checkOut({required BuildContext context}) async {
    String endpoint = "staff/check-out";
    var response = await _service.postData(endpoint, {});
    if (response.isLeft) {
      return ManageTheme.moveToError(
          context: context, text: response.left.message!);
    } else {
      return CheckStatusModel.fromJson(response.right);
    }
  }

  Future<AttendanceTimeModel> getAttendaceStatus(
      {required BuildContext context}) async {
    String endpoint = "staff/get-attendance-status";
    var response = await _service.getData(endpoint);
    if (response.isLeft) {
      return ManageTheme.moveToError(
          context: context, text: response.left.message!);
    } else {
      return AttendanceTimeModel.fromJson(response.right);
    }
  }
}
