class FamilyMemberModel {
  String? email;
  String? fullName;
  String? mobileNo;
  String? address;
  String? profile;
  String? parentEmail;
  String? childEmail;
  String? relationTag;

  FamilyMemberModel(
      {this.email,
      this.fullName,
      this.mobileNo,
      this.address,
      this.profile,
      this.parentEmail,
      this.childEmail,
      this.relationTag});

  FamilyMemberModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    fullName = json['full_name'];
    mobileNo = json['mobile_no'];
    address = json['address'];
    profile = json['profile'];
    parentEmail = json['parent_email'];
    childEmail = json['child_email'];
    relationTag = json['relation_tag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['full_name'] = fullName;
    data['mobile_no'] = mobileNo;
    data['address'] = address;
    data['profile'] = profile;
    data['parent_email'] = parentEmail;
    data['child_email'] = childEmail;
    data['relation_tag'] = relationTag;
    return data;
  }
}
