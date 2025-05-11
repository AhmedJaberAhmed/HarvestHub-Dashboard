import 'package:cloud_firestore/cloud_firestore.dart';
import 'DatabaseService.dart';

class FireStoreService implements DatabaseService {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  @override
  Future<void> addData(
      {required String path,
      required Map<String, dynamic> data,
      String? documentId}) async {
    if (documentId != null) {
      await firebaseFirestore.collection(path).doc(documentId).set(data);
    } else {
      await firebaseFirestore.collection(path).add(data);
    }
  }

  @override
  Future<dynamic> getData(
      {required String path,
      String? documentId,
      Map<String, dynamic>? query}) async {
    if (documentId != null) {
      var data = await firebaseFirestore.collection(path).doc(documentId).get();
      return data.data();
    } else {
      Query<Map<String, dynamic>> data = firebaseFirestore.collection(path);
      if (query != null) {
        if (query['orderBy'] != null) {
          var orderByField = query['orderBy'];
          var descending = query['descending'];
          data = data.orderBy(orderByField, descending: descending);
        }
        if (query['limit'] != null) {
          var limit = query['limit'];
          data = data.limit(limit);
        }
      }

      var result = await data.get();
      return result.docs.map((e) => e.data()).toList();
    }
  }

  @override
  Future<bool> checkIfDataExists(
      {required String path, required String documentId}) async {
    var data = await firebaseFirestore.collection(path).doc(documentId).get();
    return data.exists;
  }

  @override
  Stream streamData(
      {required String path,   Map<String, dynamic>? query}) async* {
    Query<Map<String, dynamic>> data = firebaseFirestore.collection(path);
    if (query != null) {
      if (query['orderBy'] != null) {
        var orderByField = query['orderBy'];
        var descending = query['descending'];
        data = data.orderBy(orderByField, descending: descending);
      }
      if (query['limit'] != null) {
        var limit = query['limit'];
        data = data.limit(limit);
      }
    }

    await for (var result in data.snapshots()) {
      yield result.docs.map((e) => e.data()).toList();
    }

  }

  @override
  Future<void> updateData({required String path, required Map<String, dynamic> data, String? documentId}) async{
     await firebaseFirestore.collection(path).doc(documentId).update(data);
  }
}
