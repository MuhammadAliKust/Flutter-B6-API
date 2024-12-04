// To parse this JSON data, do
//
//     final loginResponseModel = loginResponseModelFromJson(jsonString);

import 'dart:convert';

LoginResponseModel loginResponseModelFromJson(String str) => LoginResponseModel.fromJson(json.decode(str));

String loginResponseModelToJson(LoginResponseModel data) => json.encode(data.toJson());

class LoginResponseModel {
  final String? token;
  final String? message;
  final bool? status;

  LoginResponseModel({
    this.token,
    this.message,
    this.status,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) => LoginResponseModel(
    token: json["token"],
    message: json["message"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "token": token,
    "message": message,
    "status": status,
  };
}
