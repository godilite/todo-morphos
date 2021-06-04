import 'package:crud_firebase/models/task.dart';
import 'package:crud_firebase/viewmodels/completed_task_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class CompletedTaskScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CompletedTaskViewModel>.reactive(
        viewModelBuilder: () => CompletedTaskViewModel(),
        builder: (context, model, snapshot) {
          List<Task> tasks = model.completedTask;

          return Scaffold(
            appBar: AppBar(
              title: Text("Completed Task"),
              brightness: Brightness.dark,
            ),
            body: tasks.length == 0
                ? Center(
                    child: Text(
                      "No Completed Task ",
                      style: TextStyle(fontSize: 15),
                    ),
                  )
                : ListView.separated(
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 10.0),
                    itemCount: tasks.length,
                    itemBuilder: (context, index) {
                      final Task task = tasks[index];
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                              flex: 2,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      task.title,
                                      style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Text(task.desc,
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w400))
                                  ])),
                        ],
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return Divider();
                    },
                  ),
          );
        });
  }
}
