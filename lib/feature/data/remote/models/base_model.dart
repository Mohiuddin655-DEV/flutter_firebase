import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../domain/entities/base_entity.dart';

class BaseModel extends BaseEntity {
  BaseModel({
    final String? note,
    final String? noteId,
    final Timestamp? time,
    final String? uid,
  }) : super(
          note: note,
          noteId: noteId,
          time: time,
          uid: uid,
        );

  factory BaseModel.fromSnapshot(DocumentSnapshot snapshot) {
    final String note = snapshot.get("note");
    final String noteId = snapshot.get("noteId");
    final Timestamp time = snapshot.get("time");
    final String uid = snapshot.get("uid");
    return BaseModel(
      noteId: noteId,
      note: note,
      time: time,
      uid: uid,
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      "noteId": noteId,
      "note": note,
      "time": time,
      "uid": uid,
    };
  }
}
