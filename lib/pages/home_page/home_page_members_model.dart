import 'package:flutterflow_ui/flutterflow_ui.dart';
import '/pages/components/event_card_item/event_card_item_widget.dart';
import 'home_page_members_widget.dart' show HomePageMembersWidget;
import 'package:flutter/material.dart';

class HomePageMembersModel extends FlutterFlowModel<HomePageMembersWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Models for eventCardItem dynamic component.
  late FlutterFlowDynamicModels<EventCardItemModel> eventCardItemModels;

  @override
  void initState(BuildContext context) {
    eventCardItemModels = FlutterFlowDynamicModels(() => EventCardItemModel());
  }

  @override
  void dispose() {
    unfocusNode.dispose();
    eventCardItemModels.dispose();
  }

}
