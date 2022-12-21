import 'dart:convert';

import 'package:flutter_firebase/core/common/models/local_base_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:validators/validators.dart' as validator;

import '../data_sources/local_data_source.dart';
import '../responses/local_response.dart';

class LocalDataSourceImpl extends LocalDataSource {
  final SharedPreferences db;

  LocalDataSourceImpl({
    required this.db,
  });

  @override
  bool isAvailable(String key, List<dynamic>? list) {
    if (list != null && list.isNotEmpty) {
      for (var value in list) {
        if (value is LocalBaseModel && validator.equals(key, value.id)) {
          return true;
        }
      }
      return false;
    } else {
      return false;
    }
  }

  @override
  Future<bool?> availabilityCheck({
    required String path,
    required String key,
  }) async {
    final response = await getCollection(path: path);
    return isAvailable(path, response.result);
  }

  @override
  Future<LocalResponse<List<dynamic>>> insert({
    required String path,
    required String key,
    required dynamic data,
  }) async {
    final response = await getCollection(path: path);
    final list = response.result ?? [];
    final isInsertable = !isAvailable(key, list);
    if (isInsertable) {
      list.add(data);
      final request = await setCollection(path: path, data: list);
      return response.copyWith(result: request.result);
    } else {
      return response.copyWith(error: "Already data added!");
    }
  }

  @override
  Future<LocalResponse<List<dynamic>>> remove({
    required String path,
    required String key,
    required dynamic data,
  }) async {
    final response = await getCollection(path: path);
    final list = response.result ?? [];
    for (int index = 0; index < list.length; index++) {
      final x = list[index];
      if (validator.equals(key, x.courseId)) {
        list.removeAt(index);
      }
    }
    final request = await setCollection(path: path, data: list);
    return response.copyWith(result: request.result);
  }

  @override
  Future<LocalResponse<List<dynamic>>> getCollection({
    required String path,
  }) async {
    const response = LocalResponse<List<dynamic>>();
    try {
      final source = db.getString(path);
      if (source != null) {
        final json = jsonDecode(source) as List;
        final list = [];
        json.map((e) => list.add(e));
        return response.copyWith(result: list);
      } else {
        return response.copyWith(error: "Data not found!");
      }
    } catch (e) {
      return response.copyWith(error: "Failed to load data!");
    }
  }

  @override
  Future<LocalResponse<List<dynamic>>> setCollection({
    required String path,
    required List<dynamic>? data,
  }) async {
    const response = LocalResponse<List<dynamic>>();
    try {
      if (data != null) {
        final currentMap = data.map((e) => e.toMap()).toList();
        final String value = jsonEncode(currentMap);
        final saved = await db.setString(path, value);
        return response.copyWith(result: data, isSuccessful: saved);
      } else {
        return response.copyWith(error: "Data not valid!");
      }
    } catch (_) {
      return response.copyWith(error: "Failed to upload data!");
    }
  }

  @override
  Future<LocalResponse<void>> clear({
    required String path,
  }) async {
    const response = LocalResponse();
    try {
      final isSaved = await db.remove(path);
      return response.copyWith(result: null, isSuccessful: isSaved);
    } catch (_) {
      return response.copyWith(error: "Failed to clean data!");
    }
  }
}
