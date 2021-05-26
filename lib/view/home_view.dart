import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:todo_flutter/model/Todo.dart';
import 'package:todo_flutter/utils/locator.dart';
import 'package:todo_flutter/utils/navigator_service.dart';
import 'package:todo_flutter/utils/route_names.dart';
import 'package:todo_flutter/utils/screen_argument.dart';
import 'package:todo_flutter/view/widget/TodoWidget.dart';
import 'package:todo_flutter/viewmodel/home_viewmodel.dart';

class HomeView extends StatefulWidget {
  HomeView({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final NavigationService _navigationService = locator<NavigationService>();

  @override
  Widget build(BuildContext context) {
    var items = getTodoList();
    return ViewModelBuilder<HomeViewModel>.nonReactive(
        viewModelBuilder: () => HomeViewModel(),
        onModelReady: (model) => model.updateList(),
        builder: (_context, model, child) => Scaffold(
              appBar: AppBar(
                title: Text(widget.title),
              ),
              body: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return TodoCard(todo: items[index]);
                },
              ),
              floatingActionButton: FloatingActionButton(
                child: Icon(Icons.add),
                onPressed: () {
                  _navigationService.navigateTo(FormRoute,
                      arguments: FormArguments(id: -1));
                },
              ),
              floatingActionButtonLocation: FloatingActionButtonLocation
                  .centerFloat, // This trailing comma makes auto-formatting nicer for build methods.
            ));
  }

  List<Todo> getTodoList() {
    List<Todo> todoList = [];

    Todo one = Todo();
    one.title = "test";
    one.startDate = DateTime.now();
    one.endDate = DateTime.now();
    one.isComplete = false;

    todoList.add(one);
    todoList.add(one);
    todoList.add(one);
    todoList.add(one);
    todoList.add(one);

    return todoList;
  }
}
