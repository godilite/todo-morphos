import 'package:crud_firebase/constants/routes.dart';
import 'package:crud_firebase/ui/screens/home_screen.dart';
import 'package:crud_firebase/ui/screens/completed_task_screen.dart';
import 'package:crud_firebase/ui/screens/task_screen.dart';
import 'package:flutter/material.dart';

/// Generate routes for navigation
Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case Routes.homeViewRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: HomeScreen(),
      );
    case Routes.taskViewRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: TaskScreen(),
      );
    case Routes.completedTaskViewRoute:
      return _getPageRoute(
        viewToShow: CompletedTaskScreen(),
      );
    default:
      return MaterialPageRoute(
        builder: (_) => Scaffold(
          body: Center(
            child: Text('No route defined for ${settings.name}'),
          ),
        ),
      );
  }
}

PageRoute _getPageRoute({ var routeName, required Widget viewToShow}) {
  return MaterialPageRoute(
    settings: RouteSettings(
      name: routeName,
    ),
    builder: (_) => viewToShow,
  );
}
