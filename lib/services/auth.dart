import 'dart:convert';

import 'package:api_project/models/login.dart';
import 'package:api_project/models/register.dart';
import 'package:api_project/models/user.dart';
import 'package:http/http.dart' as http;

class AuthServices {
  String baseURL = "https://todo-nu-plum-19.vercel.app/";

  ///Register
  Future<RegisterModel> registerUser({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      http.Response response = await http.post(
        Uri.parse("$baseURL/users/register"),
          headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'name': name, 'email': email, 'password': password}),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return RegisterModel.fromJson(jsonDecode(response.body));
      } else {
        throw response.body.toString();
      }
    } catch (e) {
      throw e.toString();
    }
  }

  ///Login
  Future<LoginModel> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      http.Response response = await http.post(
        Uri.parse("$baseURL/users/login"),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return LoginModel.fromJson(jsonDecode(response.body));
      } else {
        throw response.body.toString();
      }
    } catch (e) {
      throw e.toString();
    }
  }

  ///Get Profile
  Future<UserModel> getProfile(String token) async {
    try {
      http.Response response = await http.get(
        Uri.parse("$baseURL/users/profile"),
        headers: {'Authorization': token},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return UserModel.fromJson(jsonDecode(response.body));
      } else {
        throw response.body.toString();
      }
    } catch (e) {
      throw e.toString();
    }
  }

  ///Update Profile
  Future<bool> updateProfile({
    required String name,
    required String token,
  }) async {
    try {
      http.Response response = await http.put(
        Uri.parse("$baseURL/users/profile"),
        headers: {'Authorization': token, 'Content-Type': 'application/json'},
        body: jsonEncode({'name': name}),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        throw response.body.toString();
      }
    } catch (e) {
      throw e.toString();
    }
  }
}
