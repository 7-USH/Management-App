class StaffLeaveApplicationModel {
  LeaveApplication? leaveApplication;
  StaffDetails? staffDetails;

  StaffLeaveApplicationModel({this.leaveApplication, this.staffDetails});

  StaffLeaveApplicationModel.fromJson(Map<String, dynamic> json) {
    leaveApplication = json['leave_application'] != null
        ? LeaveApplication.fromJson(json['leave_application'])
        : null;
    staffDetails = json['staff_details'] != null
        ? StaffDetails.fromJson(json['staff_details'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (leaveApplication != null) {
      data['leave_application'] = leaveApplication!.toJson();
    }
    if (staffDetails != null) {
      data['staff_details'] = staffDetails!.toJson();
    }
    return data;
  }
}

class LeaveApplication {
  String? id;
  String? leaveSubject;
  String? startingDate;
  String? status;
  String? reason;
  String? staffId;
  String? endingDate;

  LeaveApplication(
      {this.id,
      this.leaveSubject,
      this.startingDate,
      this.status,
      this.reason,
      this.staffId,
      this.endingDate});

  LeaveApplication.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    leaveSubject = json['leave_subject'];
    startingDate = json['starting_date'];
    status = json['status'];
    reason = json['reason'];
    staffId = json['staff_id'];
    endingDate = json['ending_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['leave_subject'] = leaveSubject;
    data['starting_date'] = startingDate;
    data['status'] = status;
    data['reason'] = reason;
    data['staff_id'] = staffId;
    data['ending_date'] = endingDate;
    return data;
  }
}

class StaffDetails {
  String? email;
  String? mobileNo;
  bool? isActive;
  String? activationCode;
  String? profile;
  String? bankAccountNo;
  String? fullName;
  String? address;
  String? profileImageUrl;
  String? registrationDate;
  String? bankIfsc;
  String? subscriberGroupId;

  StaffDetails(
      {this.email,
      this.mobileNo,
      this.isActive,
      this.activationCode,
      this.profile,
      this.bankAccountNo,
      this.fullName,
      this.address,
      this.profileImageUrl,
      this.registrationDate,
      this.bankIfsc,
      this.subscriberGroupId});

  StaffDetails.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    mobileNo = json['mobile_no'];
    isActive = json['is_active'];
    activationCode = json['activation_code'];
    profile = json['profile'];
    bankAccountNo = json['bank_account_no'];
    fullName = json['full_name'];
    address = json['address'];
    profileImageUrl = json['profile_image_url'];
    registrationDate = json['registration_date'];
    bankIfsc = json['bank_ifsc'];
    subscriberGroupId = json['subscriber_group_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['mobile_no'] = mobileNo;
    data['is_active'] = isActive;
    data['activation_code'] = activationCode;
    data['profile'] = profile;
    data['bank_account_no'] = bankAccountNo;
    data['full_name'] = fullName;
    data['address'] = address;
    data['profile_image_url'] = profileImageUrl;
    data['registration_date'] = registrationDate;
    data['bank_ifsc'] = bankIfsc;
    data['subscriber_group_id'] = subscriberGroupId;
    return data;
  }
}
