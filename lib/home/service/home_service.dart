// ignore_for_file: use_build_context_synchronously, unused_local_variable, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:manage_app/common/api.dart';
import 'package:manage_app/home/models/family_member_model.dart';
import 'package:manage_app/home/models/family_relationship_model.dart';
import 'package:manage_app/home/models/profile_detail_model.dart';
import 'package:manage_app/home/models/staff_leave_application_model.dart';

import '../../utils/manage_theme.dart';

class HomeService {
  final ApiService _service = ApiService();

  Future<dynamic> createFamilyMember(
      {required BuildContext context, required FamilyMemberModel model}) async {
    String endpoint = "profile/create";
    Map<String, dynamic> sub_id = await _service.getHeaders();
    var response = await _service.postData(endpoint, model.toJson());
    if (response.isLeft) {
      ManageTheme.moveToError(
          context: context,
          text: response.left.message!,
          statusCode: response.left.statusCode);
      return false;
    } else {
      return true;
    }
  }

  Future<FamilyRelationShipModel> getFamilyMembers(
      {required BuildContext context}) async {
    String endpoint = "profile/get-family-tree";
    var response = await _service.getData(endpoint);
    if (response.isLeft) {
      return ManageTheme.moveToError(
          context: context,
          text: response.left.message!,
          statusCode: response.left.statusCode);
    } else {
      return FamilyRelationShipModel.fromJson(response.right);
    }
  }

  Future<ProfileDetailModel> getMyDetails(
      {required BuildContext context}) async {
    String endpoint = "user/get-user-details";
    var response = await _service.getData(endpoint);
    if (response.isLeft) {
      return ManageTheme.moveToError(
          context: context,
          text: response.left.message!,
          statusCode: response.left.statusCode);
    } else {
      return ProfileDetailModel.fromJson(response.right);
    }
  }

  Future<List<StaffLeaveApplicationModel>> getAllLeaveApplications(
      {required BuildContext context}) async {
    String endpoint = "staff-leave/get-all-leave-applications";
    var response = await _service.getAllData(endpoint);
    if (response.isLeft) {
      return ManageTheme.moveToError(
          context: context,
          text: response.left.message!,
          statusCode: response.left.statusCode);
    } else {
      return response.right
          .map<StaffLeaveApplicationModel>(
              (e) => StaffLeaveApplicationModel.fromJson(e))
          .toList();
    }
  }

  Future<dynamic> approveApplication(
      {required BuildContext context, required String leave_id}) async {
    String endpoint = "staff-leave/approve-application";
    var response =
        await _service.updateData(endpoint, {"staff_leave_id": leave_id});
    if (response.isLeft) {
      return ManageTheme.moveToError(
          context: context,
          text: response.left.message!,
          statusCode: response.left.statusCode);
    } else {
      return response.right;
    }
  }

  Future<dynamic> rejectApplication(
      {required BuildContext context, required String leave_id}) async {
    String endpoint = "staff-leave/reject-application";
    var response =
        await _service.updateData(endpoint, {"staff_leave_id": leave_id});
    if (response.isLeft) {
      return ManageTheme.moveToError(
          context: context,
          text: response.left.message!,
          statusCode: response.left.statusCode);
    } else {
      return response.right;
    }
  }


  Future<dynamic> uploadProfileImage(
      {required BuildContext context,
      required Map<String, dynamic> requestBody}) async {
    String endpoint = "user/upload-profile-image";
    var response = await _service.postData(endpoint, requestBody);
    if (response.isLeft) {
      return ManageTheme.moveToError(
          context: context,
          text: response.left.message!,
          statusCode: response.left.statusCode);
    } else {
      return response.right;
    }
  }

  Future<dynamic> updateStatusTask(
      {required BuildContext context,
      required Map<String, dynamic> requestBody}) async {
    String endpoint = "staff-task/update-task-by-staff";
    var response = await _service.updateData(endpoint, requestBody);
    if (response.isLeft) {
      return ManageTheme.moveToError(
          context: context,
          text: response.left.message!,
          statusCode: response.left.statusCode);
    } else {
      return response.right;
    }
  }
}
