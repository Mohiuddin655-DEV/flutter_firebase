import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    final String? name,
    final String? email,
    final String? uid,
    final String? status,
    final String? password,
  }) : super(
          name: name,
          email: email,
          password: password,
          status: status,
          uid: uid,
        );

  factory UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    String name = snapshot.get("name");
    String email = snapshot.get("email");
    String password = snapshot.get("password");
    String status = snapshot.get("status");
    String uid = snapshot.get("uid");
    return UserModel(
      name: name,
      email: email,
      password: password,
      status: status,
      uid: uid,
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      "name": name,
      "email": email,
      "password": password,
      "status": status,
      "uid": uid
    };
  }
}
