class SessionModel {
  String? session;

  SessionModel({this.session});

  SessionModel.fromJson(Map<String, dynamic> json) {
    session = json['session'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['session'] = session;
    return data;
  }
}
