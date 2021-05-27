import 'package:event_bus/event_bus.dart';
import 'package:stacked/stacked.dart';
import 'package:todo_flutter/utils/data_manager.dart';
import 'package:todo_flutter/utils/database/todo_dao.dart';
import 'package:todo_flutter/utils/navigator_service.dart';
import 'package:todo_flutter/viewmodel/form_viewmodel.dart';
import 'package:todo_flutter/viewmodel/home_viewmodel.dart';

import 'hive_manager.dart';

final locator = StackedLocator.instance;

void setupLocator() {
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => DataManager());
  locator.registerLazySingleton(() => HiveManager());
  locator.registerLazySingleton(() => EventBus());
  locator.registerFactory(() => HomeViewModel());
  locator.registerFactory(() => FormsViewModel());
}
