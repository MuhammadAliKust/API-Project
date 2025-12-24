import 'package:api_project/models/taskListing.dart';
import 'package:api_project/services/task.dart';
import 'package:api_project/views/create_task.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/user__token_provider.dart';

class GetAllTask extends StatelessWidget {
  const GetAllTask({super.key});

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Get All Task"),
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>CreateTask()));
      }),
      body: FutureProvider.value(
          value: TaskServices().getAllTask(token: userProvider.getToken().toString()),
          initialData: [TaskListingModel()],
        builder: (context, child){
            TaskListingModel taskListingList = context.watch<TaskListingModel>();
            return
              taskListingList.tasks == null ?
                  Center(child: CircularProgressIndicator(),):
              ListView.builder(itemBuilder: (BuildContext context, int index) {
              return ListTile(
                leading: Icon(Icons.task),
                title: Text(taskListingList.tasks![index].description.toString()),
                trailing: Icon(Icons.arrow_forward),
              );
            },);
        },
      ),
    );
  }
}
