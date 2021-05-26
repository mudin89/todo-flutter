import 'package:flutter/material.dart';
import 'package:todo_flutter/model/Todo.dart';
import 'package:todo_flutter/utils/constants.dart';

class TodoCard extends StatelessWidget {
  TodoCard({@required this.todo});

  final Todo todo;

  var titleStyle = TextStyle(
    fontSize: 15,
    color: Colors.blue,
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Container(
        child: Column(children: [
          _firstRow(todo.title),
          _secondRow("Second"),
          _thirdRow(todo.getStartDateAsString(), todo.getEndDateAsString(),
              todo.getCountDown()),
          _fourthRow(todo.isComplete)
        ]),
        margin: EdgeInsets.all(4.0),
        decoration: BoxDecoration(
          boxShadow: [
            new BoxShadow(
              color: Colors.grey,
              blurRadius: 5.0,
            ),
          ],
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }

  Widget _firstRow(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
      child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            title,
            style: kBlack24Bold,
          )),
    );
  }

  Widget _secondRow(String title) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 0.0),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(
            "Start Date",
            style: kBlack16Regular,
          ),
          Text(
            "End Date",
            style: kBlack16Regular,
          ),
          Text(
            "Time left",
            style: kBlack16Regular,
          ),
        ]),
      ),
    );
  }

  Widget _thirdRow(String startDate, String endDate, String countDown) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(
            startDate,
            style: kBlack16Bold,
          ),
          Text(
            endDate,
            style: kBlack16Bold,
          ),
          Text(
            countDown,
            style: kBlack16Bold,
          ),
        ]),
      ),
    );
  }

  Widget _fourthRow(bool status) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 0.0),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(
            "Status",
            style: kGrey16Regular,
          ),
          Text(
            status ? "Complete" : "Incomplete",
            style: kBlack16Bold,
          ),
          Text(
            "Tick if completed",
            style: kBlack16Regular,
          ),
          Checkbox(value: status, onChanged: null)
        ]),
      ),
      decoration: BoxDecoration(
        color: Colors.yellow.shade300,
        borderRadius: BorderRadius.circular(10.0),
      ),
    );
  }
}
