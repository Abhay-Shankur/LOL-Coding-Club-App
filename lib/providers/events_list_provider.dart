

import 'dart:convert';

import 'package:app/firebaseHelpers/auth_service.dart';
import 'package:app/firebaseHelpers/firestore_service.dart';
import 'package:flutter/material.dart';

class Event {
  late String? _id;
  late String? image;
  late String? title;
  late String? description;
  late String? formLink;
  late String? sheetId;
  late String? location;
  late String? dateTime;
  late String? speakers;

  Event();


  String? get id => _id;

  void generateId(){
    DateTime datetime = DateTime.parse(dateTime!);
    _id = "${datetime.year}-${datetime.month}-${datetime.day}-$title";
  }

  Map<String, dynamic> toJson() {
    return {
      'id': _id,
      'image': image,
      'title': title,
      'description': description,
      'formLink': formLink,
      'sheetId': sheetId,
      'location': location,
      'dateTime': dateTime,
      'speakers': speakers,
    };
  }

  factory Event.fromJson(Map<String, dynamic> json) {
    Event e = Event().._id = json['id'];
    e.title = json['title'];
    e.image = json['image'];
    e.description = json['description'];
    e.formLink = json['formLink'];
    e.sheetId = json['sheetId'];
    e.location = json['location'];
    e.dateTime = json['dateTime'];
    e.speakers = json['speakers'];
    return e;
  }

  @override
  String toString() {
    return jsonEncode(toJson());
  }
}



class EventsListProvider extends ChangeNotifier {

  List<Event> list = [];


  // EventsListProvider() {
  //   _init();
  // }

  Future<bool> initialize() async {
    try {
      await _init();
      return true;
    } catch(e) {
      return false;
    }
  }

  Future<void> _init() async{
    try {
      String? uid = AuthService.auth.currentUser?.uid;
      if(uid != null) {
        FirestoreService firestore = FirestoreService("_init EventsListProvider");
        var names = await firestore.getDocumentNames("Events");
        names = names.reversed.toList();
        list.clear();
        for(var e in names) {
          Map<String, dynamic>? data = await firestore.getDocument("Events", e);
          if(data != null) {
            Event event = Event.fromJson(data);
            list.add(event);
            notifyListeners();
          }
        }
        debugPrint('Events List Initialized.');
        await firestore.closeConnection("_init EventsListProvider");
        // notifyListeners();
      } else {
        throw Exception('User not Authenticated');
      }
    } catch (e) {
      debugPrint('Failed to Initialize ProfileProvider: $e');
    }
  }

  Future<void> addEvent(Event event) async {
    try {
      list.add(event);
      list = list.reversed.toList();
      notifyListeners();

      // String? uid = AuthService.auth.currentUser?.uid;
      // FirestoreService firestore = FirestoreService();
      // await firestore.insertOrUpdateDocument("Users", uid!, _profile!.toMap());
      // debugPrint("Profile Updated.");
      // await firestore.closeConnection();
      // notifyListeners();
    } catch (e) {
      debugPrint('Failed to Update ProfileProvider: $e');
    }
  }

}