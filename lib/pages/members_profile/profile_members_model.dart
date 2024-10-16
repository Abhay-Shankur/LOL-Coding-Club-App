import 'dart:io';

import 'package:app/firebaseHelpers/auth_service.dart';
import 'package:app/handlers/google_sheets_api.dart';
import 'package:app/utils/constants.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;
import 'profile_members_widget.dart' show ProfileMembersWidget;
import 'package:flutter/material.dart';

class ProfileMembersModel extends FlutterFlowModel<ProfileMembersWidget> {
  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // State field(s) for yourName widget.
  FocusNode? yourNameFocusNode;
  TextEditingController? yourNameTextController;
  String? Function(BuildContext, String?)? yourNameTextControllerValidator;
  String? _yourNameTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Field is required';
    }
    return null;
  }

  // State field(s) for email widget.
  FocusNode? emailFocusNode;
  TextEditingController? emailTextController;
  String? Function(BuildContext, String?)? emailTextControllerValidator;
  String? _emailTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Field is required';
    }
    return null;
  }

  // State field(s) for year widget.
  String? yearValue;
  FormFieldController<String>? yearValueController;

  // State field(s) for department widget.
  String? departmentValue;
  FormFieldController<String>? departmentValueController;

  // State field(s) for contact widget.
  FocusNode? contactFocusNode;
  TextEditingController? contactTextController;
  String? Function(BuildContext, String?)? contactTextControllerValidator;
  String? _contactTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Field is required';
    }
    return null;
  }

  @override
  void initState(BuildContext context) {
    yourNameTextControllerValidator = _yourNameTextControllerValidator;
    emailTextControllerValidator = _emailTextControllerValidator;
    contactTextControllerValidator = _contactTextControllerValidator;
  }

  @override
  void dispose() {
    yourNameFocusNode?.dispose();
    yourNameTextController?.dispose();

    emailFocusNode?.dispose();
    emailTextController?.dispose();

    contactFocusNode?.dispose();
    contactTextController?.dispose();
  }

// Helper method to extract the file ID from a Google Drive URL
  String? _extractGoogleDriveFileId(String url) {
    final regExp = RegExp(r'file/d/([^/]+)/');
    final match = regExp.firstMatch(url);
    return match?.group(1);
  }

  Future<String?> downloadFile(String url, String fileName) async {
    try {
      var status = await Permission.manageExternalStorage.request();
      if (!status.isGranted) {
        debugPrint('Storage permission not granted');
        return null;
      } else if (status.isPermanentlyDenied) {
        openAppSettings();
      }

      // Transform Google Drive URL if necessary
      if (url.contains("drive.google.com")) {
        final fileId = _extractGoogleDriveFileId(url);
        if (fileId == null) {
          debugPrint('Invalid Google Drive URL');
          return null;
        }
        url = 'https://drive.google.com/uc?export=download&id=$fileId';
      }

      // Send a GET request to the provided URL
      final response = await http.get(Uri.parse(url));

      // Check if the request was successful
      if (response.statusCode == 200) {
        Directory? downloadsDirectory;
        if (Platform.isAndroid) {
          downloadsDirectory = await getExternalStorageDirectory();
          String newPath = "";
          List<String> paths = downloadsDirectory!.path.split("/");
          for (int i = 1; i < paths.length; i++) {
            String path = paths[i];
            if (path != "Android") {
              newPath += "/$path";
            } else {
              break;
            }
          }
          newPath = "$newPath/Download";
          downloadsDirectory = Directory(newPath);
        } else if (Platform.isIOS) {
          downloadsDirectory = await getApplicationDocumentsDirectory();
        }

        if (downloadsDirectory != null) {
          var filePath = '${downloadsDirectory.path}/$fileName.pdf';

          // Create the file and write the bytes to it
          final file = File(filePath);
          await file.writeAsBytes(response.bodyBytes);

          debugPrint('File saved to $filePath');
          Get.showSnackbar(GetSnackBar(message: 'File saved to $filePath', duration: const Duration(seconds: 5),));

          // Return the file path
          return filePath;

        } else {
          debugPrint('Downloads directory not found');
          Get.showSnackbar(const GetSnackBar(message: 'Downloads directory not found', duration: Duration(seconds: 5),));
        }

      } else {
        throw Exception('Failed to download file: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error downloading file: $e');
    }
    return null;
  }

  Future<void> membershipReceipt() async {
    try {
      String email = AuthService.auth.currentUser!.email!;
      GoogleSheetsService sheetsService = GoogleSheetsService();
      await sheetsService.init();
      sheetsService.spreadsheetId = GlobalConstants.appDataSheetID;
      sheetsService.worksheet = GlobalConstants.appDataSheetMembership;

      List<String> headers = await sheetsService.getSheetHeaders() ?? [];
      int emailIndex = headers.indexOf("Email Address");
      var sheetData = await sheetsService.getSheetData(sheetsService.worksheet);
      var result = sheetData.firstWhere((row) => row[emailIndex]==email, orElse: ()=>[]);

      int receiptIndex = headers.indexOf("Merged Doc URL - LOL Membership 2024-25");
      final url = result[receiptIndex];
      showSnackbar(Get.context!, "Receipt downloading...", duration: 2);
      await downloadFile(url, "LOL Membership");
      showSnackbar(Get.context!, "Receipt Downloaded Successfully");
    } catch(e) {
      debugPrint("Exception $this: $e");
    }
  }
}
