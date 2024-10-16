
// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:gsheets/gsheets.dart';

class GoogleSheetsService {
  final String _credentialsPath = 'assets/credentials/lol-club-app-d1538-e1b04a99127f.json';

  late GSheets? _gSheets;
  late String? _spreadsheetId;
  late String? _worksheet;

  String get worksheet => _worksheet ?? '';

  set worksheet(String value) {
    _worksheet = value;
  }

  String get
  spreadsheetId => _spreadsheetId ?? '';

  set spreadsheetId(String value) {
    _spreadsheetId = value;
  } // Replace with your spreadsheet ID

  GoogleSheetsService() {
    init();
  }

  Future<void> init() async {
    final credentialsJson = await rootBundle.loadString(_credentialsPath);
    final credentials = jsonDecode(credentialsJson);
    _gSheets = GSheets(credentials);
  }

  Future<List<String>> getSheetNames() async {
    try {
      final spreadsheet = await _gSheets!.spreadsheet(spreadsheetId);
      return spreadsheet.sheets.map((sheet) => sheet.title).toList();
    } catch (e) {
      print('Error getting sheet names: $e');
      return [];
    }
  }

  Future<List<List<String>>> getSheetData(String sheetName) async {
    try {
      final spreadsheet = await _gSheets!.spreadsheet(spreadsheetId);
      final sheet = spreadsheet.worksheetByTitle(sheetName);
      return await sheet?.values.allRows() ?? [];
    } catch (e) {
      print('Error getting sheet data: $e');
      return [];
    }
  }

  Future<Map<String, List<List<String>>>> getTableWiseData() async {
    try {
      final spreadsheet = await _gSheets!.spreadsheet(spreadsheetId);
      final tables = <String, List<List<String>>>{};

      for (var sheet in spreadsheet.sheets) {
        final sheetName = sheet.title;
        tables[sheetName] = await sheet.values.allRows();
      }

      return tables;
    } catch (e) {
      print('Error getting table-wise data: $e');
      return {};
    }
  }

  Future<List<String>?> getSheetHeaders() async {
    try {
      final spreadsheet = await _gSheets!.spreadsheet(spreadsheetId);
      final sheet = spreadsheet.worksheetByTitle(worksheet);

      if (sheet == null) {
        print('Sheet not found');
        return null;
      }

      final rows = await sheet.values.allRows();
      if (rows.isEmpty) {
        print('No data found');
        return null;
      }

      List<String> header = rows[0];
      return header;
    } catch(e) {
      print('Error getting Sheet Headers: $e');
      return [];
    }
  }

  Future<String?> markAttendance({required String col, required String email, Map<String,dynamic>? data}) async {
    try {
      final spreadsheet = await _gSheets!.spreadsheet(spreadsheetId);
      final sheet = spreadsheet.worksheetByTitle(worksheet); // Adjust the sheet name

      if (sheet == null) {
        return 'Sheet not found';
      }

      final rows = await sheet.values.allRows();
      if (rows.isEmpty) {
        return 'No data found';
      }

      // Find the indices of the "Email Address" and "Attendance" columns
      final header = rows[0];
      debugPrint("header : ${header.toString()}");
      final emailIndex = header.indexOf('Email Address');
      final attendanceIndex = header.indexOf(col);
      // debugPrint("emailIndex : $emailIndex");
      // debugPrint("attendanceIndex : $attendanceIndex");

      if (emailIndex == -1 || attendanceIndex == -1) {
        return 'Required columns not found';
      }

      int rowIndex = binarySearch(rows, emailIndex, email);
      // debugPrint("rowIndex : $rowIndex");

      // var data = rows[rowIndex-1].asMap();
      // debugPrint("Attendance: ${data.toString()}");

      if(rowIndex != -1 && rows[rowIndex-1][attendanceIndex] == 'Present') {
        return 'Attendance already marked for $email';
      } else if (rowIndex != -1  && rows[rowIndex-1][attendanceIndex] != 'Present') {
        await sheet.values.insertValue('Present', column: attendanceIndex+1 , row: rowIndex);
        return 'Attendance marked for $email';
      } else {
        // var keys = data.keys.toList();
        // List<String>? values = data.values.map((e) => e.toString()).toList();
        return "Spot Entry";
        // return markSpotEntry(keys,values);
      }
    } catch (e) {
      print('Error marking attendance: $e');
      return null;
    }
  }

  int binarySearch(List<List<String>> rows, int emailIndex, String email) {
    int low = 1; // Start from 1 to skip the header row
    int high = rows.length - 1;

    while (low <= high) {
      int mid = low + ((high - low) ~/ 2);
      String midValue = rows[mid][emailIndex];

      if (midValue == email) {
        return mid + 1; // 1-based index for gsheets
      } else if (midValue.compareTo(email) < 0) {
        low = mid + 1;
      } else {
        high = mid - 1;
      }
    }

    return -1; // Email not found
  }

  Future<String?> markSpotEntry(List<String> keys,List<String> values) async {
    try {
      final spreadsheet = await _gSheets!.spreadsheet(spreadsheetId);
      Worksheet? sheet = spreadsheet.worksheetByTitle('Spot Entry');

      if (sheet == null) {
        // Create new worksheet if it does not exist
        sheet = await spreadsheet.addWorksheet('Spot Entry');
        // Set up the worksheet structure

        await sheet.values.insertRow(1, keys);
      }

      // Insert values into the next available row
      await sheet.values.appendRow(values);
      return "Spot Entry Registered";
    } catch (e) {
      print('Error in markSpotEntry: $e');
      return null;
    }
  }
}
