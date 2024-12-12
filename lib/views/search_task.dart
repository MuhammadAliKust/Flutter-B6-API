import 'package:flutter/material.dart';
import 'package:flutter_b6_api/models/task_list.dart';
import 'package:flutter_b6_api/providers/user_provider.dart';
import 'package:flutter_b6_api/services/task.dart';
import 'package:provider/provider.dart';

class SearchTaskView extends StatefulWidget {
  const SearchTaskView({super.key});

  @override
  State<SearchTaskView> createState() => _SearchTaskViewState();
}

class _SearchTaskViewState extends State<SearchTaskView> {
  TextEditingController searchController = TextEditingController();
  bool isLoading = false;
  TaskListModel? taskListModel;

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Search Task"),
      ),
      body: Column(
        children: [
          TextField(
            controller: searchController,
            onChanged: (val) {
              try {
                isLoading = true;
                setState(() {});
                TaskServices()
                    .searchTask(
                        token: userProvider.getToken().toString(),
                        searchKey: searchController.text)
                    .then((val) {
                  isLoading = false;
                  taskListModel = val;
                  setState(() {});
                });
              } catch (e) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(e.toString())));
              }
            },
          ),
          if (isLoading == true) CircularProgressIndicator(),
          if (taskListModel != null)
            Expanded(
                child: ListView.builder(
                    itemCount: taskListModel!.tasks!.length,
                    itemBuilder: (context, i) {
                      return ListTile(
                        leading: Icon(Icons.task),
                        title: Text(
                            taskListModel!.tasks![i].description.toString()),
                        subtitle:
                            Text(taskListModel!.tasks![i].createdAt.toString()),
                      );
                    }))
        ],
      ),
    );
  }
}
