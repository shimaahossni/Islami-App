// core/model/task_model.dart
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'task_model.g.dart';

@HiveType(typeId: 0)
class TaskMdel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String note;

  @HiveField(3)
  final String date;

  @HiveField(4)
  final String startTime;

  @HiveField(5)
  final String endTime;

  @HiveField(6)
  final int color;

  @HiveField(7)
  bool? isCompleted;

  TaskMdel(
      {required this.title,
      required this.note,
      required this.date,
      required this.startTime,
      required this.endTime,
      required this.color,
      required this.id,
      required this.isCompleted});
}
