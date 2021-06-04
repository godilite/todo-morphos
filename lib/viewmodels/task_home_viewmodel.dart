import 'package:crud_firebase/locator.dart';
import 'package:crud_firebase/models/task.dart';
import 'package:crud_firebase/services/firebase_services.dart';
import 'package:stacked/stacked.dart';

class TaskViewModel extends ReactiveViewModel {
  final FirebaseService _firebaseService = locator<FirebaseService>();
  List<Task> get allTasks => _firebaseService.allTasks;
  bool firstSyncing = true;
  @override
  List<ReactiveServiceMixin> get reactiveServices => [_firebaseService];

  void initialise() async {
    await _firebaseService.getAllTasks().then((value) {
      firstSyncing = false;
      notifyListeners();
    });
  }

  Future addTask(Task task) async {
    await _firebaseService.addTask(task);
    await _firebaseService.getAllTasks();
    notifyListeners();
  }

  Future updateCompletedTask(bool value, String taskId) async {
    await _firebaseService.updateTask(value, taskId);
    await _firebaseService.getAllTasks();
    notifyListeners();
  }

  Future deleteTask(String id) async {
    await _firebaseService.deleteTask(id);
    await _firebaseService.getAllTasks();
    notifyListeners();
  }
}
