import 'package:manage_app/task/models/display_task_model.dart';

class StaffDetails {
  String? address;
  String? fullName;
  String? hashedPassword;
  String? profileImageUrl;
  String? registrationDate;
  String? bankIfsc;
  String? subscriberGroupId;
  String? email;
  String? mobileNo;
  bool? isActive;
  String? activationCode;
  String? profile;
  String? bankAccountNo;

  StaffDetails(
      {this.address,
      this.fullName,
      this.hashedPassword,
      this.profileImageUrl,
      this.registrationDate,
      this.bankIfsc,
      this.subscriberGroupId,
      this.email,
      this.mobileNo,
      this.isActive,
      this.activationCode,
      this.profile,
      this.bankAccountNo});

  StaffDetails.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    fullName = json['full_name'];
    hashedPassword = json['hashed_password'];
    profileImageUrl = json['profile_image_url'];
    registrationDate = json['registration_date'];
    bankIfsc = json['bank_ifsc'];
    subscriberGroupId = json['subscriber_group_id'];
    email = json['email'];
    mobileNo = json['mobile_no'];
    isActive = json['is_active'];
    activationCode = json['activation_code'].toString();
    profile = json['profile'];
    bankAccountNo = json['bank_account_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['address'] = address;
    data['full_name'] = fullName;
    data['hashed_password'] = hashedPassword;
    data['profile_image_url'] = profileImageUrl;
    data['registration_date'] = registrationDate;
    data['bank_ifsc'] = bankIfsc;
    data['subscriber_group_id'] = subscriberGroupId;
    data['email'] = email;
    data['mobile_no'] = mobileNo;
    data['is_active'] = isActive;
    data['activation_code'] = activationCode;
    data['profile'] = profile;
    data['bank_account_no'] = bankAccountNo;
    return data;
  }
}

class DisplayAdminTaskModel extends DisplayStaffTaskModel {
  List<StaffDetails>? staffDetails;

  DisplayAdminTaskModel.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    if (json['staff_details'] != null) {
      staffDetails = <StaffDetails>[];
      json['staff_details'].forEach((v) {
        staffDetails!.add(StaffDetails.fromJson(v));
      });
    }
  }
}
