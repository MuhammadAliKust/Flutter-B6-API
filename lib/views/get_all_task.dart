import 'package:flutter/material.dart';
import 'package:flutter_b6_api/models/task_list.dart';
import 'package:flutter_b6_api/providers/user_provider.dart';
import 'package:flutter_b6_api/services/task.dart';
import 'package:flutter_b6_api/views/update_task.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';

class GetAllTask extends StatefulWidget {
  const GetAllTask({super.key});

  @override
  State<GetAllTask> createState() => _GetAllTaskState();
}

class _GetAllTaskState extends State<GetAllTask> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
    return LoadingOverlay(
      isLoading: isLoading,
      progressIndicator: CircularProgressIndicator(),
      child: Scaffold(
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
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                                onPressed: () async {
                                  isLoading = true;
                                  setState(() {});
                                  await TaskServices()
                                      .deleteTask(
                                          token: userProvider
                                              .getToken()
                                              .toString(),
                                          taskID:
                                              taskList.tasks![i].id.toString())
                                      .then((val) {
                                    isLoading = false;
                                    setState(() {});
                                  });
                                },
                                icon: Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                )),
                            IconButton(
                                onPressed: () async {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => UpdateTaskView(
                                              model: taskList.tasks![i]))).then(
                                      (val) {
                                    setState(() {});
                                  });
                                },
                                icon: Icon(
                                  Icons.edit,
                                  color: Colors.blue,
                                )),
                          ],
                        ),
                      );
                    });
          },
        ),
      ),
    );
  }
}
