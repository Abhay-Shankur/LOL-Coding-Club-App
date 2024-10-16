import 'package:app/providers/profile_provider.dart';
import 'package:app/utils/constants.dart';
import 'package:encrypt_decrypt_plus/cipher/cipher.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:provider/provider.dart';
import 'q_r_component_widget.dart' show QRComponentWidget;
import 'package:flutter/material.dart';

class QRComponentModel extends FlutterFlowModel<QRComponentWidget> {
  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}

  Future<String?> getQR(BuildContext context) async {
    try {
      //TODO: Shift initialize to splash screen
      if(await Provider.of<ProfileProvider>(context, listen: false).initialize() && context.mounted) {
        var details = Provider.of<ProfileProvider>(context, listen: false).profile?.toMap();
        var data = {
          "uid" : details?['uid'],
          "userName" : details?['userName'],
          "userEmail" : details?['userEmail'],
          "class" : details?['class'],
          "department" : details?['department'],
          "userContact" : details?['userContact'],
          "membership" : details?['membership'],
        };
        debugPrint("QR data : ${data.toString()}");

        if(data.values.any((val) => (val==null) || (val.toString().isEmpty))){
          debugPrint("Null exists");
          return null;
        }

        Cipher cipher = Cipher(secretKey: GlobalConstants.secretKey);
        String encryptTxt = cipher.xorEncode(jsonEncode(data));
        // data = cipher.xorDecode(data);
        return encryptTxt;
      }
    } catch (e) {
      debugPrint("Exception : $e");
    }
    return null;

  }
}
