import 'package:api_project/providers/user__token_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: Column(children: [
        Text("NAME : ${userProvider.getUser().user!.name.toString()}"),
        Text("EMAIL : ${userProvider.getUser().user!.email.toString()}"),
        ElevatedButton(onPressed: (){}, child: Text("Update Profile"))
      ],),
    );
  }
}
