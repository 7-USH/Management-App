class RegisterModel {
  String? email;
  String? firstName;
  String? lastName;
  String? mobileNo;
  String? address;
  String? password;

  RegisterModel(
      {this.email,
      this.firstName,
      this.lastName,
      this.mobileNo,
      this.address,
      this.password});

  RegisterModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    mobileNo = json['mobile_no'];
    address = json['address'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['mobile_no'] = mobileNo;
    data['address'] = address;
    data['password'] = password;
    return data;
  }
}
