import '../entities/base_entity.dart';
import '../repositories/firebase_repository.dart';

class GetNotesUseCase {
  final FirebaseRepository repository;

  GetNotesUseCase({
    required this.repository,
  });

  Stream<List<BaseEntity>> call(String uid) {
    return repository.gets(uid);
  }
}
