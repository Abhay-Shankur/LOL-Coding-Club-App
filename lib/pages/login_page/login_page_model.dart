import 'package:app/firebaseHelpers/auth_service.dart';
import 'package:app/firebaseHelpers/firebase_notifications.dart';
import 'package:app/firebaseHelpers/firestore_service.dart';
import 'package:app/handlers/google_sheets_api.dart';
import 'package:app/providers/profile_provider.dart';
import 'package:app/utils/constants.dart';
import 'package:app/utils/routes.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'login_page_widget.dart' show LoginPageWidget;
import 'package:flutter/material.dart';

class LoginPageModel extends FlutterFlowModel<LoginPageWidget> {
  ///  State fields for stateful widgets in this page.
  late int _index;

  final unfocusNode = FocusNode();
  final formKey = GlobalKey<FormState>();
  // State field(s) for emailAddress widget.
  FocusNode? emailAddressFocusNode;
  TextEditingController? emailAddressTextController;
  String? Function(BuildContext, String?)? emailAddressTextControllerValidator;
  String? _emailAddressTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Field is required';
    }

    if (!RegExp(kTextValidatorEmailRegex).hasMatch(val)) {
      return 'Invalid Mail';
    }
    return null;
  }

  // State field(s) for password widget.
  FocusNode? passwordFocusNode;
  TextEditingController? passwordTextController;
  late bool passwordVisibility;
  String? Function(BuildContext, String?)? passwordTextControllerValidator;
  String? _passwordTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Field is required';
    }

    return null;
  }

  @override
  void initState(BuildContext context) {
    emailAddressTextControllerValidator = _emailAddressTextControllerValidator;
    passwordVisibility = false;
    passwordTextControllerValidator = _passwordTextControllerValidator;
  }

  @override
  void dispose() {
    unfocusNode.dispose();
    emailAddressFocusNode?.dispose();
    emailAddressTextController?.dispose();

    passwordFocusNode?.dispose();
    passwordTextController?.dispose();
  }

  Future<bool> checkEmail(String? emailId) async {
    try {
      String email = emailId ?? AuthService.auth.currentUser!.email.toString();
      GoogleSheetsService sheetsService = GoogleSheetsService();
      await sheetsService.init();
      sheetsService.spreadsheetId = GlobalConstants.appDataSheetID;
      sheetsService.worksheet = GlobalConstants.appDataSheetMembership;

      var headers = await sheetsService.getSheetHeaders() ?? [];
      var emailIndex = headers.indexOf("Email Address");
      var sheetData = await sheetsService.getSheetData(sheetsService.worksheet);
      // _index = sheetsService.binarySearch(sheetData, emailIndex, email);
      _index = sheetData.indexWhere((row) => row[emailIndex]==email);

      return _index!=-1 ? true : false ;
    } catch (e) {
      debugPrint("Exception: $e");
      return false;
    }
  }

  // Future<Profile?> getUserDetails() async {
  //   try {
  //     if(_index != -1) {
  //       GoogleSheetsService sheetsService = GoogleSheetsService();
  //       await sheetsService.init();
  //       sheetsService.spreadsheetId = GlobalConstants.appDataSheetID;
  //       sheetsService.worksheet = GlobalConstants.appDataSheetMembership;
  //
  //       var headers = await sheetsService.getSheetHeaders() ?? [];
  //       var emailIndex = headers.indexOf("Email Address");
  //       var sheetData = await sheetsService.getSheetData(sheetsService.worksheet);
  //       var data = sheetData[emailIndex];
  //       Map<String, String> zippedMap = Map.fromIterables(headers, data);
  //       debugPrint("Zipped : ${zippedMap.toString()}");
  //       var profile = Profile(
  //           uid: AuthService.auth.currentUser?.uid,
  //           image: null,
  //           name: "${zippedMap['First Name']} ${zippedMap['Last Name']}",
  //           email: zippedMap['Email Address'],
  //           year: zippedMap['Year'],
  //           dept: zippedMap['Department'],
  //           contact: AuthService.auth.currentUser!.phoneNumber ?? zippedMap['Phone Number'],
  //           membership: true
  //       );
  //       debugPrint("Profile : ${profile.toMap().toString()}");
  //       return profile;
  //     }
  //   } catch(e) {
  //     debugPrint("Exception: $e");
  //     return null;
  //   }
  //   return null;
  // }

  Future<Profile?> getProfile() async {
    try {
      await checkEmail(null);
      var profile = Profile(
          uid: AuthService.auth.currentUser?.uid,
          image: AuthService.auth.currentUser?.photoURL,
          name: AuthService.auth.currentUser?.displayName,
          email: AuthService.auth.currentUser?.email,
          year: null,
          dept: null,
          contact: AuthService.auth.currentUser!.phoneNumber,
          membership: false
      );

      if(_index != -1) {
        GoogleSheetsService sheetsService = GoogleSheetsService();
        await sheetsService.init();
        sheetsService.spreadsheetId = GlobalConstants.appDataSheetID;
        sheetsService.worksheet = GlobalConstants.appDataSheetMembership;

        var headers = await sheetsService.getSheetHeaders() ?? [];
        var sheetData = await sheetsService.getSheetData(sheetsService.worksheet);
        var data = sheetData[_index];
        Map<String, String> zippedMap = Map.fromIterables(headers, data);
        debugPrint("Zipped : ${zippedMap.toString()}");

        profile.name = "${zippedMap['First Name']} ${zippedMap['Last Name']}";
        profile.year = zippedMap['Year'];
        profile.dept = zippedMap['Department'];
        profile.membership = true;
        if (profile.contact == null || profile.contact!.isEmpty) {
          profile.contact = zippedMap['Phone Number'];
        }
      }

      debugPrint("Profile : ${profile.toMap().toString()}");

      return profile;
    } catch(e) {
      debugPrint("Exception: $e");
      return null;
    }
  }

  Future<void> login(BuildContext context) async {
    try {
      String email = emailAddressTextController!.value.text;
      String password = passwordTextController!.value.text;
      var res = await checkEmail(email);

      if(res && (await AuthService.signInWithEmail(email, password) != null)){
        Get.showSnackbar(const GetSnackBar(message: "Welcome back Champ", duration: Duration(seconds: 3),));
        var profile = await getProfile();
        if (profile != null && context.mounted) {
          await Provider.of<ProfileProvider>(context, listen: false).initialize();
          await updateDeviceId();
          Get.offAllNamed(GetRoutes.home);
        }
      } else if (res && (await AuthService.createAccountWithEmail(email, password) != null)) {
        Get.showSnackbar(const GetSnackBar(message: "Account Created", duration: Duration(seconds: 3),));
        var profile = await getProfile();
        if (profile != null && context.mounted) {
          await Provider.of<ProfileProvider>(context, listen: false).updateProfile(profile);
          await updateDeviceId();
          Get.offAllNamed(GetRoutes.home);
        }
      } else if (!res) {
        Get.showSnackbar(const GetSnackBar(message: "Get your Membership first !", duration: Duration(seconds: 5),));
      }  else {
        Get.showSnackbar(const GetSnackBar(message: "Failed to Login! Please contact Admin.", duration: Duration(seconds: 5),));
      }

    } catch (e) {
      debugPrint("Exception: $e");
    }
  }

  Future<void> googleSignIn(BuildContext context) async {
    try {
      if(await AuthService.signInWithGoogle() == null) {
       Get.showSnackbar(const GetSnackBar(message: "Get your Membership first !", duration: Duration(seconds: 5),));
       return;
      }
      var profile = await getProfile();
      if(profile != null && context.mounted) {
        // Provider.of<ProfileProvider>(context,listen: false).initialize();
        await Provider.of<ProfileProvider>(context, listen: false).updateProfile(profile);
        // Provider.of<EventsListProvider>(context, listen: false).initialize();
        await updateDeviceId();
        Get.offAllNamed(GetRoutes.home);
      }
    } catch(e) {
      debugPrint("Exception in googleSignIn : $e");
    }
  }

  // Future<Profile?> getSignedInUserDetails() async {
  //   try {
  //     String? email = AuthService.auth.currentUser!.email;
  //     GoogleSheetsService sheetsService = GoogleSheetsService();
  //     await sheetsService.init();
  //     sheetsService.spreadsheetId = GlobalConstants.appDataSheetID;
  //     sheetsService.worksheet = GlobalConstants.appDataSheetMembership;
  //
  //     var headers = await sheetsService.getSheetHeaders() ?? [];
  //     var emailIndex = headers.indexOf("Email Address");
  //     var sheetData = await sheetsService.getSheetData(sheetsService.worksheet);
  //     int index = sheetsService.binarySearch(sheetData, emailIndex, email!);
  //     var data = sheetData[index-1];
  //     Map<String, String> zippedMap = Map.fromIterables(headers, data);
  //     var profile = Profile(
  //       uid: AuthService.auth.currentUser?.uid,
  //       image: AuthService.auth.currentUser!.photoURL,
  //       name: "${zippedMap['First Name']} ${zippedMap['Last Name']}",
  //       email: email,
  //       year: zippedMap['Year'],
  //       dept: zippedMap['Department'],
  //       contact: AuthService.auth.currentUser!.phoneNumber ?? zippedMap['Phone Number'],
  //       membership: true
  //     );
  //     debugPrint("Profile : ${profile.toMap().toString()}");
  //     return profile;
  //   } catch(e) {
  //     debugPrint("Exception: $e");
  //     return null;
  //   }
  // }

  Future<void> updateDeviceId() async {
    try{
      var uid = AuthService.auth.currentUser?.uid;
      var token = await FirebaseMessagingHandler.getFCMToken;
      if(uid != null && token != null) {
        FirestoreService service = FirestoreService("$this");
        await service.insertOrUpdateDocument("Users", uid, {"DeviceId" : token});
        // await service.insertOrUpdateDocument("Notification", "DeviceIds", {"members" : FieldValue.arrayUnion([token])});
        await service.addTokenToNotification(token);
        await service.closeConnection("$this");
      }
    } catch(e) {
      debugPrint("Exception $this: $e");
    }
  }
}
