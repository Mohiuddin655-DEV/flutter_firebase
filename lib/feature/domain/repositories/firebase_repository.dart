import 'package:firebase_auth/firebase_auth.dart';

import '../entities/base_entity.dart';
import '../entities/user_entity.dart';

abstract class FirebaseRepository {
  Future<bool> isSignIn();

  Future<UserCredential> signIn({
    required String email,
    required String password,
  });

  Future<UserCredential> signUp({
    required String email,
    required String password,
  });

  Future<void> signOut();

  Future<String> getUid();

  Future<void> createUser(UserEntity user);

  Future<void> add(BaseEntity note);

  Future<void> update(BaseEntity note);

  Future<void> delete(BaseEntity note);

  Stream<List<BaseEntity>> gets(String uid);
}
