import 'dart:convert';

import 'package:flutter_b6_api/models/task.dart';
import 'package:flutter_b6_api/models/task_list.dart';
import 'package:http/http.dart' as http;

class TaskServices {
  String baseUrl = "https://todo-nu-plum-19.vercel.app";

  ///Create Task
  Future<TaskModel> createTask(
      {required String description, required String token}) async {
    http.Response response = await http.post(Uri.parse('$baseUrl/todos/add'),
        headers: {'Content-Type': 'application/json', 'Authorization': token},
        body: jsonEncode({"description": "first task"}));

    if (response.statusCode == 200 || response.statusCode == 201) {
      return TaskModel.fromJson(jsonDecode(response.body));
    } else {
      throw response.reasonPhrase.toString();
    }
  }

  ///Get All Task
  Future<TaskListModel> getAllTask(String token) async {
    http.Response response = await http.get(Uri.parse('$baseUrl/todos/get'),
        headers: {'Authorization': token});

    if (response.statusCode == 200 || response.statusCode == 201) {
      return TaskListModel.fromJson(jsonDecode(response.body));
    } else {
      throw response.reasonPhrase.toString();
    }
  }
}
