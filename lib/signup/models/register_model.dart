class RegisterModel {
  String? email;
  String? fullName;
  String? mobileNo;
  String? address;
  String? password;
  String? profile;

  RegisterModel(
      {this.email,
      this.fullName,
      this.mobileNo,
      this.address,
      this.password,
      this.profile});

  RegisterModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    fullName = json['full_name'];
    mobileNo = json['mobile_no'];
    address = json['address'];
    password = json['password'];
    profile = json['profile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['full_name'] = fullName;
    data['mobile_no'] = mobileNo;
    data['address'] = address;
    data['password'] = password;
    data['profile'] = "admin";
    return data;
  }
}
