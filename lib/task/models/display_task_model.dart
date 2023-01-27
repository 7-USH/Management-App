class DisplayStaffTaskModel {
  double? validFor;
  String? id;
  String? description;
  String? priority;
  String? assignedAt;
  String? taskTitle;
  String? validFrom;
  String? status;

  DisplayStaffTaskModel(
      {this.validFor,
      this.id,
      this.description,
      this.priority,
      this.assignedAt,
      this.taskTitle,
      this.validFrom,
      this.status});

  DisplayStaffTaskModel.fromJson(Map<String, dynamic> json) {
    validFor = json['valid_for'];
    id = json['id'];
    description = json['description'];
    priority = json['priority'];
    assignedAt = json['assigned_at'];
    taskTitle = json['task_title'];
    validFrom = json['valid_from'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['valid_for'] = validFor;
    data['id'] = id;
    data['description'] = description;
    data['priority'] = priority;
    data['assigned_at'] = assignedAt;
    data['task_title'] = taskTitle;
    data['valid_from'] = validFrom;
    data['status'] = status;
    return data;
  }
}
