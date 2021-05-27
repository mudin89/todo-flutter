import 'dart:io';

import 'package:hive/hive.dart';

part 'todo.g.dart';

@HiveType(typeId: 1)
class Todo extends HiveObject {
  @HiveField(0)
  int id;

  @HiveField(1)
  String title;

  @HiveField(2)
  int startDate;

  @HiveField(3)
  int endDate;

  @HiveField(4)
  bool isComplete;

  @HiveField(5)
  String countDownTimer;

  Todo(
      {this.id,
      this.title,
      this.startDate,
      this.endDate,
      this.isComplete,
      this.countDownTimer});
}
