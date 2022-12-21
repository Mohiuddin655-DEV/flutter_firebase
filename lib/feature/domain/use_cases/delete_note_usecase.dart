import '../entities/base_entity.dart';
import '../repositories/firebase_repository.dart';

class DeleteNoteUseCase {
  final FirebaseRepository repository;

  DeleteNoteUseCase({
    required this.repository,
  });

  Future<void> call(BaseEntity entity) async {
    return repository.delete(entity);
  }
}
