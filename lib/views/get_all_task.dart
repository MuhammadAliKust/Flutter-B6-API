import 'package:flutter/material.dart';
import 'package:flutter_b6_api/models/task_list.dart';
import 'package:flutter_b6_api/providers/user_provider.dart';
import 'package:flutter_b6_api/services/task.dart';
import 'package:provider/provider.dart';

class GetAllTask extends StatelessWidget {
  const GetAllTask({super.key});

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Get All Task"),
      ),
      body: FutureProvider.value(
        value: TaskServices().getAllTask(userProvider.getToken().toString()),
        initialData: TaskListModel(),
        builder: (context, child) {
          TaskListModel taskList = context.watch<TaskListModel>();
          return taskList.count == null
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  itemCount: taskList.tasks!.length,
                  itemBuilder: (context, i) {
                    return ListTile(
                      leading: Icon(Icons.task),
                      title: Text(taskList.tasks![i].description.toString()),
                      subtitle: Text(taskList.tasks![i].createdAt.toString()),
                    );
                  });
        },
      ),
    );
  }
}
