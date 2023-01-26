class ResetPassModel {
  String? email;
  int? resetCode;
  String? newPassword;

  ResetPassModel({this.email, this.resetCode, this.newPassword});

  ResetPassModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    resetCode = json['reset_code'];
    newPassword = json['new_password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['reset_code'] = resetCode;
    data['new_password'] = newPassword;
    return data;
  }
}
