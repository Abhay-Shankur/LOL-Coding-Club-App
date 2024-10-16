import 'package:app/pages/components/empty_list/empty_list_widget.dart';
import 'package:app/utils/theme.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import '/pages/components/notification_tile/notification_tile_widget.dart';
import 'package:flutter/material.dart';

import 'notifications_list_model.dart';
export 'notifications_list_model.dart';

class NotificationsListWidget extends StatefulWidget {
  const NotificationsListWidget({super.key});

  @override
  State<NotificationsListWidget> createState() =>
      _NotificationsListWidgetState();
}

class _NotificationsListWidgetState extends State<NotificationsListWidget> {
  late NotificationsListModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => NotificationsListModel());
    _model.initPermission();
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var list = _model.getNotification();
    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: AppTheme.of(context).secondaryBackground,
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(16, 24, 0, 0),
                child: Text(
                  'Notifications',
                  style: AppTheme.of(context).headlineMedium.overriden(
                    fontFamily: 'PT Sans',
                    letterSpacing: 0,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(16, 4, 0, 0),
                child: Text(
                  'Below is a list of recent activity',
                  style: AppTheme.of(context).labelMedium.overriden(
                    fontFamily: 'Roboto Mono',
                    letterSpacing: 0,
                  ),
                ),
              ),
              if(list.isNotEmpty)
                Builder(builder: (builder) {
                    final notificationList = list.reversed.toList();
                    return ListView.separated(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: notificationList.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 1),
                      itemBuilder: (context, notificationListIndex) {
                        final notificationListItem = notificationList[notificationListIndex];
                        debugPrint(notificationListItem.toMap().toString());
                        return NotificationTileWidget(
                          key: Key('Keyz3y_${notificationListIndex}_of_${notificationList.length}'),
                          sender: "Sender",
                          title: notificationListItem.notification!.title,
                          message: notificationListItem.notification!.body,
                        );
                      },
                    );
                }),
              if(list.isEmpty)
                const EmptyListWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
