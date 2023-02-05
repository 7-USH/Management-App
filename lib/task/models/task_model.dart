class StaffTaskModel {
  String? validFrom;
  List<String>? staffEmails;
  String? taskTitle;
  String? description;
  String? priority;
  int? validFor;
  String? id;

  StaffTaskModel(
      {this.validFrom,
      this.staffEmails,
      this.id,
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['valid_from'] = validFrom;
    data['staff_emails'] = staffEmails;
    data['task_title'] = taskTitle;
    data['description'] = description;
    data['priority'] = priority;
    data['valid_for'] = validFor;
    data['task_id'] = id;
    return data;
  }
}
