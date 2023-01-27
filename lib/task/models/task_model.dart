class StaffTaskModel {
  String? validFrom;
  List<String>? staffEmails;
  String? taskTitle;
  String? description;
  String? priority;
  int? validFor;

  StaffTaskModel(
      {this.validFrom,
      this.staffEmails,
      this.taskTitle,
      this.description,
      this.priority,
      this.validFor});

  StaffTaskModel.fromJson(Map<String, dynamic> json) {
    validFrom = json['valid_from'];
    staffEmails = json['staff_emails'].cast<String>();
    taskTitle = json['task_title'];
    description = json['description'];
    priority = json['priority'];
    validFor = json['valid_for'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['valid_from'] = this.validFrom;
    data['staff_emails'] = this.staffEmails;
    data['task_title'] = this.taskTitle;
    data['description'] = this.description;
    data['priority'] = this.priority;
    data['valid_for'] = this.validFor;
    return data;
  }
}
