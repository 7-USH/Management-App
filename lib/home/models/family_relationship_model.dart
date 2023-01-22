class FamilyRelationShipModel {
  List<UserRealtions>? userRealtions;
  List<Users>? users;

  FamilyRelationShipModel({this.userRealtions, this.users});

  FamilyRelationShipModel.fromJson(Map<String, dynamic> json) {
    if (json['user_realtions'] != null) {
      userRealtions = <UserRealtions>[];
      json['user_realtions'].forEach((v) {
        userRealtions!.add(UserRealtions.fromJson(v));
      });
    }
    if (json['users'] != null) {
      users = <Users>[];
      json['users'].forEach((v) {
        users!.add(Users.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (userRealtions != null) {
      data['user_realtions'] =
          userRealtions!.map((v) => v.toJson()).toList();
    }
    if (users != null) {
      data['users'] = users!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserRealtions {
  String? childEmail;
  String? subscriberGroupId;
  String? parentEmail;
  String? relationTag;
  String? id;

  UserRealtions(
      {this.childEmail,
      this.subscriberGroupId,
      this.parentEmail,
      this.relationTag,
      this.id});

  UserRealtions.fromJson(Map<String, dynamic> json) {
    childEmail = json['child_email'];
    subscriberGroupId = json['subscriber_group_id'];
    parentEmail = json['parent_email'];
    relationTag = json['relation_tag'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['child_email'] = childEmail;
    data['subscriber_group_id'] = subscriberGroupId;
    data['parent_email'] = parentEmail;
    data['relation_tag'] = relationTag;
    data['id'] = id;
    return data;
  }
}

class Users {
  String? email;
  String? fullName;
  String? address;
  String? profileImageUrl;
  String? registrationDate;
  String? subscriberGroupId;
  String? mobileNo;
  bool? isActive;
  String? bankAccountNo;
  String? bankIfsc;
  String? activationCode;
  String? profile;

  Users(
      {this.email,
      this.fullName,
      this.address,
      this.profileImageUrl,
      this.registrationDate,
      this.subscriberGroupId,
      this.mobileNo,
      this.isActive,
      this.bankAccountNo,
      this.bankIfsc,
      this.activationCode,
      this.profile});

  Users.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    fullName = json['full_name'];
    address = json['address'];
    profileImageUrl = json['profile_image_url'];
    registrationDate = json['registration_date'];
    subscriberGroupId = json['subscriber_group_id'];
    mobileNo = json['mobile_no'];
    isActive = json['is_active'];
    bankAccountNo = json['bank_account_no'];
    bankIfsc = json['bank_ifsc'];
    activationCode =  json['activation_code'].toString();
    profile = json['profile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['full_name'] = fullName;
    data['address'] = address;
    data['profile_image_url'] = profileImageUrl;
    data['registration_date'] = registrationDate;
    data['subscriber_group_id'] = subscriberGroupId;
    data['mobile_no'] = mobileNo;
    data['is_active'] = isActive;
    data['bank_account_no'] = bankAccountNo;
    data['bank_ifsc'] = bankIfsc;
    data['activation_code'] = activationCode;
    data['profile'] = profile;
    return data;
  }
}
