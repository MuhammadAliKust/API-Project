import 'package:flutter/cupertino.dart';

import '../models/user.dart';

class UserProvider extends ChangeNotifier{

  UserModel? _userModel;
  String? _token;

  //set User
void setUser(UserModel value){
  _userModel = value;
  notifyListeners();
}

  //set token
void setToken(String value){
  _token = value;
  notifyListeners();
}

//get User
UserModel getUser() => _userModel!;
String getToken() => _token!;
}