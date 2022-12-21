import '../entities/user_entity.dart';
import '../repositories/firebase_repository.dart';

class CreateUserUseCase {
  final FirebaseRepository repository;

  CreateUserUseCase({
    required this.repository,
  });

  Future<void> call(UserEntity entity) async {
    return repository.createUser(entity);
  }
}
