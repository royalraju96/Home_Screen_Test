import 'package:flutter/material.dart';

class LoginRequestModel {
  String userName;
  String password;

  LoginRequestModel({
    @required this.userName,
    @required this.password,
  });

  Map<String, dynamic> get toJson =>
      {"user_name": userName, "password": password};
}
