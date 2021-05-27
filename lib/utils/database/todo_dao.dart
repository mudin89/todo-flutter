// import 'package:floor/floor.dart';
// import 'package:todo_flutter/model/todo.dart';
//
// @dao
// abstract class TodoDAO {
//   @Query('SELECT * FROM Todo')
//   Future<List<Todo>> retrieveTodoList();
//
//   @Query('SELECT * FROM Todo WHERE id = :id')
//   Future<Todo> retrieveTodo(int id);
//
//   @Query('DELETE FROM Todo WHERE id = :id')
//   Future<Todo> deleteTodo(int id);
//
//   @insert
//   Future<void> insertTodo(Todo todo);
//
//   @insert
//   Future<List<int>> insertTodoList(List<Todo> todo);
//
//   @update
//   Future<void> updateTodo(Todo todo);
//
//   @update
//   Future<void> updateTodoList(List<Todo> todo);
//
//   @delete
//   Future<void> deleteTasks(List<Todo> todo);
// }
