import 'package:firebase_auth/firebase_auth.dart';

import '../repositories/firebase_repository.dart';

class SignInUseCase {
  final FirebaseRepository repository;

  SignInUseCase({
    required this.repository,
  });

  Future<UserCredential> call({
    required String email,
    required String password,
  }) async {
    return repository.signIn(email: email, password: password);
  }
}
