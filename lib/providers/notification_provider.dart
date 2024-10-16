

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class NotificationProvider extends ChangeNotifier {

  //TODO: Optimize Work load for Notifications tracking.
  static const String notificationsKey = "notifications";

  static final NotificationProvider _instance = NotificationProvider._internal();
  factory NotificationProvider() => _instance;

  NotificationProvider._internal();

  final List<RemoteMessage> _notifications = [];

  List<RemoteMessage> get notifications => _notifications;

  Future<void> init() async {
    try {
      // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      // var list = sharedPreferences.getStringList(notificationsKey) ?? [];
      //
      // for (var jsonStr in list) {
      //   try {
      //     var map = jsonDecode(jsonStr) as Map<String, dynamic>;
      //     var message = RemoteMessage.fromMap(map);
      //     _notifications.add(message);
      //   } catch (e) {
      //     // Log the problematic JSON string
      //     debugPrint("Error decoding JSON string: $jsonStr");
      //     debugPrint("Exception during decoding: $e");
      //   }
      // }
      // // var iterable = list.map((e) => RemoteMessage.fromMap(jsonDecode(e.toString()) as Map<String,dynamic>)).toList();
      // // _notifications.clear();
      // // _notifications.addAll(iterable);
      // notifyListeners();
    } catch(e) {
      debugPrint("Exception in $this: $e");
    }
  }

  Future<void> addNotification(RemoteMessage message) async {
    try {

      // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      // var list = sharedPreferences.getStringList(notificationsKey) ?? [];
      // list.add(jsonEncode(message.toMap()));
      // await sharedPreferences.setStringList(notificationsKey, list);
      // debugPrint("Saved to SharedPreference");
      //
      // // _notifications.addAll(list);
      // // _notifications.add(message);
      // await init();
      // notifyListeners();
      // debugPrint("Updated Notification List: ${_notifications.toString()}");
      _notifications.add(message);
      notifyListeners();
      debugPrint("Updated Notification List: ${_notifications.toString()}");

    } catch(e) {
      debugPrint("Exception in $this: $e");
    }
  }



  // List<RemoteMessage> list = [];
  //
  // NotificationProvider() {
  //   _init();
  // }

  // Future<bool> initialize() async {
  //   try {
  //     await _init();
  //     return true;
  //   } catch(e) {
  //     return false;
  //   }
  // }

  // Future<void> _init() async{
  //   try {
  //     String? uid = AuthService.auth.currentUser?.uid;
  //     if(uid != null) {
  //       FirestoreService firestore = FirestoreService("_init NotificationProvider");
  //       var names = await firestore.getDocument("Notification","_notifications");
  //       for(var n in names!.entries) {
  //         list.add(RemoteMessage.fromMap(n as Map<String, dynamic>));
  //         notifyListeners();
  //       }
  //       // names = names.reversed.toList();
  //       // debugPrint("_init NotificationProvider : $names");
  //       // list.clear();
  //       // for(var e in names) {
  //       //   Map<String, dynamic>? data = await firestore.getDocument("Events", e);
  //       //   debugPrint("_init EventsListProvider : $data");
  //       //   if(data != null) {
  //       //     Event event = Event.fromJson(data);
  //       //     list.add(event);
  //       //     notifyListeners();
  //       //   }
  //       // }
  //       debugPrint("Notification List : ${list.toString()}");
  //       debugPrint('Notification List Initialized.');
  //       await firestore.closeConnection("_init NotificationProvider");
  //       // notifyListeners();
  //     } else {
  //       throw Exception('User not Authenticated');
  //     }
  //   } catch (e) {
  //     debugPrint('Failed to Initialize NotificationProvider: $e');
  //   }
  // }

  // Future<void> addNotification(RemoteMessage message) async {
  //   try {
  //     list.add(message);
  //     list = list.reversed.toList();
  //     notifyListeners();
  //     debugPrint("Notification Updated.");
  //     debugPrint("Notifications : ${list.toString()}");
  //
  //     // String? uid = AuthService.auth.currentUser?.uid;
  //     // FirestoreService firestore = FirestoreService();
  //     // await firestore.insertOrUpdateDocument("Users", uid!, _profile!.toMap());
  //     // debugPrint("Profile Updated.");
  //     // await firestore.closeConnection();
  //     // notifyListeners();
  //   } catch (e) {
  //     debugPrint('Failed to Update NotificationProvider: $e');
  //   }
  // }
}

void updateNotificationList(RemoteMessage message) {
  try {
    final notificationProvider = NotificationProvider();
    notificationProvider.addNotification(message);
  } catch (e) {
    debugPrint("Exception in updateNotificationList : $e");
  }
}