import 'package:todo_flutter/utils/view_states.dart';
import 'package:todo_flutter/viewmodel/base_model.dart';

class HomeViewModel extends BaseModel {
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
