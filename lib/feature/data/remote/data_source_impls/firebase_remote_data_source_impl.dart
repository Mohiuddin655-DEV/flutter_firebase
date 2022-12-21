import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../domain/entities/base_entity.dart';
import '../../../domain/entities/user_entity.dart';
import '../data_sources/firebase_remote_data_source.dart';
import '../models/base_model.dart';
import '../models/user_model.dart';

class FirebaseRemoteDataSourceImpl implements FirebaseRemoteDataSource {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  final notes = "notes";
  final users = "users";

  FirebaseRemoteDataSourceImpl({
    required this.auth,
    required this.firestore,
  });

  @override
  Future<bool> isSignIn() async => auth.currentUser?.uid != null;

  @override
  Future<UserCredential> signIn({
    required String email,
    required String password,
  }) async {
    return auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  @override
  Future<void> signOut() async => auth.signOut();

  @override
  Future<UserCredential> signUp({
    required String email,
    required String password,
  }) async {
    return auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  @override
  Future<void> createUser(UserEntity entity) async {
    final reference = firestore.collection(users);

    final uid = await getUid();

    reference.doc(entity.uid).get().then((value) {
      final currentValue = UserModel(
        uid: uid,
        status: entity.status,
        email: entity.email,
        name: entity.name,
      ).toDocument();

      if (!value.exists) {
        reference.doc(uid).set(currentValue);
      }
      return;
    });
  }

  @override
  Future<String> getUid() async => auth.currentUser!.uid;

  @override
  Future<void> add(BaseEntity entity) async {
    final reference =
        firestore.collection(users).doc(entity.uid).collection(notes);
    final noteId = reference.doc().id;

    reference.doc(noteId).get().then((value) {
      final currentValue = BaseModel(
        uid: entity.uid,
        note: entity.note,
        noteId: entity.noteId,
        time: entity.time,
      ).toDocument();

      if (!value.exists) {
        reference.doc(noteId).set(currentValue);
      }
      return;
    });
  }

  @override
  Future<void> update(BaseEntity entity) async {
    Map<String, dynamic> map = {};
    final reference =
        firestore.collection(users).doc(entity.uid).collection(notes);

    if (entity.note != null) map["note"] = entity.note;
    if (entity.time != null) map["time"] = entity.time;

    reference.doc(entity.noteId).update(map);
  }

  @override
  Future<void> delete(BaseEntity entity) async {
    final reference =
        firestore.collection(users).doc(entity.uid).collection(notes);

    reference.doc(entity.noteId).get().then((value) {
      if (value.exists) {
        reference.doc(entity.noteId).delete();
      }
      return;
    });
  }

  @override
  Stream<List<BaseEntity>> gets(String uid) {
    final reference = firestore.collection(users).doc(uid).collection(notes);
    return reference.snapshots().map((event) {
      return event.docs.map((e) => BaseModel.fromSnapshot(e)).toList();
    });
  }
}
