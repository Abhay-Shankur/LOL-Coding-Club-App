import 'package:app/providers/forum_provider.dart';
import 'package:app/utils/theme.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'options_model.dart';
export 'options_model.dart';

class OptionsWidget extends StatefulWidget {
  const OptionsWidget({
    super.key,
    required this.message,
  });

  final Message message;

  @override
  State<OptionsWidget> createState() => _OptionsWidgetState();
}

class _OptionsWidgetState extends State<OptionsWidget> {
  late OptionsModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => OptionsModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        width: 300,
        decoration: BoxDecoration(
          color: AppTheme.of(context).secondaryBackground,
          boxShadow: const [
            BoxShadow(
              blurRadius: 4,
              color: Color(0x33000000),
              offset: Offset(
                0,
                2,
              ),
            )
          ],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(5, 10, 5, 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () async {
                  var forum = ForumProvider();
                  forum.removeMessage(widget.message);
                  Get.back();
                },
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppTheme.of(context).secondaryBackground,
                  ),
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 8, 0, 8),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                          child: Icon(
                            Icons.delete_outline_rounded,
                            color: AppTheme.of(context).error,
                            size: 20,
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding:
                            const EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                            child: Text(
                              'Delete',
                              style: AppTheme.of(context)
                                  .bodyMedium
                                  .overriden(
                                fontFamily: 'Roboto Mono',
                                color: AppTheme.of(context).error,
                                letterSpacing: 0,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
