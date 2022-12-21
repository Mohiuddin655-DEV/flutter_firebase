import '../entities/base_entity.dart';
import '../repositories/firebase_repository.dart';

class UpdateNoteUseCase {
  final FirebaseRepository repository;

  UpdateNoteUseCase({
    required this.repository,
  });

  Future<void> call(BaseEntity entity) async {
    return repository.update(entity);
  }
}
