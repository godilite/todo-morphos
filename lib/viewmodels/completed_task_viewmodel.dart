import 'package:crud_firebase/locator.dart';
import 'package:crud_firebase/models/task.dart';
import 'package:crud_firebase/services/firebase_services.dart';
import 'package:stacked/stacked.dart';

class CompletedTaskViewModel extends ReactiveViewModel {
  final FirebaseService _firebaseService = locator<FirebaseService>();
  List<Task> get completedTask => _firebaseService.allTasks
      .where((task) => task.completed == true)
      .toList();
  @override
  List<ReactiveServiceMixin> get reactiveServices => [_firebaseService];
}
