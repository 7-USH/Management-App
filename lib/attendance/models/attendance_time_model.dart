class AttendanceTimeModel {
  String? status;
  String? checkInTime;
  String? checkOutTime;

  AttendanceTimeModel({this.status, this.checkInTime, this.checkOutTime});

  AttendanceTimeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    checkInTime = json['check_in_time'];
    checkOutTime = json['check_out_time'];
  }

  Map<String, dynamic> toJson() {
    // ignore: prefer_collection_literals
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = status;
    data['check_in_time'] = checkInTime;
    data['check_out_time'] = checkOutTime;
    return data;
  }
}
