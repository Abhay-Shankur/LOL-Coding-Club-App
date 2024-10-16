import 'package:app/firebaseHelpers/firestore_service.dart';
import 'package:expandable/expandable.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'event_details_widget.dart' show EventDetailsWidget;
import 'package:flutter/material.dart';

class EventDetailsModel extends FlutterFlowModel<EventDetailsWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // State field(s) for formlink widget.
  FocusNode? formlinkFocusNode;
  TextEditingController? formlinkTextController;
  String? Function(BuildContext, String?)? formlinkTextControllerValidator;
  // State field(s) for feedbacklink widget.
  FocusNode? feedbacklinkFocusNode;
  TextEditingController? feedbacklinkTextController;
  String? Function(BuildContext, String?)? feedbacklinkTextControllerValidator;
  // State field(s) for fees widget.
  FocusNode? feesFocusNode;
  TextEditingController? feesTextController;
  String? Function(BuildContext, String?)? feesTextControllerValidator;

  // State field(s) for Expandable widget.
  late ExpandableController expandableExpandableController;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
    expandableExpandableController.dispose();
    formlinkFocusNode?.dispose();
    formlinkTextController?.dispose();

    feedbacklinkFocusNode?.dispose();
    feedbacklinkTextController?.dispose();

    feesFocusNode?.dispose();
    feesTextController?.dispose();
  }

  Future<Map<String, dynamic>?> getDetails(String documentId) async {
    try {
      FirestoreService service = FirestoreService("getDetails");
      var res = await service.getDocument("Events", documentId);
      await service.closeConnection("getDetails");
      return res;
    } catch (e) {
      debugPrint("Exception: $e");
      return null;
    }
  }
}
