import 'package:app/utils/routes.dart';
import 'package:app/utils/theme.dart';

import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'event_card_item_model.dart';
export 'event_card_item_model.dart';

class EventCardItemWidget extends StatefulWidget {
  const EventCardItemWidget({
    super.key,
    this.image,
    String? title,
    String? date,
    String? time,
    String? location,
    required this.id,
  })  : title = title ?? 'Event Title',
        date = date ?? 'Event Date',
        time = time ?? 'Event Time',
        location = location ?? 'Location';

  final String? image;
  final String title;
  final String date;
  final String time;
  final String location;
  final String? id;

  @override
  State<EventCardItemWidget> createState() => _EventCardItemWidgetState();
}

class _EventCardItemWidgetState extends State<EventCardItemWidget> {
  late EventCardItemModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EventCardItemModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(16, 8, 16, 8),
      child: InkWell(
        splashColor: Colors.transparent,
        focusColor: Colors.transparent,
        hoverColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () async {
          Get.toNamed(GetRoutes.eventDetails, arguments: widget.id!);
        },
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppTheme.of(context).secondaryBackground,
            boxShadow: const [
              BoxShadow(
                blurRadius: 7,
                color: Color(0x2F1D2429),
                offset: Offset(
                  0.0,
                  3,
                ),
              )
            ],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child : FadeInImage(
                    placeholder: const AssetImage('assets/images/image-placeholder.jpg'),
                    image: NetworkImage(widget.image!), // Network image to load
                    width: double.infinity,
                    height: 160,
                    fit: BoxFit.fitHeight,
                  ),
                  // child: Image.asset(
                  //   'assets/images/image-placeholder.jpg',
                  //   width: double.infinity,
                  //   height: 160,
                  //   fit: BoxFit.cover,
                  // ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 8, 0, 8),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        widget.title,
                        style: AppTheme.of(context).bodyLarge.overriden(
                          fontFamily: 'Roboto Mono',
                          letterSpacing: 0,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 8, 0, 8),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.date,
                        style: AppTheme.of(context).bodyLarge.overriden(
                          fontFamily: 'Roboto Mono',
                          letterSpacing: 0,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
                        child: Text(
                          widget.time,
                          style:
                          AppTheme.of(context).bodyMedium.overriden(
                            fontFamily: 'Roboto Mono',
                            letterSpacing: 0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 8, 0, 8),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Text(
                          widget.location,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
