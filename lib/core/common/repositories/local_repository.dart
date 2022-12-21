import '../responses/local_response.dart';

abstract class LocalRepository {
  bool isAvailable(String key, List<dynamic>? list);

  Future<bool?> alreadyAdded({
    required String collectionKey,
    required String documentKey,
  });

  Future<LocalResponse<List<dynamic>>> insert({
    required String path,
    required String key,
    required dynamic data,
  });

  Future<LocalResponse<List<dynamic>>> remove({
    required String path,
    required String key,
    required dynamic data,
  });

  Future<LocalResponse<List<dynamic>>> getCollection({
    required String collectionKey,
  });

  Future<LocalResponse<List<dynamic>>> setCollection({
    required String collectionKey,
    required List<dynamic> collection,
  });

  Future<LocalResponse<void>> clear({
    required String collectionKey,
  });
}
