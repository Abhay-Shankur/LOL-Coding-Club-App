import 'package:app/firebaseHelpers/auth_service.dart';
import 'package:app/providers/profile_provider.dart';
import 'package:app/utils/routes.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'splash_screen_widget.dart' show SplashScreenWidget;
import 'package:flutter/material.dart';

class SplashScreenModel extends FlutterFlowModel<SplashScreenWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
  }


  Future<void> checkLogInStatus(BuildContext context) async {
    if(await AuthService.logInStatus()){
      if(await AuthService.isUserDisabled(AuthService.auth.currentUser!.uid)) {
        Get.showSnackbar(const GetSnackBar(message: "Contact Admin!",duration: Duration(seconds: 5),));
        await AuthService.signOut();
        return;
      }
      debugPrint("User Logged In");
      if(context.mounted) {
        await Provider.of<ProfileProvider>(context, listen: false).initialize();
      }
      // await Provider.of<EventsListProvider>(context, listen: false).initialize();
      Get.offAndToNamed(GetRoutes.home);
    } else {
      debugPrint("No User Found");
      Get.offAndToNamed(GetRoutes.login);
    }
  }

}
