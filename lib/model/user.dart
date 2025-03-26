//가입유저정보
//command + N -> constructor
import 'package:flutter/cupertino.dart';

class UserModel {
  int? id;
  String? profileUrl;
  String name;
  String email;
  String introduce;
  String uid;
  DateTime? createdAt;

  UserModel({
    this.id,
    this.profileUrl,
    required this.name,
    required this.email,
    required this.introduce,
    required this.uid,
    this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'profile_url': profileUrl,
      'name': name,
      'email': email,
      'introduce': introduce,
    };
  }

  factory UserModel.fromJson(Map<dynamic, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      introduce: json['introduce'],
      uid: json['uid'],
      profileUrl: json['profile_url'],
      createdAt: DateTime.parse(json['created_at']),

    );
  }
}
