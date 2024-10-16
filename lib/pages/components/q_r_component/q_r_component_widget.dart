import 'package:app/utils/theme.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'q_r_component_model.dart';
export 'q_r_component_model.dart';

class QRComponentWidget extends StatefulWidget {
  const QRComponentWidget({super.key});

  @override
  State<QRComponentWidget> createState() => _QRComponentWidgetState();
}

class _QRComponentWidgetState extends State<QRComponentWidget> {
  late QRComponentModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => QRComponentModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(12),
      child: Container(
        width: 300,
        height: 300,
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
          borderRadius: BorderRadius.circular(18),
        ),
        child: FutureBuilder(
          future: _model.getQR(context),
          builder: (context, snapshot) {
            if(snapshot.hasData && snapshot.connectionState == ConnectionState.done && snapshot.data!.isNotEmpty) {
              return QrImageView(
                data: snapshot.data!,
                version: QrVersions.auto,
                padding: const EdgeInsets.all(20.0),
                errorStateBuilder: (cxt, err) {
                  return const Center(
                    child: Text(
                      'Uh oh! Something went wrong...',
                      textAlign: TextAlign.center,
                    ),
                  );
                },
              );
            }
            return const Center(
              child: Text(" Incomplete Profile ! "),
            );
          },
        ),
      ),
    );
  }
}
