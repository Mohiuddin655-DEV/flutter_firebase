import 'package:firebase_auth/firebase_auth.dart';

import '../repositories/firebase_repository.dart';

class SignUpUseCase {
  final FirebaseRepository repository;

  SignUpUseCase({
    required this.repository,
  });

  Future<UserCredential> call({
    required String email,
    required String password,
  }) async {
    return repository.signUp(email: email, password: password);
  }
}
