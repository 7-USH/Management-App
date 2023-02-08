class StaffDetailsModel {
  String? id;
  String? designation;
  String? employmentStatus;
  String? userEmail;
  String? jobDetails;
  String? profileImageUrl;
  String? fullName;

  StaffDetailsModel(
      {this.id,
      this.designation,
      this.employmentStatus,
      this.userEmail,
      this.jobDetails,
      this.profileImageUrl,
      this.fullName});

  StaffDetailsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    designation = json['designation'];
    employmentStatus = json['employment_status'];
    userEmail = json['user_email'];
    jobDetails = json['job_details'];
    profileImageUrl = json['profile_image_url'];
    fullName = json['full_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['designation'] = designation;
    data['employment_status'] = employmentStatus;
    data['user_email'] = userEmail;
    data['job_details'] = jobDetails;
    data['profile_image_url'] = profileImageUrl;
    data['full_name'] = fullName;
    return data;
  }
}
