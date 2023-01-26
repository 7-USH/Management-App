// ignore_for_file: non_constant_identifier_names

class AttendanceModel {
  String day;
  String date;
  String check_in_time;
  String check_out_time;

  AttendanceModel(
      {required this.check_in_time,
      required this.check_out_time,
      required this.date,
      required this.day});
}
