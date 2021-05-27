import 'package:event_bus/event_bus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:todo_flutter/model/todo.dart';
import 'package:todo_flutter/utils/event_manager.dart';
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

class _HomeViewState extends State<HomeView> with WidgetsBindingObserver {
  final NavigationService _navigationService = locator<NavigationService>();
  final EventBus _eventBus = locator<EventBus>();

  List<Todo> todoList;
  HomeViewModel _homeViewModel;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.nonReactive(
        viewModelBuilder: () => HomeViewModel(),
        onModelReady: (model) => model.updateList(),
        builder: (_context, model, child) => Scaffold(
              appBar: AppBar(
                title: Text(widget.title),
              ),
              body: _getTodoList(model),
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

  Widget _getTodoList(HomeViewModel viewModel) {
    _homeViewModel = viewModel;
    listenToEvent();
    return FutureBuilder<List<Todo>>(
        future: viewModel.getLatestList(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            todoList = snapshot.data;
            return ListView.builder(
                itemCount: todoList.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                      onTap: () {
                        _navigationService.navigateTo(FormRoute,
                            arguments: FormArguments(id: index));
                      },
                      child: TodoCard(todo: todoList[index]));
                });
          }
          return CircularProgressIndicator();
        });
  }

  void listenToEvent() {
    _eventBus.on<RefreshEvent>().listen((event) {
      // All events are of type UserLoggedInEvent (or subtypes of it).
      refreshDataList();
    });
  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      //do your stuff
      refreshDataList();
    }
  }

  void refreshDataList() async {
    var latestList = await _homeViewModel.getLatestList();

    if (latestList != null) {
      if (latestList.isNotEmpty) {
        setState(() {
          latestList = todoList;
        });
      }
    }
  }
  // FutureBuilder<List<Todo>>(
  //     future: _homeViewModel.getLatestList(),
  //     builder: (context, snapshot) {
  //       setState(() {
  //         if (snapshot.hasData) {
  //           todoList = snapshot.data;
  //         }
  //       });
  //       return;
  //     });
  // todoList = await _homeViewModel.getLatestList();
  //
  // setState(() {
  //   todoList;
  // });

}
