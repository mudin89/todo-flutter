import 'package:event_bus/event_bus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:todo_flutter/model/todo.dart';
import 'package:todo_flutter/utils/constants.dart';
import 'package:todo_flutter/utils/event_manager.dart';
import 'package:todo_flutter/utils/locator.dart';
import 'package:todo_flutter/utils/navigator_service.dart';
import 'package:todo_flutter/viewmodel/form_viewmodel.dart';

class FormView extends StatefulWidget {
  FormView({Key key, this.id}) : super(key: key);

  final int id;

  @override
  _FormViewState createState() => _FormViewState(id);
}

class _FormViewState extends State<FormView> {
  int todoId;
  String title = "";
  int startDate = 0;
  String startDateText = "Please select a Date";
  int endDate = 0;
  String endDateText = "Please select a Date";
  bool isComplete = false;
  FormsViewModel _formViewModel;

  final NavigationService _navigationService = locator<NavigationService>();
  final EventBus _eventBus = locator<EventBus>();
  TextEditingControllerWithCursorPosition titleController =
      new TextEditingControllerWithCursorPosition(text: "Title here");

  _FormViewState(int id) {
    this.todoId = id;
    this.title = "";
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<FormsViewModel>.nonReactive(
        viewModelBuilder: () => FormsViewModel(),
        onModelReady: (model) => model.state,
        builder: (_context, model, child) => Scaffold(
            appBar: AppBar(
              title: Text("Add New To-Do List"),
            ),
            body: Center(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Container(
                  child: Column(children: [
                    _firstRow(model),
                    _secondRow(model),
                    _thirdRow(model),
                    _fourthRow(model),
                    _fifthRow(model),
                    _sixthRow(model),
                  ]),
                  margin: EdgeInsets.all(4.0),
                ),
              ),
            ),
            bottomNavigationBar: BottomAppBar(
              child: SizedBox(
                height: 70,
                child: RaisedButton(
                  color: Colors.black,
                  child: Center(
                    child: Text(
                      todoId == -1 ? 'CREATE NOW' : "SAVE TODO",
                      style: kWhite22Bold,
                    ),
                  ),
                  onPressed: () {
                    title = titleController.text;
                    if (title == "") {
                      Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text("a minimum of 3 characters is required"),
                      ));
                      return;
                    }

                    if (startDate == 0) {
                      Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text("Please select start date"),
                      ));
                      return;
                    }

                    if (endDate == 0) {
                      Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text("Please select end date"),
                      ));
                      return;
                    }

                    if (todoId == -1) {
                      Todo toAdd = Todo(
                          title: title,
                          startDate: startDate,
                          endDate: endDate,
                          isComplete: false);
                      model.addTodo(toAdd);
                    } else {
                      Todo toAdd = Todo(
                          id: todoId,
                          title: title,
                          startDate: startDate,
                          endDate: endDate,
                          isComplete: isComplete);
                      model.updateTodo(toAdd, todoId);
                    }

                    _navigationService.goBack();

                    _eventBus.fire(RefreshEvent());

