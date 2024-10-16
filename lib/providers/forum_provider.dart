
import 'package:app/firebaseHelpers/firestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart';

class ForumProvider extends ChangeNotifier {

  static final ForumProvider _instance = ForumProvider._internal();
  factory ForumProvider() => _instance;

  ForumProvider._internal();

  List<Message> messageList = [];

  bool initialize() {
    try{
      FirebaseFirestore.instance
          .collection('${FirestoreConst.appDataCollection}/forums/#announcements')
          .orderBy('createdAt', descending: true)
          .snapshots()
          .listen((snapshot) {
            final messages = snapshot.docs.map((doc) {
              final data = doc.data();
              return Message.fromJson(data);
            }).toList();
            messageList.clear();
            messageList.addAll(messages);
          });
      return true;
    } catch(e) {
      debugPrint("Exception Initializing $this: $e");
      return false;
    }
  }

  Future<void> stackMessage(Message message) async {
    try {
      await _saveMessageToFirestore(message);
      messageList.insert(0, message);
    } catch(e) {
      debugPrint("Exception in stacking Message $this: $e");
    }
  }

  Future<void> _saveMessageToFirestore(Message message)  async {
    FirebaseFirestore.instance
        .collection('${FirestoreConst.appDataCollection}/forums/#announcements')
        .doc(message.id)  // Set the custom document name here
        .set(message.toJson());

    // DocumentReference docRef = FirebaseFirestore.instance
    //     .collection('${FirestoreConst.appDataCollection}/forums/#announcements')
    //     .doc(message.id);
    //
    // for (int i = 1; i<=3; i++) {
    //   var status = _checkDocsExists(docRef);
    //   if (!status) {
    //     await docRef.set(message.toJson());
    //     debugPrint("Document created successfully.");
    //     return;
    //   } else {
    //     debugPrint("Document already exists. Attempt ${i + 1} of 3");
    //     message.id;
    //   }
    // }
  }

  void removeMessage(Message message) {
    try {
      FirebaseFirestore.instance
          .collection('${FirestoreConst.appDataCollection}/forums/#announcements')
          .doc(message.id)
          .delete();
      messageList.removeWhere((element) => element.id==message.id);
    } catch(e) {
      debugPrint("Exception in removing Message $this: $e");
    }
  }
}