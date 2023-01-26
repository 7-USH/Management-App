class FamilyMemberModel {
  String? email;
  String? fullName;
  String? mobileNo;
  String? address;
  String? profile;
  String? subscriberGroupId;
  String? relationTag;

  FamilyMemberModel(
      {this.email,
      this.fullName,
      this.mobileNo,
      this.address,
      this.profile,
      this.subscriberGroupId,
      this.relationTag});

  FamilyMemberModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    fullName = json['full_name'];
    mobileNo = json['mobile_no'];
    address = json['address'];
    profile = json['profile'];
    subscriberGroupId = json['subscriber_group_id'];
    relationTag = json['relation_tag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['full_name'] = fullName;
    data['mobile_no'] = mobileNo;
    data['address'] = address;
    data['profile'] = profile;
    data['subscriber_group_id'] = subscriberGroupId;
    data['relation_tag'] = relationTag;
    return data;
  }
}

