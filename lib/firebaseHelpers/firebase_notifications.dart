// import 'dart:convert';
// import 'package:app/providers/notification_provider.dart';
// import 'package:app/utils/routes.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:get/get.dart';
// import 'package:provider/provider.dart';
//
// void handleMessage(RemoteMessage? message) {
//   if (message == null) return;
//
//   Get.toNamed(GetRoutes.notificationList);
// }
//
// Future<void> handleBackgroundNotification(RemoteMessage message) async {
//   debugPrint("RemoteMessage : ${message.toString()}");
//   debugPrint('Notification Title: ${message.notification?.title}');
//   debugPrint('Notification Body: ${message.notification?.body}');
//   debugPrint('Notification Payload: ${message.data}');
// }
//
// class FirebaseMessagingHandler {
//   static final _firebaseMessaging = FirebaseMessaging.instance;
//   static late NotificationSettings notificationSettings;
//
//   static get firebaseMessaging => _firebaseMessaging;
//
//   final _androidChannel = const AndroidNotificationChannel(
//     'high_importance_channel',
//     'High Importance Notifications',
//     description: 'This channel is used for important notifications',
//     importance: Importance.defaultImportance,
//   );
//
//   final _localNotifications = FlutterLocalNotificationsPlugin();
//
//   Future<String?> getToken() async {
//     try {
//       if (notificationSettings.authorizationStatus == AuthorizationStatus.notDetermined) {
//         notificationSettings = await _firebaseMessaging.requestPermission(provisional: true);
//         var fCMToken = await _firebaseMessaging.getToken();
//         // await SharedPreferencesHelper.saveDeviceToken(fCMToken!);
//         debugPrint('Device Token: $fCMToken');
//         return fCMToken;
//       }
//       return await _firebaseMessaging.getToken();
//     } catch (e) {
//       debugPrint('Error getting token: ${e.toString()}');
//       return null;
//     }
//   }
//
//   Future<void> initNotifications() async {
//     notificationSettings = await _firebaseMessaging.requestPermission(
//       alert: true,
//       announcement: false,
//       badge: true,
//       carPlay: false,
//       criticalAlert: false,
//       provisional: false,
//       sound: true,
//     );
//
//     if (notificationSettings.authorizationStatus == AuthorizationStatus.denied) {
//       notificationSettings = await _firebaseMessaging.requestPermission(provisional: true);
//     }
//
//     // For apple platforms, ensure the APNS token is available before making any FCM plugin API calls
//     final apnsToken = await FirebaseMessaging.instance.getAPNSToken();
//     if (apnsToken != null) {
//       // APNS token is available, make FCM plugin API requests...
//     }
//
//     // if (await ConnectivityService.isConnected()) {
//     //   var fCMToken = await _firebaseMessaging.getToken();
//     //   await SharedPreferencesHelper.saveDeviceToken(fCMToken!);
//     //   debugPrint('Device Token: $fCMToken');
//     // }
//     var fCMToken = await _firebaseMessaging.getToken();
//     // await SharedPreferencesHelper.saveDeviceToken(fCMToken!);
//     debugPrint('Device Token: $fCMToken');
//
//     initPushNotification();
//   }
//
//   Future<void> initPushNotification() async {
//     await _firebaseMessaging.setForegroundNotificationPresentationOptions(
//       alert: true,
//       badge: true,
//       sound: true,
//     );
//
//     _firebaseMessaging.getInitialMessage().then(handleMessage);
//     FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
//     FirebaseMessaging.onBackgroundMessage(handleBackgroundNotification);
//
//     FirebaseMessaging.onMessage.listen((event) async {
//       final notification = event.notification;
//       if (notification == null) return;
//
//
//       // debugPrint("RemoteMessage : ${message.toString()}");
//       debugPrint('Notification Title: ${notification?.title}');
//       debugPrint('Notification Body: ${notification?.body}');
//       debugPrint('Notification Payload: ${event.data}');
//       await Provider.of<NotificationProvider>(Get.context!, listen: false).addNotification(event);
//
//       _localNotifications.show(
//         notification.hashCode,
//         notification.title,
//         notification.body,
//         NotificationDetails(
//           android: AndroidNotificationDetails(
//             _androidChannel.id,
//             _androidChannel.name,
//             channelDescription: _androidChannel.description,
//             icon: '@mipmap/launcher_icon',
//           ),
//         ),
//         payload: jsonEncode(event.toMap()),
//       );
//     });
//   }
// }
import 'dart:convert';
import 'package:app/firebase_options.dart';
import 'package:app/providers/notification_provider.dart';
import 'package:app/utils/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

