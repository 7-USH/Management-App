class CreateLeaveModel {
  String? startingDate;
  String? endingDate;
  String? reason;
  String? leaveSubject;

  CreateLeaveModel(
      {this.startingDate, this.endingDate, this.reason, this.leaveSubject});

  CreateLeaveModel.fromJson(Map<String, dynamic> json) {
    startingDate = json['starting_date'];
    endingDate = json['ending_date'];
    reason = json['reason'];
    leaveSubject = json['leave_subject'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['starting_date'] = startingDate;
    data['ending_date'] = endingDate;
    data['reason'] = reason;
    data['leave_subject'] = leaveSubject;
    return data;
  }
}
