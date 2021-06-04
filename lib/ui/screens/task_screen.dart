import 'package:crud_firebase/constants/routes.dart';
import 'package:crud_firebase/models/task.dart';
import 'package:crud_firebase/viewmodels/task_home_viewmodel.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class TaskScreen extends StatefulWidget {
  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  GlobalKey<FormState> _formKey = GlobalKey();
  final taskTitleController = TextEditingController();
  final taskDescController = TextEditingController();
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return ViewModelBuilder<TaskViewModel>.reactive(
                viewModelBuilder: () => TaskViewModel(),
                onModelReady: (model) => model.initialise(),
                builder: (context, model, snapshot) {
                  List<Task> tasks = model.allTasks;

                  return Scaffold(
                    appBar: AppBar(
                      title: Text("Todo App"),
                      brightness: Brightness.dark,
                    ),
                    floatingActionButton: FloatingActionButton(
                      onPressed: () {
                        showAddTask(model);
                      },
                      child: Icon(Icons.add),
                    ),
                    body: SingleChildScrollView(
                      child: model.firstSyncing
                          ? Padding(
                              padding: EdgeInsets.only(
                                  top:
                                      MediaQuery.of(context).size.height * 0.4),
                              child: Center(child: CircularProgressIndicator()),
                            )
                          : tasks.length == 0
                              ? Padding(
                                  padding: EdgeInsets.only(
                                      top: MediaQuery.of(context).size.height *
                                          0.4),
                                  child: Center(
                                    child: Text(
                                      "No available task ",
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ),
                                )
                              : Column(children: [
                                  ListView.separated(
                                    shrinkWrap: true,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0, vertical: 10.0),
                                    itemCount: tasks.length,
                                    itemBuilder: (context, index) {
                                      final Task task = tasks[index];
                                      return Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            flex: 2,
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    task.title,
                                                    style: TextStyle(
                                                        fontSize: 22,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  Text(task.desc,
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w400))
                                                ]),
                                          ),
                                          Expanded(
                                              flex: 1,
                                              child: Row(
                                                children: [
                                                  Checkbox(
                                                    value: task.completed,
                                                    onChanged: (value) async {
                                                      await model
                                                          .updateCompletedTask(
                                                        !task.completed,
                                                        task.id,
                                                      );

                                                      final snackBar = SnackBar(
                                                          content: Text(
                                                              'Task updated successfully'));

                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                              snackBar);
                                                    },
                                                  ),
                                                  Spacer(),
                                                  IconButton(
                                                    icon: Icon(Icons.delete),
                                                    onPressed: () async {
                                                      await model
                                                          .deleteTask(task.id);

                                                      final snackBar = SnackBar(
                                                          content: Text(
                                                              'Task deleted'));

                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                              snackBar);
                                                    },
                                                  )
                                                ],
                                              )),
                                        ],
                                      );
                                    },
                                    separatorBuilder:
                                        (BuildContext context, int index) {
                                      return Divider();
                                    },
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 50.0),
                                    child: ElevatedButton(
                                      child: Text('View Completed'),
                                      onPressed: () {
                                        Navigator.pushNamed(
                                            context, Routes.completedTaskViewRoute);
                                      },
                                      style: ElevatedButton.styleFrom(
                                          primary: Colors.brown,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 10),
                                          textStyle: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                  ),
                                ]),
                    ),
                  );
                });
          } else {
            return Container(
              color: Colors.white,
              child: Center(child: CircularProgressIndicator()),
            );
          }
        });
  }

  void showAddTask(var model) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          final node = FocusScope.of(context);
          return Padding(
            padding: EdgeInsets.only(
                left: 20,
                right: 20,
                top: 0.0,
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                        child: Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        icon: Icon(
                          Icons.arrow_downward,
                          color: Colors.brown,
                          size: 20,
                        ),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    )),
                    SizedBox(height: 10),
                    TextFormField(
                      onEditingComplete: () => node.nextFocus(),
                      autofocus: true,
                      validator: (value) {
                        if (value == '')
                          return 'Required';
                        else
                          return null;
                      },
                      keyboardType: TextInputType.text,
                      cursorColor: Colors.grey,
                      controller: taskTitleController,
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey,
                      ),
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 10),
                          errorBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(6.0)),
                            borderSide:
                                BorderSide(color: Colors.brown, width: 0.3),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(6.0)),
                            borderSide:
                                BorderSide(color: Colors.brown, width: 0.3),
                          ),
                          fillColor: Colors.white70,
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(6.0)),
                            borderSide:
                                BorderSide(color: Colors.brown, width: 0.3),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(6.0)),
                              borderSide:
                                  BorderSide(color: Colors.brown, width: 1.5)),
                          hintStyle: TextStyle(fontSize: 15),
                          labelStyle: TextStyle(
                              color: Colors.brown,
                              fontSize: 15.0,
                              fontWeight: FontWeight.normal),
                          labelText: "Title"),
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      keyboardType: TextInputType.multiline,
                      controller: taskDescController,
                      validator: (value) {
                        if (value == '')
                          return 'Required';
                        else
                          return null;
                      },
                      maxLength: 150,
                      maxLines: 5,
                      cursorColor: Colors.grey,
                      minLines: 1,
                      textInputAction: TextInputAction.newline,
                      autofocus: true,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey,
                      ),
                      decoration: InputDecoration(
                          suffixIcon: IconButton(
                              onPressed: () async {
                                await model.addTask(Task(
                                    id: '',
                                    title: taskTitleController.text,
                                    desc: taskDescController.text,
                                    completed: false));
                                taskTitleController.clear();
                                taskDescController.clear();

                                Navigator.pop(context);
                                final snackBar =
                                    SnackBar(content: Text('New task added'));

                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              },
                              icon: Icon(
                                Icons.send_rounded,
                                size: 30,
                                color: Colors.brown,
                              )),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 10),
                          errorBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(6.0)),
                            borderSide:
                                BorderSide(color: Colors.brown, width: 0.3),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(6.0)),
                            borderSide:
                                BorderSide(color: Colors.brown, width: 0.3),
                          ),
                          fillColor: Colors.white70,
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(6.0)),
                            borderSide:
                                BorderSide(color: Colors.brown, width: 0.3),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(6.0)),
                              borderSide:
                                  BorderSide(color: Colors.brown, width: 1.5)),
                          hintStyle: TextStyle(fontSize: 15),
                          labelStyle: TextStyle(
                              color: Colors.brown,
                              fontSize: 15.0,
                              fontWeight: FontWeight.normal),
                          labelText: "Description"),
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
