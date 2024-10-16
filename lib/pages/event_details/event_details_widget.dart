import 'package:app/utils/custom_utils.dart';
import 'package:app/utils/theme.dart';
import 'package:expandable/expandable.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:full_screen_image/full_screen_image.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '/pages/components/speaker/speaker_widget.dart';
import 'package:flutter/material.dart';

import 'event_details_model.dart';
export 'event_details_model.dart';

class EventDetailsWidget extends StatefulWidget {
  const EventDetailsWidget({super.key});

  @override
  State<EventDetailsWidget> createState() => _EventDetailsWidgetState();
}

class _EventDetailsWidgetState extends State<EventDetailsWidget> {
  late EventDetailsModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  late String data;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EventDetailsModel());
    _model.expandableExpandableController =
        ExpandableController(initialExpanded: false);

    _model.formlinkTextController ??= TextEditingController();
    _model.formlinkFocusNode ??= FocusNode();

    _model.feedbacklinkTextController ??= TextEditingController();
    _model.feedbacklinkFocusNode ??= FocusNode();

    _model.feesTextController ??= TextEditingController();
    _model.feesFocusNode ??= FocusNode();

    data = Get.arguments ?? '';
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
          backgroundColor: AppTheme.of(context).primary,
          automaticallyImplyLeading: false,
          leading: FlutterFlowIconButton(
            borderColor: Colors.transparent,
            borderRadius: 30,
            borderWidth: 1,
            buttonSize: 60,
            icon: Icon(
              Icons.arrow_back_rounded,
              color: AppTheme.of(context).primaryText,
              size: 30,
            ),
            onPressed: () async {
              Get.back();
            },
          ),
          title: Text(
            'Event Details',
            style: AppTheme.of(context).titleLarge.overriden(
              fontFamily: 'Roboto Mono',
              letterSpacing: 0,
            ),
          ),
          actions: const [],
          centerTitle: true,
          elevation: 2,
        ),
        body: FutureBuilder(
          future: _model.getDetails(data),
          builder: (context, snapshot) {
            if(snapshot.hasData && snapshot.connectionState == ConnectionState.done && snapshot.data != null) {
              var details = snapshot.data;

              if(details?['entryFee'] != null && details!['entryFee'].toString().isNotEmpty) {
                _model.feesTextController.text = details['entryFee'];
              } else {
                _model.feesTextController.text = "Free for All";
              }

              if(details?['formLink'] != null && details!['formLink'].toString().isNotEmpty) {
                _model.formlinkTextController.text = details['formLink'];
              }
              if(details?['feedbackLink'] != null && details!['feedbackLink'].toString().isNotEmpty) {
                _model.feedbacklinkTextController.text = details['feedbackLink'];
              }
              return SafeArea(
                top: true,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                              child: Container(
                                width: double.infinity,
                                constraints: const BoxConstraints(
                                  maxWidth: 570,
                                ),
                                decoration: BoxDecoration(
                                  color: AppTheme.of(context)
                                      .secondaryBackground,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Padding(
                                  padding:
                                  const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(2),
                                        child: FullScreenWidget(
                                          disposeLevel: DisposeLevel.Medium,
                                          child: Center(
                                            child: Hero(
                                              tag: "Full Screen Image",
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.circular(10),
                                                child: FadeInImage(
                                                  placeholder: const AssetImage('assets/images/image-placeholder.jpg'),
                                                  image: NetworkImage(details?['image']), // Network image to load
                                                  width: double.infinity,
                                                  height: 230,
                                                  fit: BoxFit.fitHeight,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                            0, 8, 0, 0),
                                        child: Text(
                                          details?['title'] ?? 'Event Title',
                                          style: AppTheme.of(context)
                                              .headlineSmall
                                              .overriden(
                                            fontFamily: 'Roboto Mono',
                                            letterSpacing: 0,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                            0, 4, 0, 0),
                                        child: Text(
                                          customDateFormat.format(DateTime.parse(details?['dateTime'])),
                                          style: AppTheme.of(context)
                                              .bodyMedium
                                              .overriden(
                                            fontFamily: 'Roboto Mono',
                                            color: AppTheme.of(context)
                                                .primary,
                                            letterSpacing: 0,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                                        child: Container(
                                          width: double.infinity,
                                          color:
                                          AppTheme.of(context).secondaryBackground,
                                          child: ExpandableNotifier(
                                            controller: _model.expandableExpandableController,
                                            child: ExpandablePanel(
                                              header: Padding(
                                                padding:
                                                const EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                                                child: Text(
                                                  'Want to know more about event?',
                                                  style: AppTheme.of(context)
                                                      .headlineMedium
                                                      .overriden(
                                                    fontFamily: 'PT Sans',
                                                    letterSpacing: 0,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                              collapsed: Container(
                                                width: MediaQuery.sizeOf(context).width,
                                                height: 60,
                                                decoration: BoxDecoration(
                                                  color: AppTheme.of(context)
                                                      .secondaryBackground,
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                                      0, 8, 0, 0),
                                                  child: Text(
                                                    'Click for more...',
                                                    style: AppTheme.of(context)
                                                        .labelMedium
                                                        .overriden(
                                                      fontFamily: 'Roboto Mono',
                                                      letterSpacing: 0,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              expanded: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                                        0, 8, 0, 12),
                                                    child: Text(
                                                      details?['description'] ?? 'This section is to hold the event description.',
                                                      style: AppTheme.of(context)
                                                          .labelMedium
                                                          .overriden(
                                                        fontFamily: 'Roboto Mono',
                                                        letterSpacing: 0,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              theme: const ExpandableThemeData(
                                                tapHeaderToExpand: true,
                                                tapBodyToExpand: true,
                                                tapBodyToCollapse: true,
                                                headerAlignment:
                                                ExpandablePanelHeaderAlignment.center,
                                                hasIcon: false,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      // Padding(
                                      //   padding: const EdgeInsetsDirectional.fromSTEB(
                                      //       0, 8, 0, 12),
                                      //   child: Text(
                                      //     details?['description'] ?? 'Event Description.',
                                      //     style: AppTheme.of(context)
                                      //         .labelMedium
                                      //         .overriden(
                                      //       fontFamily: 'Roboto Mono',
                                      //       letterSpacing: 0,
                                      //     ),
                                      //   ),
                                      // ),
                                      Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                            0, 0, 0, 12),
                                        child: Container(
                                          width: double.infinity,
                                          constraints: const BoxConstraints(
                                            maxWidth: 570,
                                          ),
                                          decoration: BoxDecoration(
                                            color: AppTheme.of(context)
                                                .secondaryBackground,
                                            borderRadius: BorderRadius.circular(12),
                                            border: Border.all(
                                              color: AppTheme.of(context)
                                                  .alternate,
                                              width: 1,
                                            ),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(16),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding:
                                                  const EdgeInsetsDirectional.fromSTEB(
                                                      0, 0, 16, 4),
                                                  child: Text(
                                                    'Event Location',
                                                    style:
                                                    AppTheme.of(context)
                                                        .labelMedium
                                                        .overriden(
                                                      fontFamily:
                                                      'Roboto Mono',
                                                      letterSpacing: 0,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                  const EdgeInsetsDirectional.fromSTEB(
                                                      0, 0, 0, 4),
                                                  child: Text(
                                                    details?['location'] ?? 'Event Location.',
                                                    style:
                                                    AppTheme.of(context)
                                                        .titleLarge
                                                        .overriden(
                                                      fontFamily:
                                                      'Roboto Mono',
                                                      letterSpacing: 0,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      if(details?['speakers'] != null && details!['speakers'].toString().isNotEmpty)
                                        Padding(
                                          padding: const EdgeInsetsDirectional.fromSTEB(
                                              16, 12, 0, 0),
                                          child: Text(
                                            'Featured Speakers',
                                            style: AppTheme.of(context)
                                                .labelLarge
                                                .overriden(
                                              fontFamily: 'Roboto Mono',
                                              letterSpacing: 0,
                                            ),
                                          ),
                                        ),
                                      if(details?['speakers'] != null && details!['speakers'].toString().isNotEmpty)
                                        Builder(
                                        builder: (context) {
                                          final speakers = details['speakers'].toString().split("\n");

                                          return Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: List.generate(speakers.length,
                                                    (speakersIndex) {
                                                  final speakersItem =
                                                  speakers[speakersIndex];
                                                  debugPrint(speakersItem);
                                                  return SpeakerWidget(
                                                    key: Key(
                                                        'Keyesz_${speakersIndex}_of_${speakers.length}'),
                                                    name: speakersItem,
                                                  );
                                                }),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Divider(
                              height: 12,
                              thickness: 1,
                              color: AppTheme.of(context).alternate,
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
                              child: Text(
                                'Registration',
                                style:
                                AppTheme.of(context).labelLarge.overriden(
                                  fontFamily: 'Roboto Mono',
                                  letterSpacing: 0,
                                ),
                              ),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding:
                                    const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
                                    child: TextFormField(
                                      controller: _model.formlinkTextController,
                                      focusNode: _model.formlinkFocusNode,
                                      textCapitalization: TextCapitalization.none,
                                      readOnly: true,
                                      obscureText: false,
                                      decoration: InputDecoration(
                                        isDense: false,
                                        labelText: 'Registration Form Link',
                                        labelStyle: AppTheme.of(context)
                                            .labelMedium
                                            .overriden(
                                          fontFamily: 'Roboto Mono',
                                          letterSpacing: 0,
                                        ),
                                        alignLabelWithHint: false,
                                        hintStyle: AppTheme.of(context)
                                            .labelMedium
                                            .overriden(
                                          fontFamily: 'Roboto Mono',
                                          letterSpacing: 0,
                                        ),
                                        errorStyle: AppTheme.of(context)
                                            .bodyMedium
                                            .overriden(
                                          fontFamily: 'Roboto Mono',
                                          color:
                                          AppTheme.of(context).error,
                                          fontSize: 14,
                                          letterSpacing: 0,
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: AppTheme.of(context)
                                                .alternate,
                                            width: 2,
                                          ),
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color:
                                            AppTheme.of(context).primary,
                                            width: 2,
                                          ),
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: AppTheme.of(context).error,
                                            width: 2,
                                          ),
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: AppTheme.of(context).error,
                                            width: 2,
                                          ),
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        filled: true,
                                        fillColor: AppTheme.of(context)
                                            .secondaryBackground,
                                        contentPadding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            20, 24, 0, 24),
                                      ),
                                      style: AppTheme.of(context)
                                          .bodyMedium
                                          .overriden(
                                        fontFamily: 'Roboto Mono',
                                        fontSize: 14,
                                        letterSpacing: 0,
                                      ),
                                      textAlign: TextAlign.start,
                                      keyboardType: TextInputType.url,
                                      validator: _model
                                          .formlinkTextControllerValidator
                                          .asValidator(context),
                                    ),
                                  ),
                                ),
                                FlutterFlowIconButton(
                                  borderColor: AppTheme.of(context).primary,
                                  borderRadius: 20,
                                  borderWidth: 1,
                                  buttonSize: 40,
                                  fillColor: AppTheme.of(context).accent1,
                                  icon: Icon(
                                    Icons.launch_outlined,
                                    color: AppTheme.of(context).primaryText,
                                    size: 24,
                                  ),
                                  onPressed: () async {
                                    await launchUrl(Uri.parse(_model.formlinkTextController.text));
                                  },
                                ),
                              ]
                                  .divide(const SizedBox(width: 20))
                                  .around(const SizedBox(width: 20)),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding:
                                    const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
                                    child: TextFormField(
                                      controller: _model.feedbacklinkTextController,
                                      focusNode: _model.feedbacklinkFocusNode,
                                      textCapitalization: TextCapitalization.none,
                                      readOnly: true,
                                      obscureText: false,
                                      decoration: InputDecoration(
                                        isDense: false,
                                        labelText: 'Feedback Form Link',
                                        labelStyle: AppTheme.of(context)
                                            .labelMedium
                                            .overriden(
                                          fontFamily: 'Roboto Mono',
                                          letterSpacing: 0,
                                        ),
                                        alignLabelWithHint: false,
                                        hintStyle: AppTheme.of(context)
                                            .labelMedium
                                            .overriden(
                                          fontFamily: 'Roboto Mono',
                                          letterSpacing: 0,
                                        ),
                                        errorStyle: AppTheme.of(context)
                                            .bodyMedium
                                            .overriden(
                                          fontFamily: 'Roboto Mono',
                                          color:
                                          AppTheme.of(context).error,
                                          fontSize: 14,
                                          letterSpacing: 0,
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: AppTheme.of(context)
                                                .alternate,
                                            width: 2,
                                          ),
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color:
                                            AppTheme.of(context).primary,
                                            width: 2,
                                          ),
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: AppTheme.of(context).error,
                                            width: 2,
                                          ),
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: AppTheme.of(context).error,
                                            width: 2,
                                          ),
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        filled: true,
                                        fillColor: AppTheme.of(context)
                                            .secondaryBackground,
                                        contentPadding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            20, 24, 0, 24),
                                      ),
                                      style: AppTheme.of(context)
                                          .bodyMedium
                                          .overriden(
                                        fontFamily: 'Roboto Mono',
                                        fontSize: 14,
                                        letterSpacing: 0,
                                      ),
                                      textAlign: TextAlign.start,
                                      keyboardType: TextInputType.url,
                                      validator: _model
                                          .feedbacklinkTextControllerValidator
                                          .asValidator(context),
                                    ),
                                  ),
                                ),
                                FlutterFlowIconButton(
                                  borderColor: AppTheme.of(context).primary,
                                  borderRadius: 20,
                                  borderWidth: 1,
                                  buttonSize: 40,
                                  fillColor: AppTheme.of(context).accent1,
                                  icon: Icon(
                                    Icons.launch_outlined,
                                    color: AppTheme.of(context).primaryText,
                                    size: 24,
                                  ),
                                  onPressed: () async {
                                    await launchUrl(Uri.parse(_model.feedbacklinkTextController.text));
                                  },
                                ),
                              ]
                                  .divide(const SizedBox(width: 20))
                                  .around(const SizedBox(width: 20)),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding:
                                    const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
                                    child: TextFormField(
                                      controller: _model.feesTextController,
                                      focusNode: _model.feesFocusNode,
                                      textCapitalization: TextCapitalization.words,
                                      readOnly: true,
                                      obscureText: false,
                                      decoration: InputDecoration(
                                        isDense: false,
                                        labelText: 'Only for Non-Members.',
                                        labelStyle: AppTheme.of(context)
                                            .labelMedium
                                            .overriden(
                                          fontFamily: 'Roboto Mono',
                                          letterSpacing: 0,
                                        ),
                                        alignLabelWithHint: false,
                                        hintStyle: AppTheme.of(context)
                                            .labelMedium
                                            .overriden(
                                          fontFamily: 'Roboto Mono',
                                          letterSpacing: 0,
                                        ),
                                        errorStyle: AppTheme.of(context)
                                            .bodyMedium
                                            .overriden(
                                          fontFamily: 'Roboto Mono',
                                          color:
                                          AppTheme.of(context).error,
                                          fontSize: 14,
                                          letterSpacing: 0,
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: AppTheme.of(context)
                                                .alternate,
                                            width: 2,
                                          ),
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color:
                                            AppTheme.of(context).primary,
                                            width: 2,
                                          ),
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: AppTheme.of(context).error,
                                            width: 2,
                                          ),
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: AppTheme.of(context).error,
                                            width: 2,
                                          ),
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        filled: true,
                                        fillColor: AppTheme.of(context)
                                            .secondaryBackground,
                                        contentPadding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            20, 24, 0, 24),
                                      ),
                                      style: AppTheme.of(context)
                                          .bodyMedium
                                          .overriden(
                                        fontFamily: 'Roboto Mono',
                                        fontSize: 14,
                                        letterSpacing: 0,
                                      ),
                                      textAlign: TextAlign.start,
                                      validator: _model.feesTextControllerValidator
                                          .asValidator(context),
                                    ),
                                  ),
                                ),
                                FlutterFlowIconButton(
                                  borderColor: AppTheme.of(context).primary,
                                  borderRadius: 20,
                                  borderWidth: 1,
                                  buttonSize: 40,
                                  fillColor: AppTheme.of(context).accent1,
                                  icon: Icon(
                                    Icons.currency_rupee_rounded,
                                    color: AppTheme.of(context).primaryText,
                                    size: 24,
                                  ),
                                  onPressed: () async {
                                    Navigator.pop(context);
                                  },
                                ),
                              ]
                                  .divide(const SizedBox(width: 20))
                                  .around(const SizedBox(width: 20)),
                            ),
                            Divider(
                              height: 12,
                              thickness: 1,
                              color: AppTheme.of(context).alternate,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
            
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
