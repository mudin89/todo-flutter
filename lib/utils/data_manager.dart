import 'package:intl/intl.dart';
import 'package:todo_flutter/model/todo.dart';

class DataManager {
  DateFormat formatter = DateFormat('dd MMM yyyy');

  String getStartDate(Todo todo) {
    var startDate = DateTime.fromMillisecondsSinceEpoch(todo.startDate);
    return formatter.format(startDate != null ? startDate : DateTime.now());
  }

  String getEndDate(Todo todo) {
    var endDate = DateTime.fromMillisecondsSinceEpoch(todo.endDate);
    return formatter.format(endDate != null ? endDate : DateTime.now());
  }

  String dateToString(int milis) {
    var date = DateTime.fromMillisecondsSinceEpoch(milis);
    var result = formatter.format(date != null ? date : DateTime.now());
    return result;
  }

  String getCountDown(Todo todo) {
    var diff = todo.endDate - DateTime.now().millisecondsSinceEpoch;
    Duration duration = Duration(milliseconds: diff);
    int hour = duration.inHours;
    int minLeft = duration.inMinutes.remainder(60);

    return "$hour hrs $minLeft min";
  }
}
