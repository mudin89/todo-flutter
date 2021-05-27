import 'package:hive/hive.dart';
import 'package:todo_flutter/model/todo.dart';
import 'package:todo_flutter/utils/constants.dart';

class HiveManager {
  Future<Todo> retrieveTodo() async {
    var box = await Hive.openBox('myBox');
    return box.get(TODO);
  }

  void saveTodo(Todo todo) async {
    var box = await Hive.openBox('myBox');
    box.put(TODO, todo);
  }

  Future<List<Todo>> retrieveTodoList() async {
    var box = await Hive.openBox('myBox');
    return box.get(TODOLIST, defaultValue: []).cast<Todo>();
  }

  void saveTodoList(List<Todo> todoList) async {
    var box = await Hive.openBox('myBox');
    box.put(TODOLIST, todoList);
  }
}
