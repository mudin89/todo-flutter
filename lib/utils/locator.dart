import 'package:stacked/stacked.dart';
import 'package:todo_flutter/utils/navigator_service.dart';

final locator = StackedLocator.instance;

void setupLocator() {
  locator.registerLazySingleton(() => NavigationService());
}
