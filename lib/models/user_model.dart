// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModel {
  String uid;
  String userName;
  String email;
  String img;

  UserModel(
    this.uid,
    this.userName,
    this.email,
    this.img,
  );

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'uid': uid,
      'name': userName,
      'email': email,
      'img': img,
    };
  }

// bind Json data to user model
  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(
      map['uid'] as String,
      map['userName'] as String,
      map['email'] as String,
      map['img'] as String,
    );
  }
}
