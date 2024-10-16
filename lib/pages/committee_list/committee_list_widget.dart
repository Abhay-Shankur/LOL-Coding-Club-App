import 'package:app/utils/theme.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:get/get.dart';
import '/pages/components/profile_grid/profile_grid_widget.dart';
import 'package:flutter/material.dart';

import 'committee_list_model.dart';
export 'committee_list_model.dart';

class CommitteeListWidget extends StatefulWidget {
  const CommitteeListWidget({super.key});

  @override
  State<CommitteeListWidget> createState() => _CommitteeListWidgetState();
}

class _CommitteeListWidgetState extends State<CommitteeListWidget> {
  late CommitteeListModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CommitteeListModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: AppTheme.of(context).secondaryBackground,
        appBar: AppBar(
          backgroundColor: AppTheme.of(context).secondaryBackground,
          automaticallyImplyLeading: false,
          leading: FlutterFlowIconButton(
            borderColor: Colors.transparent,
            borderRadius: 30,
            borderWidth: 1,
            buttonSize: 60,
            icon: Icon(
              Icons.arrow_back_rounded,
              color: AppTheme.of(context).secondaryText,
              size: 30,
            ),
            onPressed: () async {
              Get.back();
            },
          ),
          actions: const [],
          centerTitle: true,
          elevation: 0,
        ),
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(24, 4, 0, 0),
                child: Text(
                  'Committee Members',
                  textAlign: TextAlign.start,
                  style: AppTheme.of(context).labelLarge.overriden(
                    fontFamily: 'Roboto Mono',
                    fontSize: 18,
                    letterSpacing: 0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Flexible(
                child: Container(
                  width: double.infinity,
                  height: MediaQuery.sizeOf(context).height * 1,
                  decoration: BoxDecoration(
                    color: AppTheme.of(context).secondaryBackground,
                  ),
                  child: FutureBuilder(
                    future: _model.getCommitteeList(),
                    builder: (context, snapshot) {
                      if(snapshot.hasData && snapshot.connectionState == ConnectionState.done && snapshot.data!.isNotEmpty) {
                        final membersList = snapshot.data;
                        return ListView.builder(
                          padding: EdgeInsets.zero,
                          scrollDirection: Axis.vertical,
                          itemCount: membersList?.length,
                          itemBuilder: (context, membersListIndex) {
                            final membersListItem = membersList?[membersListIndex];
                            return ProfileGridWidget(
                              key: Key(
                                  'Keyl0a_${membersListIndex}_of_${membersList?.length}'),
                              imageUrl: membersListItem?["Image"],
                              name: membersListItem?["Name"],
                              role: membersListItem?["Position"],
                            );
                          },
                        );
                      }
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