                    //model view will save here
                    //to login view
                  },
                ),
              ),
            ))); // This trailing comma makes auto-formatting nicer for build methods.
  }

  Widget _firstRow(FormsViewModel model) {
    _formViewModel = model;
    if (todoId != -1) {
      initTodo(model);
    }
    return Container(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 8.0),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "To-Do Title",
            style: kGrey22Bold,
          ),
        ),
      ),
    );
  }

  void initTodo(FormsViewModel model) async {
    var todoList = await model.getTodoList();

    if (todoList != null) {
      if (todoList.isNotEmpty) {
        Todo todo = todoList[todoId];
        if (todo != null) {
          // title = todo.title != null ? todo.title : "";
          // titleController.text = title;

          setState(() {
            startDate = todo.startDate != null
                ? todo.startDate
                : DateTime.now().millisecondsSinceEpoch;
            startDateText = model.getAsString(startDate);
            endDate = todo.endDate != null
                ? todo.endDate
                : DateTime.now().millisecondsSinceEpoch;
            endDateText = model.getAsString(endDate);
            isComplete = todo.isComplete != null ? todo.isComplete : false;
          });
        }
      }
    }
    // FutureBuilder<List<Todo>>(
    //     future: model.getTodoList(),
    //     builder: (context, snapshot) {
    //       setState(() {
    //
    //
    //         return;
    //       });
    //     });
    // await model.getTodo(todoId).then((todo) => {
    //       if (todo != null)
    //         {
    //           title = todo.title != null ? todo.title : "",
    //           startDate = todo.startDate != null ? todo.startdate : 0,
    //           endDate = todo.endDate != null ? todo.endDate : 0,
    //           isComplete = todo.isComplete != null ? todo.isComplete : false,
    //         }
    //     });
  }

  Widget _secondRow(FormsViewModel model) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 16.0),
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            // initialValue: "test ",
            controller: titleController,
            autovalidateMode: AutovalidateMode.disabled,
            onChanged: (content) {
              // title = content;
            },
          ),
        ),
        decoration: BoxDecoration(
          boxShadow: [
            new BoxShadow(
              color: Colors.black,
              blurRadius: 5.0,
            ),
          ],
          color: Colors.white,
          borderRadius: BorderRadius.circular(1.0),
        ),
      ),
    );
  }

  Widget _thirdRow(FormsViewModel model) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 8.0),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Start Date",
            style: kGrey22Bold,
          ),
        ),
      ),
    );
  }

  Widget _fourthRow(FormsViewModel model) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 16.0),
      child: GestureDetector(
        onTap: () {
          _selectDate(context, true);
        },
        child: Container(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              startDateText,
              style: kGrey16Regular,
            ),
          ),
          decoration: BoxDecoration(
            boxShadow: [
              new BoxShadow(
                color: Colors.black,
                blurRadius: 5.0,
              ),
            ],
            color: Colors.white,
            borderRadius: BorderRadius.circular(1.0),
          ),
        ),
      ),
    );
  }

  Widget _fifthRow(FormsViewModel model) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 8.0),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "End Date",
            style: kGrey22Bold,
          ),
        ),
      ),
    );
  }

  Widget _sixthRow(FormsViewModel model) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 16.0),
      child: GestureDetector(
        onTap: () {
          _selectDate(context, false);
        },
        child: Container(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              endDateText,
              style: kGrey16Regular,
            ),
          ),
          decoration: BoxDecoration(
            boxShadow: [
              new BoxShadow(
                color: Colors.black,
                blurRadius: 5.0,
              ),
            ],
            color: Colors.white,
            borderRadius: BorderRadius.circular(1.0),
          ),
        ),
      ),
    );
  }

  _selectDate(BuildContext context, bool isStart) async {
    var sD = startDate != 0 ? startDate : DateTime.now().millisecondsSinceEpoch;
    var eD = endDate != 0 ? endDate : DateTime.now().millisecondsSinceEpoch;
    var currentDate = DateTime.fromMillisecondsSinceEpoch(sD);
    var endsDate = DateTime.fromMillisecondsSinceEpoch(eD);

    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: isStart ? currentDate : endsDate, // Refer step 1
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != (isStart ? currentDate : endsDate))
      setState(() {
        if (isStart) {
          startDate = picked.millisecondsSinceEpoch;
          startDateText = _formViewModel.getAsString(startDate);
        } else {
          endDate = picked.millisecondsSinceEpoch;
          endDateText = _formViewModel.getAsString(endDate);
        }
      });
  }
}

class TextEditingControllerWithCursorPosition extends TextEditingController {
  TextEditingControllerWithCursorPosition({String text}) : super(text: text);

  @override
  set text(String newText) {
    value = value.copyWith(
      text: newText,
      selection: value.selection,
      composing: TextRange.empty,
    );
  }
}
