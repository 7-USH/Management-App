class PlanModel {
  double? minMembers;
  String? id;
  double? price;
  double? maxMembers;
  String? planName;

  PlanModel(
      {this.minMembers, this.id, this.price, this.maxMembers, this.planName});

  PlanModel.fromJson(Map<String, dynamic> json) {
    minMembers = json["min_members"];
    id = json['id'];
    price = json["price"];
    maxMembers = json["max_members"];
    planName = json['plan_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['min_members'] = minMembers;
    data['plan_id'] = id;
    data['price'] = price;
    data['max_members'] = maxMembers;
    data['plan_name'] = planName;
    return data;
  }
}


class AdminPlan {
  String? planId;
  String? id;
  String? validUntil;
  String? adminEmail;
  String? createdAt;
  double? memberCount;

  AdminPlan(
      {this.planId,
      this.id,
      this.validUntil,
      this.adminEmail,
      this.createdAt,
      this.memberCount});

  AdminPlan.fromJson(Map<String, dynamic> json) {
    planId = json['plan_id'];
    id = json['id'];
    validUntil = json['valid_until'];
    adminEmail = json['admin_email'];
    createdAt = json['created_at'];
    memberCount = json['member_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['plan_id'] = planId;
    data['id'] = id;
    data['valid_until'] = validUntil;
    data['admin_email'] = adminEmail;
    data['created_at'] = createdAt;
    data['member_count'] = memberCount;
    return data;
  }
}
