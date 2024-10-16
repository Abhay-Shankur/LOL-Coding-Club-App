import 'package:app/utils/theme.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:flutter/material.dart';

import 'speaker_model.dart';
export 'speaker_model.dart';

class SpeakerWidget extends StatefulWidget {
  const SpeakerWidget({
    super.key,
    String? name,
    this.image,
  }) : name = name ?? 'Speaker Name';

  final String name;
  final String? image;

  @override
  State<SpeakerWidget> createState() => _SpeakerWidgetState();
}

class _SpeakerWidgetState extends State<SpeakerWidget> {
  late SpeakerModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SpeakerModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(7),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              'assets/images/speaker-avatar.jpg',
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
          ),
          Text(
            widget.name,
            style: AppTheme.of(context).titleSmall.overriden(
              color: AppTheme.of(context).primaryText,
              fontFamily: 'Roboto Mono',
              letterSpacing: 0,
            ),
          ),
        ],
      ),
    );
  }
}
