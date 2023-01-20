// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:manage_app/common/api.dart';
import 'package:manage_app/home/models/family_member_model.dart';

import '../../utils/manage_theme.dart';

class HomeService {
  final ApiService _service = ApiService();

  Future<dynamic> createFamilyMember({required BuildContext context,required FamilyMemberModel model}) async {
    String endpoint = "profile/create";
    var response = await _service.postData(endpoint, model.toJson());
    if(response.isLeft){
       return ManageTheme.moveToError(
          context: context, text: response.left.message!);
    } else {
      return response;
    }
  }
}
