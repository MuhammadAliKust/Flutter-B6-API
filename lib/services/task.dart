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

  ///Update Task
  Future<TaskModel> updateTask(
      {required String description,
      required String token,
      required String taskID}) async {
    http.Response response = await http.patch(
        Uri.parse('$baseUrl/todos/update/$taskID'),
        headers: {'Content-Type': 'application/json', 'Authorization': token},
        body: jsonEncode({"description": description, "complete": false}));

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

  ///Get Completed Task
  Future<TaskListModel> getCompletedTask(String token) async {
    http.Response response = await http.get(
        Uri.parse('$baseUrl/todos/completed'),
        headers: {'Authorization': token});

    if (response.statusCode == 200 || response.statusCode == 201) {
      return TaskListModel.fromJson(jsonDecode(response.body));
    } else {
      throw response.reasonPhrase.toString();
    }
  }

  ///Get InCompleted Task
  Future<TaskListModel> getInCompletedTask(String token) async {
    http.Response response = await http.get(
        Uri.parse('$baseUrl/todos/incomplete'),
        headers: {'Authorization': token});

    if (response.statusCode == 200 || response.statusCode == 201) {
      return TaskListModel.fromJson(jsonDecode(response.body));
    } else {
      throw response.reasonPhrase.toString();
    }
  }

  ///Search Task
  Future<TaskListModel> searchTask(
      {required String token, required String searchKey}) async {
    http.Response response = await http.get(
        Uri.parse('$baseUrl/todos/search?keywords=$searchKey'),
        headers: {'Authorization': token});

    if (response.statusCode == 200 || response.statusCode == 201) {
      return TaskListModel.fromJson(jsonDecode(response.body));
    } else {
      throw response.reasonPhrase.toString();
    }
  }

  ///Delete Task
  Future<bool> deleteTask(
      {required String token, required String taskID}) async {
    http.Response response = await http.delete(
        Uri.parse('$baseUrl/todos/delete/$taskID'),
        headers: {'Authorization': token});

    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else {
      throw response.reasonPhrase.toString();
    }
  }
}
