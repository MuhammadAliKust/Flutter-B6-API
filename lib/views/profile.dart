import 'package:flutter/material.dart';
import 'package:flutter_b6_api/providers/user_provider.dart';
import 'package:flutter_b6_api/views/create_task.dart';
import 'package:flutter_b6_api/views/get_all_task.dart';
import 'package:flutter_b6_api/views/get_completed_task.dart';
import 'package:flutter_b6_api/views/get_in_completed_task.dart';
import 'package:flutter_b6_api/views/search_task.dart';
import 'package:provider/provider.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SearchTaskView()));
              },
              icon: Icon(Icons.search)),
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => GetAllTask()));
              },
              icon: Icon(Icons.task)),
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => GetCompletedTask()));
              },
              icon: Icon(Icons.circle)),
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => GetInCompletedTask()));
              },
              icon: Icon(Icons.incomplete_circle)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => CreateTaskView()));
        },
        child: Icon(Icons.add),
      ),
      body: Column(
        children: [
          Text(
            userProvider.getUser()!.user!.name.toString(),
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          Text(
            userProvider.getUser()!.user!.email.toString(),
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
