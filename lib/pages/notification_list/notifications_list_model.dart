import 'package:app/firebaseHelpers/firebase_notifications.dart';
import 'package:app/providers/notification_provider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'notifications_list_widget.dart' show NotificationsListWidget;
import 'package:flutter/material.dart';

class NotificationsListModel extends FlutterFlowModel<NotificationsListWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
  }

  Future<void> initPermission() async {
    try {
      await FirebaseMessagingHandler().initNotifications();
    } catch(e) {
      debugPrint("Exception $this: $e");
    }
  }

  List<RemoteMessage> getNotification() {
    try {
      final notificationProvider = NotificationProvider();
      return notificationProvider.notifications;
    } catch(e) {
      debugPrint("Exception in $this: $e");
      return [];
    }
  }
}
