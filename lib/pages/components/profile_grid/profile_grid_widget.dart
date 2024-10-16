import 'package:app/utils/theme.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:flutter/material.dart';

import 'profile_grid_model.dart';
export 'profile_grid_model.dart';

class ProfileGridWidget extends StatefulWidget {
  const ProfileGridWidget({
    super.key,
    required this.imageUrl,
    String? name,
    String? role,
  })  : name = name ?? 'UserName',
        role = role ?? 'Role';

  final String? imageUrl;
  final String name;
  final String role;

  @override
  State<ProfileGridWidget> createState() => _ProfileGridWidgetState();
}

class _ProfileGridWidgetState extends State<ProfileGridWidget> {
  late ProfileGridModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ProfileGridModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  // Widget build(BuildContext context) {
  //   return Padding(
  //     padding: const EdgeInsets.all(12),
  //     child: Material(
  //       color: Colors.transparent,
  //       elevation: 12,
  //       shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.circular(8),
  //       ),
  //       child: Container(
  //         width: double.infinity,
  //         height: double.infinity,
  //         decoration: BoxDecoration(
  //           color: AppTheme.of(context).secondaryBackground,
  //           boxShadow: const [
  //             BoxShadow(
  //               blurRadius: 4,
  //               color: Color(0x34090F13),
  //               offset: Offset(
  //                 0.0,
  //                 2,
  //               ),
  //               spreadRadius: 2,
  //             )
  //           ],
  //           borderRadius: BorderRadius.circular(8),
  //         ),
  //         child: Padding(
  //           padding: const EdgeInsets.all(12),
  //           child: Column(
  //             mainAxisSize: MainAxisSize.max,
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: [
  //               ClipRRect(
  //                 borderRadius: BorderRadius.circular(50),
  //                 child: FadeInImage(
  //                   placeholder: const AssetImage('assets/images/image-placeholder.jpg'),
  //                   image: NetworkImage(widget.imageUrl!), // Network image to load
  //                   width: 90,
  //                   height: 90,
  //                   fit: BoxFit.cover,
  //                 ),
  //               ),
  //               Padding(
  //                 padding: const EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
  //                 child: Text(
  //                   widget.name,
  //                   style: AppTheme.of(context).bodyMedium.overriden(
  //                     fontFamily: 'Roboto Mono',
  //                     letterSpacing: 0,
  //                   ),
  //                 ),
  //               ),
  //               Padding(
  //                 padding: const EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
  //                 child: Text(
  //                   widget.role,
  //                   style: AppTheme.of(context).labelSmall.overriden(
  //                     fontFamily: 'Roboto Mono',
  //                     letterSpacing: 0,
  //                   ),
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Material(
        color: Colors.transparent,
        elevation: 12,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Container(
          width: double.infinity,
          height: 150,
          decoration: BoxDecoration(
            color: AppTheme.of(context).secondaryBackground,
            boxShadow: const [
              BoxShadow(
                blurRadius: 4,
                color: Color(0x34090F13),
                offset: Offset(
                  0.0,
                  2,
                ),
                spreadRadius: 2,
              )
            ],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(26, 12, 12, 12),
                child: Container(
                  width: 100,
                  height: 100,
                  clipBehavior: Clip.antiAlias,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: FadeInImage(
                    placeholder: const AssetImage('assets/images/image-placeholder.jpg'),
                    image: NetworkImage(widget.imageUrl!), // Network image to load
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                        child: Text(
                          widget.name,
                          style:
                          AppTheme.of(context).titleLarge.overriden(
                            fontFamily: 'Roboto Mono',
                            letterSpacing: 0,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                        child: Text(
                          widget.role,
                          style:
                          AppTheme.of(context).labelLarge.overriden(
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
      ),
    );
  }
}
