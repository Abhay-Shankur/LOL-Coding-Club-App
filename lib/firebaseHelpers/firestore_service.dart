import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FirestoreConst {
  static String appDataCollection = "App Data";
  static String notificationCollection = "Notification";
  static String eventCollection = "Events";
  static String userCollection = "Users";
  static String attendanceCollection = "Attendance";


}

class FirestoreService {
  late FirebaseFirestore _firestore;

  FirestoreService(String name) {
    _firestore  = FirebaseFirestore.instance;
    debugPrint("Firestore connection created : $name");
  }

  Future<void> closeConnection(String name) async {
    await _firestore.terminate();
    debugPrint('Firestore connection closed : $name');
  }

  // Get Document Names from a Collection/Path
  Future<List<String>> getDocumentNames(String collectionPath) async {
    try {
      QuerySnapshot querySnapshot = await _firestore.collection(collectionPath).get();
      List<String> documentNames = querySnapshot.docs.map((doc) => doc.id).toList();
      return documentNames;
    } catch (e) {
      debugPrint("Error getting document names: $e");
      return [];
    }
  }

  // Get Document from a Collection/Path
  Future<Map<String, dynamic>?> getDocument(String collectionPath, String documentId) async {
    try {
      DocumentSnapshot documentSnapshot = await _firestore.collection(collectionPath).doc(documentId).get();
      if (documentSnapshot.exists) {
        return documentSnapshot.data() as Map<String, dynamic>?;
      } else {
        debugPrint("Document does not exist");
        return null;
      }
    } catch (e) {
      debugPrint("Error getting document: $e");
      return null;
    }
  }

  // Insert/Merge Value at a Path
  Future<void> insertOrUpdateDocument(String collectionPath, String documentId, Map<String, dynamic> data) async {
    try {
      await _firestore.collection(collectionPath).doc(documentId).set(data, SetOptions(merge: true));
      debugPrint("Document successfully inserted/updated");
    } catch (e) {
      debugPrint("Error inserting/updating document: $e");
    }
  }

  // Remove Value from a Path
  Future<void> removeDocument(String collectionPath, String documentId) async {
    try {
      await _firestore.collection(collectionPath).doc(documentId).delete();
      debugPrint("Document successfully deleted");
    } catch (e) {
      debugPrint("Error deleting document: $e");
    }
  }

  Future<void> addToSubCollections(String collection, String doc, String subColl, String docName, var data) async {
    try {
      await _firestore.collection(collection)
          .doc(doc)
          .collection(subColl)
          .doc(docName)
          .set(data, SetOptions(merge: true));
    } catch(e) {
      debugPrint("Error addToSubCollections: $e");
    }
  }

  Future<void> addToList(String path, String doc, String key, var data) async {

    try {
      final documentReference = _firestore.collection(path).doc(doc);

      await documentReference.update({
        key: FieldValue.arrayUnion([data]),
      });

      debugPrint('List added successfully');
    } catch (e) {
      debugPrint('Error adding List: $e');
    }
  }

  Future<void> addTokenToNotification(var token) async {

    try {
      final documentReference = _firestore.collection('Notification').doc('DeviceIds');

      await documentReference.update({
        'members': FieldValue.arrayUnion([token]),
      });

      debugPrint('Token added successfully');
    } catch (e) {
      debugPrint('Error adding token: $e');
    }
  }

  Future<void> removeTokenFromNotification(String token) async {

    try {
      final documentReference = _firestore.collection('Notification').doc('DeviceIds');

      await documentReference.update({
        'members': FieldValue.arrayRemove([token]),
      });

      debugPrint('Token removed successfully');
    } catch (e) {
      debugPrint('Error removing token: $e');
    }
  }
}