void handleMessage(RemoteMessage? message) {
  if (message == null) return;

  Get.toNamed(GetRoutes.notificationList);
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  try {

    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    // FirebaseMessagingHandler.setupFlutterNotifications();
    // FirebaseMessagingHandler.showFlutterNotification(message);
    debugPrint('Handling a background message ${message.messageId}');
    debugPrint('Background message ${message.toMap().toString()}');

    updateNotificationList(message);
  } catch (e) {
    debugPrint("Exception in _firebaseMessagingBackgroundHandler : $e");
  }
}

// Future<void> handleBackgroundNotification(RemoteMessage message) async {
//   debugPrint("RemoteMessage : ${message.toString()}");
//   debugPrint('Notification Title: ${message.notification?.title}');
//   debugPrint('Notification Body: ${message.notification?.body}');
//   debugPrint('Notification Payload: ${message.data}');
// }

class FirebaseMessagingHandler {
  static late final String? _fCMToken;
  static final _firebaseMessaging = FirebaseMessaging.instance;
  static late NotificationSettings notificationSettings;

  static get firebaseMessaging => _firebaseMessaging;
  static get getFCMToken => _fCMToken;

  final _androidChannel = const AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    description: 'This channel is used for important notifications',
    importance: Importance.high,
  );

  final _localNotifications = FlutterLocalNotificationsPlugin();

  // Future<String?> getToken() async {
  //   try {
  //     if (notificationSettings.authorizationStatus == AuthorizationStatus.notDetermined) {
  //       notificationSettings = await _firebaseMessaging.requestPermission(provisional: true);
  //       var fCMToken = await _firebaseMessaging.getToken();
  //       debugPrint('Device Token: $fCMToken');
  //       return fCMToken;
  //     }
  //     return await _firebaseMessaging.getToken();
  //   } catch (e) {
  //     debugPrint('Error getting token: ${e.toString()}');
  //     return null;
  //   }
  // }

  Future<void> initNotifications() async {
    notificationSettings = await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (notificationSettings.authorizationStatus == AuthorizationStatus.denied) {
      notificationSettings = await _firebaseMessaging.requestPermission(provisional: true);
    }

    final apnsToken = await FirebaseMessaging.instance.getAPNSToken();
    if (apnsToken != null) {
      // APNS token is available, make FCM plugin API requests...
    }

    _fCMToken = await _firebaseMessaging.getToken();
    debugPrint('Device Token: $_fCMToken');

    initPushNotification();
  }

  Future<void> initPushNotification() async {
    await _firebaseMessaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      await handleForegroundNotification(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    _firebaseMessaging.getInitialMessage().then(handleMessage);
  }

  Future<void> handleForegroundNotification(RemoteMessage message) async {
    final notification = message.notification;
    if (notification == null) return;

    debugPrint('Notification Title: ${notification.title}');
    debugPrint('Notification Body: ${notification.body}');
    debugPrint('Notification Payload: ${message.data}');

    updateNotificationList(message);

    _localNotifications.show(
      notification.hashCode,
      notification.title,
      notification.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          _androidChannel.id,
          _androidChannel.name,
          channelDescription: _androidChannel.description,
          icon: '@mipmap/launcher_icon',
        ),
      ),
      payload: jsonEncode(message.toMap()),
    );
  }
}
