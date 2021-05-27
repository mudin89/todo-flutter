import 'package:todo_flutter/model/todo.dart';
import 'package:todo_flutter/utils/database/todo_dao.dart';
import 'package:todo_flutter/utils/hive_manager.dart';
import 'package:todo_flutter/utils/locator.dart';
import 'package:todo_flutter/utils/view_states.dart';
import 'package:todo_flutter/viewmodel/base_model.dart';

class HomeViewModel extends BaseModel {
  HiveManager _hiveManager = locator<HiveManager>();

  Future<List<Todo>> getLatestList() async {
    var currentList = await _hiveManager.retrieveTodoList();
    return currentList != null ? currentList : [].toList().cast<Todo>();
  }

  Future updateList() async {
    setState(ViewState.Busy); //show loading

    try {
      setState(ViewState.Idle); //remove loading when done
    } catch (error) {
      setState(ViewState.Error); //remove loading when done
    }

    setState(ViewState.Idle); //remove loading when done
  }
}
