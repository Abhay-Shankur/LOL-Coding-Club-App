import 'package:app/utils/theme.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
// import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'notification_tile_model.dart';
export 'notification_tile_model.dart';

class NotificationTileWidget extends StatefulWidget {
  const NotificationTileWidget({
    super.key,
    this.sender,
    String? title,
    String? message,
    String? time,
  })  : title = title ?? 'Notification Title',
        message = message ??
            '"Notifications and reminders informing users about upcoming classes and training schedules will be sent to them via email, SMS or notifications within the application."',
        time = time ?? ' ';

  final String? sender;
  final String title;
  final String message;
  final String time;

  @override
  State<NotificationTileWidget> createState() => _NotificationTileWidgetState();
}

class _NotificationTileWidgetState extends State<NotificationTileWidget> {
  late NotificationTileModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => NotificationTileModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppTheme.of(context).secondaryBackground,
        boxShadow: [
          BoxShadow(
            blurRadius: 0,
            color: AppTheme.of(context).alternate,
            offset: const Offset(
              0,
              1,
            ),
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(16, 12, 16, 12),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: const AlignmentDirectional(-1, -1),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                curve: Curves.easeInOut,
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: AppTheme.of(context).accent1,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppTheme.of(context).primary,
                    width: 2,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(2),
                  child: Icon(
                    Icons.notifications_active,
                    color: AppTheme.of(context).primary,
                    size: 20,
                  ),
                ),
              ),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 12),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RichText(
                            textScaler: MediaQuery.of(context).textScaler,
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'LOL Coding CLub : ',
                                  style: AppTheme.of(context)
                                      .bodyLarge
                                      .overriden(
                                    fontFamily: 'Roboto Mono',
                                    color: AppTheme.of(context)
                                        .primary,
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                TextSpan(
                                  text: widget.sender ?? "",
                                  style: const TextStyle(),
                                )
                              ],
                              style: AppTheme.of(context)
                                  .bodyLarge
                                  .overriden(
                                fontFamily: 'Roboto Mono',
                                letterSpacing: 0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppTheme.of(context).primaryBackground,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: AppTheme.of(context).alternate,
                          width: 2,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                              const EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                              child: Text(
                                widget.title,
                                style: AppTheme.of(context)
                                    .bodyLarge
                                    .overriden(
                                  fontFamily: 'Roboto Mono',
                                  letterSpacing: 0,
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                              const EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                              child: Text(
                                widget.message,
                                style: AppTheme.of(context)
                                    .labelMedium
                                    .overriden(
                                  fontFamily: 'Roboto Mono',
                                  letterSpacing: 0,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                      child: Text(
                        'Jul 8, at 4:30pm',
                        style:
                        AppTheme.of(context).labelMedium.overriden(
                          fontFamily: 'Roboto Mono',
                          letterSpacing: 0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
