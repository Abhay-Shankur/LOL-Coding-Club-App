import 'package:app/firebaseHelpers/auth_service.dart';
import 'package:app/utils/routes.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:get/get.dart';
import 'settings_members_widget.dart' show SettingsMembersWidget;
import 'package:flutter/material.dart';

class SettingsMembersModel extends FlutterFlowModel<SettingsMembersWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
  }

  Future<void> logOut() async {
    try {
      await AuthService.signOut();
      Get.offAllNamed(GetRoutes.login);
    } catch(e) {
      debugPrint("Exception: $e");
    }
  }


}
