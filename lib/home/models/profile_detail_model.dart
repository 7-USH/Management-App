class ProfileDetailModel {
  String? email;
  String? mobileNo;
  String? profileImageUrl;
  String? activationCode;
  String? profile;
  String? bankAccountNo;
  String? fullName;
  String? address;
  bool? isActive;
  String? registrationDate;
  String? bankIfsc;
  String? subscriberGroupId;

  ProfileDetailModel(
      {this.email,
      this.mobileNo,
      this.profileImageUrl,
      this.activationCode,
      this.profile,
      this.bankAccountNo,
      this.fullName,
      this.address,
      this.isActive,
      this.registrationDate,
      this.bankIfsc,
      this.subscriberGroupId});

  ProfileDetailModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    mobileNo = json['mobile_no'];
    profileImageUrl = json['profile_image_url'];
    activationCode = json['activation_code'].toString();
    profile = json['profile'];
    bankAccountNo = json['bank_account_no'];
    fullName = json['full_name'];
    address = json['address'];
    isActive = json['is_active'];
    registrationDate = json['registration_date'];
    bankIfsc = json['bank_ifsc'];
    subscriberGroupId = json['subscriber_group_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['mobile_no'] = mobileNo;
    data['profile_image_url'] = profileImageUrl;
    data['activation_code'] = activationCode;
    data['profile'] = profile;
    data['bank_account_no'] = bankAccountNo;
    data['full_name'] = fullName;
    data['address'] = address;
    data['is_active'] = isActive;
    data['registration_date'] = registrationDate;
    data['bank_ifsc'] = bankIfsc;
    data['subscriber_group_id'] = subscriberGroupId;
    return data;
  }
}
