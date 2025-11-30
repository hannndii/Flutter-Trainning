import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final CollectionReference users = FirebaseFirestore.instance.collection(
    'users',
  );
  // CREATE
  Future<void> addUser(String name, String desc) {
    return users.add({'name': name, 'desc': desc});
  }

  // READ (real-time)
  Stream<QuerySnapshot> getUsers() {
    return users.snapshots();
  }

  // UPDATE
  Future<void> updateUser(String id, String name, String desc) {
    return users.doc(id).update({'name': name, 'desc': desc});
  }

  // DELETE
  Future<void> deleteUser(String id) {
    return users.doc(id).delete();
  }
}
