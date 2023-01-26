import 'package:manage_app/attendance/models/status_enum.dart';

class AttendanceTimeModel {
  late AttendanceStatus status;
  String? checkInTime;
  String? checkOutTime;

  AttendanceTimeModel({this.status = AttendanceStatus.CHECK_IN,this.checkInTime, this.checkOutTime});

  AttendanceTimeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'] == "checked_out"
        ? AttendanceStatus.CHECK_OUT
        : AttendanceStatus.CHECK_IN;
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
