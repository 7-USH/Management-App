// ignore_for_file: non_constant_identifier_names

class TaskModel {
  String task_number;
  String task_priority;
  String task_message;

  TaskModel(
    {
      required this.task_priority,
      required this.task_message,
      required this.task_number
    }
  );
}
