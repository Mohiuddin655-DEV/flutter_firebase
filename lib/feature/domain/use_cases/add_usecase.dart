import '../entities/base_entity.dart';
import '../repositories/firebase_repository.dart';

class AddNoteUseCase {
  final FirebaseRepository repository;

  AddNoteUseCase({
    required this.repository,
  });

  Future<void> call(BaseEntity entity) async {
    return repository.add(entity);
  }
}
