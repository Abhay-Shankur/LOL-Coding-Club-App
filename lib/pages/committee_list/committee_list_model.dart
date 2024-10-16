import 'package:app/handlers/google_sheets_api.dart';
import 'package:app/utils/constants.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'committee_list_widget.dart' show CommitteeListWidget;
import 'package:flutter/material.dart';

class CommitteeListModel extends FlutterFlowModel<CommitteeListWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
  }

  String _extractFileId(String url) {
    RegExp regExp = RegExp(r'(?<=id=|/d/|/file/d/|/open\?id=|/drive/folders/|/drive/u/\d+/folders/)([-\w]{25,})');
    RegExpMatch? match = regExp.firstMatch(url);
    return match != null ? match.group(0)! : '';
  }

  String _getDirectDownloadLink(String fileId) {
    return 'https://drive.google.com/uc?export=download&id=$fileId';
  }
  
  Future<List<Map>?> getCommitteeList() async {
    try {
      GoogleSheetsService sheetsService = GoogleSheetsService();
      await sheetsService.init();
      sheetsService.spreadsheetId = GlobalConstants.appDataSheetID;
      sheetsService.worksheet = GlobalConstants.appDataSheetCommittee;

      var data = await sheetsService.getSheetData(sheetsService.worksheet);
      var headers = await sheetsService.getSheetHeaders() ?? [];
      int fName = headers.indexOf("First Name");
      int lName = headers.indexOf("Last Name");
      int position = headers.indexOf("Designation in LOL Coding Club");
      int img = headers.indexOf("Profile Image");

      var committeeList = [{}];
      data.removeAt(0);
      committeeList.clear();
      for(var item in data) {
        // debugPrint("Name : ${item[img]}");
        var imgId = _extractFileId(item[img]);
        var value = {
          "Name" : "${item[fName]} ${item[lName]}",
          "Position" : item[position],
          "Image" : _getDirectDownloadLink(imgId),
        };
        committeeList.add(value);
      }
      return committeeList;
    } catch (e) {
      debugPrint("Exception getCommitteeList: $e");
      return null;
    }
  }
}
