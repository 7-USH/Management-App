// ignore_for_file: non_constant_identifier_names

class NotificationModel {
  String notify_message;
  String date;
  String owner_name;
  String owner_image;

  NotificationModel(
      {required this.date,
      required this.notify_message,
      required this.owner_image,
      required this.owner_name});
}
