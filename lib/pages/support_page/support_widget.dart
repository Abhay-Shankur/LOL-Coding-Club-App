import 'package:app/utils/theme.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart' as smooth_page_indicator;
import 'package:flutter/material.dart';

import 'support_model.dart';
export 'support_model.dart';

class SupportWidget extends StatefulWidget {
  const SupportWidget({super.key});

  @override
  State<SupportWidget> createState() => _SupportWidgetState();
}

class _SupportWidgetState extends State<SupportWidget> {
  late SupportModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SupportModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: AppTheme.of(context).primaryBackground,
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
            'Get Support',
            style: AppTheme.of(context).headlineMedium.overriden(
              fontFamily: 'Roboto Mono',
              color: AppTheme.of(context).primaryText,
              fontSize: 22,
              letterSpacing: 0,
            ),
          ),
          actions: const [],
          centerTitle: true,
          elevation: 2,
        ),
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: SizedBox(
                  width: double.infinity,
                  height: 500,
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 30),
                        child: PageView(
                          controller: _model.pageViewController ??=
                              PageController(initialPage: 0),
                          scrollDirection: Axis.horizontal,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                          0, 0, 0, 12),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: Image.asset(
                                          'assets/terms/developer.jpg',
                                          width: double.infinity,
                                          height: 300,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        12, 0, 0, 0),
                                    child: Text(
                                      'Abhay Shankur',
                                      style: AppTheme.of(context)
                                          .headlineLarge
                                          .overriden(
                                        fontFamily: 'PT Sans',
                                        letterSpacing: 0,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        12, 4, 12, 0),
                                    child: Text(
                                      'The LOL Coding Club app is crafted with a passion for Flutter development to streamline event management and enhance your club experience. Feel free to reach out with any feedback or questions!',
                                      style: AppTheme.of(context)
                                          .labelLarge
                                          .overriden(
                                        fontFamily: 'Roboto Mono',
                                        letterSpacing: 0,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(24),
                                    child: Wrap(
                                      spacing: 16,
                                      runSpacing: 16,
                                      alignment: WrapAlignment.start,
                                      crossAxisAlignment:
                                      WrapCrossAlignment.start,
                                      direction: Axis.horizontal,
                                      runAlignment: WrapAlignment.start,
                                      verticalDirection: VerticalDirection.down,
                                      clipBehavior: Clip.none,
                                      children: [
                                        FFButtonWidget(
                                          onPressed: () async {
                                            // Navigator.pop(context);
                                            await _model.sendEmail("abhayshankur1@gmail.com");
                                          },
                                          text: 'Contact',
                                          options: FFButtonOptions(
                                            width: 150,
                                            height: 50,
                                            padding:
                                            const EdgeInsetsDirectional.fromSTEB(
                                                0, 0, 0, 0),
                                            iconPadding:
                                            const EdgeInsetsDirectional.fromSTEB(
                                                0, 0, 0, 0),
                                            color: AppTheme.of(context)
                                                .secondaryBackground,
                                            textStyle:
                                            AppTheme.of(context)
                                                .titleSmall
                                                .overriden(
                                              fontFamily: 'Roboto Mono',
                                              color:
                                              AppTheme.of(
                                                  context)
                                                  .primaryText,
                                              letterSpacing: 0,
                                            ),
                                            elevation: 2,
                                            borderSide: const BorderSide(
                                              color: Colors.transparent,
                                              width: 1,
                                            ),
                                            borderRadius:
                                            BorderRadius.circular(50),
                                          ),
                                        ),
                                        FFButtonWidget(
                                          onPressed: () async {
                                            // Navigator.pop(context);
                                            _model.launchLinkedIn("www.linkedin.com/in/abhayshankur");
                                          },
                                          text: 'Linkedin',
                                          options: FFButtonOptions(
                                            width: 150,
                                            height: 50,
                                            padding:
                                            const EdgeInsetsDirectional.fromSTEB(
                                                0, 0, 0, 0),
                                            iconPadding:
                                            const EdgeInsetsDirectional.fromSTEB(
                                                0, 0, 0, 0),
                                            color: AppTheme.of(context)
                                                .primaryText,
                                            textStyle:
                                            AppTheme.of(context)
                                                .titleSmall
                                                .overriden(
                                              fontFamily: 'Roboto Mono',
                                              color: AppTheme
                                                  .of(context)
                                                  .secondaryBackground,
                                              letterSpacing: 0,
                                            ),
                                            elevation: 2,
                                            borderSide: const BorderSide(
                                              color: Colors.transparent,
                                              width: 1,
                                            ),
                                            borderRadius:
                                            BorderRadius.circular(40),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                          0, 0, 0, 12),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: Image.asset(
                                          'assets/terms/developer.jpg',
                                          width: double.infinity,
                                          height: 300,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        12, 0, 0, 0),
                                    child: Text(
                                      'Nikhilkumar Jain',
                                      style: AppTheme.of(context)
                                          .headlineLarge
                                          .overriden(
                                        fontFamily: 'PT Sans',
                                        letterSpacing: 0,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        12, 4, 12, 0),
                                    child: Text(
                                      'The LOL Coding Club app is crafted with a passion for Flutter development to streamline event management and enhance your club experience. Feel free to reach out with any feedback or questions!',
                                      style: AppTheme.of(context)
                                          .labelLarge
                                          .overriden(
                                        fontFamily: 'Roboto Mono',
                                        letterSpacing: 0,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(24),
                                    child: Wrap(
                                      spacing: 16,
                                      runSpacing: 16,
                                      alignment: WrapAlignment.start,
                                      crossAxisAlignment:
                                      WrapCrossAlignment.start,
                                      direction: Axis.horizontal,
                                      runAlignment: WrapAlignment.start,
                                      verticalDirection: VerticalDirection.down,
                                      clipBehavior: Clip.none,
                                      children: [
                                        FFButtonWidget(
                                          onPressed: () async {
                                            // Navigator.pop(context);
                                            await _model.sendEmail("nikhilkumar1514@gmail.com");
                                          },
                                          text: 'Contact',
                                          options: FFButtonOptions(
                                            width: 150,
                                            height: 50,
                                            padding:
                                            const EdgeInsetsDirectional.fromSTEB(
                                                0, 0, 0, 0),
                                            iconPadding:
                                            const EdgeInsetsDirectional.fromSTEB(
                                                0, 0, 0, 0),
                                            color: AppTheme.of(context)
                                                .secondaryBackground,
                                            textStyle:
                                            AppTheme.of(context)
                                                .titleSmall
                                                .overriden(
                                              fontFamily: 'Roboto Mono',
                                              color:
                                              AppTheme.of(
                                                  context)
                                                  .primaryText,
                                              letterSpacing: 0,
                                            ),
                                            elevation: 2,
                                            borderSide: const BorderSide(
                                              color: Colors.transparent,
                                              width: 1,
                                            ),
                                            borderRadius:
                                            BorderRadius.circular(50),
                                          ),
                                        ),
                                        FFButtonWidget(
                                          onPressed: () async {
                                            // Navigator.pop(context);
                                            _model.launchLinkedIn("www.linkedin.com/in/nikhilkumar-jain2411");
                                          },
                                          text: 'Linkedin',
                                          options: FFButtonOptions(
                                            width: 150,
                                            height: 50,
                                            padding:
                                            const EdgeInsetsDirectional.fromSTEB(
                                                0, 0, 0, 0),
                                            iconPadding:
                                            const EdgeInsetsDirectional.fromSTEB(
                                                0, 0, 0, 0),
                                            color: AppTheme.of(context)
                                                .primaryText,
                                            textStyle:
                                            AppTheme.of(context)
                                                .titleSmall
                                                .overriden(
                                              fontFamily: 'Roboto Mono',
                                              color: AppTheme
                                                  .of(context)
                                                  .secondaryBackground,
                                              letterSpacing: 0,
                                            ),
                                            elevation: 2,
                                            borderSide: const BorderSide(
                                              color: Colors.transparent,
                                              width: 1,
                                            ),
                                            borderRadius:
                                            BorderRadius.circular(40),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Align(
                        alignment: const AlignmentDirectional(0, 1),
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                          child: smooth_page_indicator.SmoothPageIndicator(
                            controller: _model.pageViewController ??=
                                PageController(initialPage: 0),
                            count: 2,
                            axisDirection: Axis.horizontal,
                            onDotClicked: (i) async {
                              await _model.pageViewController!.animateToPage(
                                i,
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.ease,
                              );
                              setState(() {});
                            },
                            effect: smooth_page_indicator.ExpandingDotsEffect(
                              expansionFactor: 2,
                              spacing: 8,
                              radius: 16,
                              dotWidth: 16,
                              dotHeight: 4,
                              dotColor: AppTheme.of(context).alternate,
                              activeDotColor:
                              AppTheme.of(context).primaryText,
                              paintStyle: PaintingStyle.fill,
                            ),
                          ),
                        ),
                      ),
                    ],
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
