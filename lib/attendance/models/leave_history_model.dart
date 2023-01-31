class LeaveHistoryModel {
  String? staffId;
  String? reason;
  String? endingDate;
  String? leaveSubject;
  String? id;
  String? startingDate;
  String? status;

  LeaveHistoryModel(
      {this.staffId,
      this.reason,
      this.endingDate,
      this.leaveSubject,
      this.id,
      this.startingDate,
      this.status});

  LeaveHistoryModel.fromJson(Map<String, dynamic> json) {
    staffId = json['staff_id'];
    reason = json['reason'];
    endingDate = json['ending_date'];
    leaveSubject = json['leave_subject'];
    id = json['id'];
    startingDate = json['starting_date'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['staff_id'] = staffId;
    data['reason'] = reason;
    data['ending_date'] = endingDate;
    data['leave_subject'] = leaveSubject;
    data['id'] = id;
    data['starting_date'] = startingDate;
    data['status'] = status;
    return data;
  }
}
