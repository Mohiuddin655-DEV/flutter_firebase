import '../responses/local_response.dart';

abstract class LocalDataSource {
  bool isAvailable(String key, List<dynamic>? list);

  Future<bool?> availabilityCheck({
    required String path,
    required String key,
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
    required String path,
  });

  Future<LocalResponse<List<dynamic>>> setCollection({
    required String path,
    required List<dynamic> data,
  });

  Future<LocalResponse<void>> clear({
    required String path,
  });
}
