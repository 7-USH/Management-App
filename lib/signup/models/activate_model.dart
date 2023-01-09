class ActivateModel {
  int? activationCode;
  String? email;

  ActivateModel({this.activationCode, this.email});

  ActivateModel.fromJson(Map<String, dynamic> json) {
    activationCode = json['activation_code'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['activation_code'] = activationCode;
    data['email'] = email;
    return data;
  }
}
