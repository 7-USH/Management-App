class CheckStatusModel {
  String? id;
  String? checkInTime;
  String? date;
  String? checkOutTime;
  String? staffId;
  String? status;

  CheckStatusModel(
      {this.id,
      this.checkInTime,
      this.date,
      this.checkOutTime,
      this.staffId,
      this.status});

  CheckStatusModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    checkInTime = json['check_in_time'];
    date = json['date'];
    checkOutTime = json['check_out_time'];
    staffId = json['staff_id'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['check_in_time'] = checkInTime;
    data['date'] = date;
    data['check_out_time'] = checkOutTime;
    data['staff_id'] = staffId;
    data['status'] = status;
    return data;
  }
}
