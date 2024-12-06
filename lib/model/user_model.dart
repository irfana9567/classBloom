import 'package:cloud_firestore/cloud_firestore.dart';
UserModel? currentUser;
String currentUserId="";

class UserModel{
  String userName;
  String email;
  String password;
  String id;
  DocumentReference? reference;
  UserModel({
    required this.userName,
    required this.email,
    required this.password,
    required this.id,
    required this.reference,
  });

  Map<String,dynamic> toMap(){
    return{
      'userName':this.userName,
      'email':this.email,
      'password':this.password,
      'id':this.id,
      'reference':this.reference,
    };
  }
  factory UserModel.fromMap(Map<String,dynamic>map){
    return UserModel(
      userName: map['userName']??"",
      email: map['email']??"",
      password: map['password']??"",
      id: map['id']??"",
      reference: map['reference']??"",
    );
  }

  UserModel copyWith({
    String? userName,
    String? name,
    String? bio,
    String? gender,
    String? password,
    String? email,
    String? id,
    String? profile,
    List<dynamic>?following,
    List<dynamic>? followers,
    List<dynamic>? fcmToken,
    List? search,
    DocumentReference? reference,
  }){
    return UserModel(
      userName: userName ?? this.userName,
      email: email ?? this.email,
      password: password ?? this.password,
      id: id ?? this.id,
      reference: reference ?? this.reference,
    );
  }
}