import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    super.initState();
    // readExcel();
  }

  @override
  Widget build(BuildContext context) {

    Map<String,dynamic> student = {
      "LOL ID" : "20243812",
      "First Name" : "Abhay",
      "Middle Name" : "",
      "Last Name": "Shankur",
      "Class" : "B.E",
      "Department" : "CSE",
      "TimeStamp" : DateTime.now().toString()
    };

    debugPrint(student.toString());
    return Scaffold(
      body: Center(
        child: QrImageView(
          data: jsonEncode(student),
          version: QrVersions.auto,
          size: 200.0,
          errorStateBuilder: (cxt, err) {
            return const Center(
              child: Text(
                'Uh oh! Something went wrong...',
                textAlign: TextAlign.center,
              ),
            );
          },
        ),
      ),
    );
  }
}
