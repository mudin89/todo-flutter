import 'package:intl/intl.dart';

class Todo {
  String title;
  DateTime startDate;
  DateTime endDate;

  bool isComplete;
  String countDownTimer;
  DateFormat formatter = DateFormat('dd MMM yyyy');

  String getStartDateAsString() {
    return formatter.format(startDate != null ? startDate : DateTime.now());
  }

  String getEndDateAsString() {
    return formatter.format(startDate != null ? startDate : DateTime.now());
  }

  String getCountDown() {
    var diff = startDate.second - endDate.second;
    Duration duration = Duration(milliseconds: diff);
    int hour = duration.inHours;
    int minLeft = duration.inMinutes.remainder(60);

    return "$hour hrs $minLeft min";
  }
}
