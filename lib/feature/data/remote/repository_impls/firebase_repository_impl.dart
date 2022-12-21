import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase/feature/domain/entities/base_entity.dart';

import '../../../domain/entities/user_entity.dart';
import '../../../domain/repositories/firebase_repository.dart';
import '../../remote/data_sources/firebase_remote_data_source.dart';

class FirebaseRepositoryImpl extends FirebaseRepository {
  final FirebaseRemoteDataSource source;

  FirebaseRepositoryImpl({
    required this.source,
  });

  @override
  Future<void> add(BaseEntity note) => source.add(note);

  @override
  Future<void> delete(BaseEntity note) => source.delete(note);

  @override
  Future<void> createUser(UserEntity user) => source.createUser(user);

  @override
  Future<String> getUid() => source.getUid();

  @override
  Stream<List<BaseEntity>> gets(String uid) => gets(uid);

  @override
  Future<bool> isSignIn() => source.isSignIn();

  @override
  Future<UserCredential> signIn({
    required String email,
    required String password,
  }) => source.signIn(email: email, password: password);

  @override
  Future<void> signOut() => source.signOut();

  @override
  Future<UserCredential> signUp({
    required String email,
    required String password,
  }) => source.signUp(email: email, password: password);

  @override
  Future<void> update(BaseEntity note) => source.update(note);
}
