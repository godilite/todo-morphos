import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_firebase/models/task.dart';
import 'package:stacked/stacked.dart';
import 'package:observable_ish/observable_ish.dart';

class FirebaseService with ReactiveServiceMixin {
  FirebaseService() {
    listenToReactiveValues([_allTasks]);
  }
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  get collectionRef => _firestore.collection('task');

  //Reactive Value
  RxValue<List<Task>> _allTasks = RxValue([]);
  List<Task> get allTasks => _allTasks.value;

  Future<List> getAllTasks() async {
    List<Task> tasks = [];
    await collectionRef.get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        tasks.add(Task.fromMap(doc));
      });
      print(tasks);
      _allTasks.value.clear();
      _allTasks.value.addAll(tasks);
    });
    return tasks;
  }

  Future addTask(Task task) async {
    await collectionRef
        .add(task.toMap())
        .whenComplete(() => true)
        .catchError((e) => throw (e));
  }

  Future deleteTask(String taskId) async {
    DocumentReference documentRef = collectionRef.doc(taskId);
    await documentRef
        .delete()
        .whenComplete(() => true)
        .catchError((e) => {throw (e)});
  }

  Future updateTask(value, taskId) async {
    DocumentReference documentRef = collectionRef.doc(taskId);
    await documentRef
        .update({'completed': value})
        .whenComplete(() => true)
        .catchError((e) => throw (e));
  }
}
