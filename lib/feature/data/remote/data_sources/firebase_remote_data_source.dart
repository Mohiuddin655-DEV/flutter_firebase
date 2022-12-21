import 'package:firebase_auth/firebase_auth.dart';

import '../../../domain/entities/base_entity.dart';
import '../../../domain/entities/user_entity.dart';

abstract class FirebaseRemoteDataSource {
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

  Future<void> createUser(UserEntity entity);

  Future<void> add(BaseEntity entity);

  Future<void> update(BaseEntity entity);

  Future<void> delete(BaseEntity entity);

  Stream<List<BaseEntity>> gets(String uid);
}
