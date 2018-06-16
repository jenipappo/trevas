import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:trevas/model/Model.dart';
import 'package:trevas/repository/serialization/DocumentSerializer.dart';

abstract class Repository<T extends Model> {

  final CollectionReference collection;

  Repository(this.collection);

  Stream<List<T>> get stream {
    return collection.snapshots().map((snapshot) {
      var serializer = DocumentSerializer<T>();
      return snapshot.documents
          .map((document) => serializer.deserializeFromSnapshot(document))
          .toList();
    });
  }

  Future<T> findById(String id) async {
    var snapshot = await collection.document(id).get();
    if (snapshot.data == null) throw NotFoundException();
    return DocumentSerializer<T>().deserializeFromSnapshot(snapshot);
  }

  Future<T> create(T model) async {
    var documentReference = await collection.add(DocumentSerializer<T>().serialize(model));
    return DocumentSerializer<T>().deserializeFromSnapshot(await documentReference.get());
  }

  Future<void> update(T model) async {
    return await collection
        .document(model.id)
        .updateData(DocumentSerializer<T>().serialize(model));
  }

  Future<void> delete(T model) async {
    return await collection
        .document(model.id)
        .delete();
  }
}

class NotFoundException implements Exception { }