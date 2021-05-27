import 'package:event_bus/event_bus.dart';
import 'package:todo_flutter/model/todo.dart';
import 'package:todo_flutter/utils/data_manager.dart';
import 'package:todo_flutter/utils/database/todo_dao.dart';
import 'package:todo_flutter/utils/event_manager.dart';
import 'package:todo_flutter/utils/hive_manager.dart';
import 'package:todo_flutter/utils/locator.dart';
import 'package:todo_flutter/utils/view_states.dart';
import 'package:todo_flutter/viewmodel/base_model.dart';

class FormsViewModel extends BaseModel {
  // final TodoDAO _todoDAO = locator<TodoDAO>();
  final DataManager _dataManager = locator<DataManager>();
  final HiveManager _hiveManager = locator<HiveManager>();

  final EventBus _eventBus = locator<EventBus>();

  String getAsString(int milis) {
    return _dataManager.dateToString(milis);
  }

  Future saveTodo(Todo todo) async {
    _hiveManager.saveTodo(todo);
  }

  Future addTodo(Todo todo) async {
    // setState(ViewState.Busy); //show loading
    var currentList = await _hiveManager.retrieveTodoList();
    if (currentList == null) {
      currentList = [].toList().cast<Todo>();
    }
    currentList.add(todo);
    _hiveManager.saveTodoList(currentList);
  }

  Future updateTodo(Todo todo, int position) async {
    // setState(ViewState.Busy); //show loading
    var currentList = await _hiveManager.retrieveTodoList();
    currentList[position] = todo;
    _hiveManager.saveTodoList(currentList);
  }

  Future updateTodoStatus(int position, bool status) async {
    // setState(ViewState.Busy); //show loading
    var currentList = await _hiveManager.retrieveTodoList();
    var todo = currentList[position];
    todo.isComplete = status;
    _hiveManager.saveTodoList(currentList);
    _eventBus.fire(RefreshEvent());
  }

  Future<Todo> getTodo() async {
    var todo = await _hiveManager.retrieveTodo();
    return todo != null ? todo : Todo();
  }

  Future<Todo> getTodoByPosition(int position) async {
    var currentList = await _hiveManager.retrieveTodoList();
    return currentList[position] != null ? currentList[position] : Todo();
  }

  Future<List<Todo>> getTodoList() async {
    var currentList = await _hiveManager.retrieveTodoList();
    return currentList != null ? currentList : [].toList().cast<Todo>();
  }

  // Future updateList() async {
  //   setState(ViewState.Busy); //show loading
  //
  //   try {
  //     setState(ViewState.Idle); //remove loading when done
  //   } catch (error) {
  //     setState(ViewState.Error); //remove loading when done
  //   }
  //
  //   setState(ViewState.Idle); //remove loading when done
  // }
}
