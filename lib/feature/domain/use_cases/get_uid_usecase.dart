import '../repositories/firebase_repository.dart';

class GetUidUseCase {
  final FirebaseRepository repository;

  GetUidUseCase({
    required this.repository,
  });

  Future<String> call() async {
    return repository.getUid();
  }
}
