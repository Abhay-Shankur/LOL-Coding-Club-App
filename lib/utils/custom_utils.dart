import 'package:flutter/material.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';

DateFormat customDateFormat = DateFormat("EEEE, MMM d, yyyy 'at' h:mma");
DateFormat timeFormat12Hour = DateFormat("hh:mm a");
DateFormat dateFormat = DateFormat("yyyy-MM-dd");

String? Function(BuildContext, String?)? textValidator = (context, value) {
  if (value == null || value.isEmpty) {
    return 'This field cannot be empty';
  }
  return null;
};
