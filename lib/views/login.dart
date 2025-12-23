import 'package:api_project/providers/user__token_provider.dart';
import 'package:api_project/services/auth.dart';
import 'package:api_project/views/profile.dart';
import 'package:api_project/views/register.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Column(
        children: [
          TextField(controller: emailController,),
          TextField(controller: passwordController,),
          isLoading ? Center(child: CircularProgressIndicator(),)
              :ElevatedButton(onPressed: ()async{
                try{
                  await AuthServices().loginUser(
                      email: emailController.text,
                      password: passwordController.text)
                      .then((value)async{
                        userProvider.setToken(value!.token.toString());
                        await AuthServices()
                        .getProfile(value.token.toString())
                        .then((userDate){
                          showDialog(
                              context: context,
                            builder: (BuildContext context) {
                                return AlertDialog(
                                  content: Text("${userDate.user!.name.toString()} Logged in Successfully"),
                                  actions: [
                                    TextButton(onPressed: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=> Profile()));
                                    }, child: Text("Okay"))
                                  ],
                                );
                          },);
                        });
                  });
                }catch(e){
                  isLoading = false;
                  setState(() {});
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(e.toString())));
                }

          }, child: Text("Login")),

          TextButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> Register()));
          }, child: Text("Register"))
        ],
      ),
    );
  }
}
