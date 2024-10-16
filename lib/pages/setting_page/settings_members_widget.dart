import 'package:app/main.dart';
import 'package:app/providers/profile_provider.dart';
import 'package:app/utils/constants.dart';
import 'package:app/utils/routes.dart';
import 'package:app/utils/theme.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '/pages/components/q_r_component/q_r_component_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'settings_members_model.dart';
export 'settings_members_model.dart';

class SettingsMembersWidget extends StatefulWidget {
  const SettingsMembersWidget({super.key});

  @override
  State<SettingsMembersWidget> createState() => _SettingsMembersWidgetState();
}

class _SettingsMembersWidgetState extends State<SettingsMembersWidget>
    with TickerProviderStateMixin {
  late SettingsMembersModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SettingsMembersModel());

    animationsMap.addAll({
      'buttonOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          VisibilityEffect(duration: 400.ms),
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 400.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
          MoveEffect(
            curve: Curves.easeInOut,
            delay: 400.0.ms,
            duration: 600.0.ms,
            begin: const Offset(0.0, 60.0),
            end: const Offset(0.0, 0.0),
          ),
        ],
      ),
    });
    setupAnimations(
      animationsMap.values.where((anim) =>
      anim.trigger == AnimationTrigger.onActionTrigger ||
          !anim.applyInitialState),
      this,
    );
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
        backgroundColor: AppTheme.of(context).primaryBackground,
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 250,
                child: Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 250,
                      decoration: BoxDecoration(
                        color: AppTheme.of(context).secondaryBackground,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: Image.asset(
                            'assets/images/LOLBadgeFull.png',
                          ).image,
                        ),
                      ),
                    ),
                    Align(
                      alignment: const AlignmentDirectional(-1, 1),
                      child: Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(12, 0, 0, 5),
                        child: Container(
                          width: 120,
                          height: 120,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          alignment: const AlignmentDirectional(0, 0),
                          child: SizedBox(
                            width: 140,
                            child: Stack(
                              children: [
                                Align(
                                  alignment: const AlignmentDirectional(0, 0),
                                  child: Container(
                                    width: 90,
                                    height: 90,
                                    decoration: BoxDecoration(
                                      color: AppTheme.of(context).accent2,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: AppTheme.of(context)
                                            .secondary,
                                        width: 2,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(2),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(50),
                                        child: Consumer<ProfileProvider> (
                                          builder: (_, consumer, __) {
                                            return FadeInImage(
                                              placeholder: const AssetImage('assets/images/image-placeholder.jpg'),
                                              image: NetworkImage(
                                                  consumer.profile?.image ?? 'https://images.unsplash.com/photo-1633332755192-727a05c4013d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8dXNlcnxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=900&q=60'
                                              ), // Network image to load
                                              width: 90,
                                              height: 90,
                                              fit: BoxFit.cover,
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: const AlignmentDirectional(1, 1),
                                  child: Builder(
                                    builder: (context) => InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        await showDialog(
                                          context: context,
                                          builder: (dialogContext) {
                                            return Dialog(
                                              elevation: 0,
                                              insetPadding: EdgeInsets.zero,
                                              backgroundColor: Colors.transparent,
                                              alignment: const AlignmentDirectional(
                                                  0, 0)
                                                  .resolve(
                                                  Directionality.of(context)),
                                              child: GestureDetector(
                                                onTap: () => _model.unfocusNode
                                                    .canRequestFocus
                                                    ? FocusScope.of(context)
                                                    .requestFocus(
                                                    _model.unfocusNode)
                                                    : FocusScope.of(context)
                                                    .unfocus(),
                                                child: const SizedBox(
                                                  height: 300,
                                                  width: 300,
                                                  child: QRComponentWidget(),
                                                ),
                                              ),
                                            );
                                          },
                                        ).then((value) => setState(() {}));
                                      },
                                      child: ClipOval(
                                        child: Container(
                                          width: 44,
                                          height: 44,
                                          decoration: BoxDecoration(
                                            color: AppTheme.of(context)
                                                .secondaryBackground,
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              color: AppTheme.of(context)
                                                  .secondaryText,
                                              width: 4,
                                            ),
                                          ),
                                          alignment: const AlignmentDirectional(1, 1),
                                          child: Padding(
                                            padding: const EdgeInsets.all(4),
                                            child: ClipRRect(
                                              borderRadius:
                                              BorderRadius.circular(50),
                                              child: Image.asset(
                                                'assets/images/qr-image.jpg',
                                                width: 100,
                                                height: 100,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: const AlignmentDirectional(1, 1),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Card(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          color: AppTheme.of(context).secondaryBackground,
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(4),
                            child: FlutterFlowIconButton(
                              borderColor: AppTheme.of(context).primary,
                              borderRadius: 20,
                              borderWidth: 1,
                              buttonSize: 40,
                              fillColor: AppTheme.of(context).primary,
                              icon: Icon(
                                Icons.workspace_premium_rounded,
                                color: AppTheme.of(context).info,
                                size: 24,
                              ),
                              onPressed: () {
                                debugPrint('IconButton pressed ...');
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Consumer<ProfileProvider>(
                  builder: (_, consumer, __) {
                    return Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(24, 0, 0, 0),
                      child: Text(
                        consumer.profile?.name ?? 'LOL Member.',
                        maxLines: 1,
                        style: AppTheme.of(context).headlineLarge.overriden(
                          fontFamily: 'Roboto Mono',
                          letterSpacing: 0,
                        ),
                      ),
                    );
                  }
              ),
              Consumer<ProfileProvider>(
                  builder: (_, consumer, __){
                    return Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(24, 4, 0, 16),
                      child: Text(
                        consumer.profile?.email ?? 'example@lol.com',
                        style: AppTheme.of(context).labelMedium.overriden(
                          fontFamily: 'Roboto Mono',
                          letterSpacing: 0,
                        ),
                      ),
                    );
                  }
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(24, 4, 0, 0),
                child: Text(
                  'Your Account',
                  style: AppTheme.of(context).labelMedium.overriden(
                    fontFamily: 'Roboto Mono',
                    letterSpacing: 0,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
                child: InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    Get.toNamed(GetRoutes.profile);
                  },
                  child: Container(
                    width: double.infinity,
                    height: 60,
                    decoration: BoxDecoration(
                      color: AppTheme.of(context).secondaryBackground,
                      boxShadow: const [
                        BoxShadow(
                          blurRadius: 3,
                          color: Color(0x33000000),
                          offset: Offset(
                            0,
                            1,
                          ),
                        )
                      ],
                      borderRadius: BorderRadius.circular(8),
                      shape: BoxShape.rectangle,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Icon(
                            Icons.account_circle_outlined,
                            color: AppTheme.of(context).secondaryText,
                            size: 24,
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                            child: Text(
                              'Profile',
                              style: AppTheme.of(context)
                                  .labelLarge
                                  .overriden(
                                fontFamily: 'Roboto Mono',
                                letterSpacing: 0,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Align(
                              alignment: const AlignmentDirectional(0.9, 0),
                              child: Icon(
                                Icons.arrow_forward_ios,
                                color: AppTheme.of(context).secondaryText,
                                size: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              // Padding(
              //   padding: const EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
              //   child: InkWell(
              //     splashColor: Colors.transparent,
              //     focusColor: Colors.transparent,
              //     hoverColor: Colors.transparent,
              //     highlightColor: Colors.transparent,
              //     onTap: () async {
              //       Get.toNamed(GetRoutes.notificationList);
              //     },
              //     child: Container(
              //       width: double.infinity,
              //       height: 60,
              //       decoration: BoxDecoration(
              //         color: AppTheme.of(context).secondaryBackground,
              //         boxShadow: const [
              //           BoxShadow(
              //             blurRadius: 3,
              //             color: Color(0x33000000),
              //             offset: Offset(
              //               0,
              //               1,
              //             ),
              //           )
              //         ],
              //         borderRadius: BorderRadius.circular(8),
              //         shape: BoxShape.rectangle,
              //       ),
              //       child: Padding(
              //         padding: const EdgeInsets.all(12),
              //         child: Row(
              //           mainAxisSize: MainAxisSize.max,
              //           children: [
              //             Icon(
              //               Icons.notifications_none,
              //               color: AppTheme.of(context).secondaryText,
              //               size: 24,
              //             ),
              //             Padding(
              //               padding: const EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
              //               child: Text(
              //                 'Notifications',
              //                 style:
              //                 AppTheme.of(context).labelLarge.overriden(
              //                   fontFamily: 'Roboto Mono',
              //                   letterSpacing: 0,
              //                 ),
              //               ),
              //             ),
              //             Expanded(
              //               child: Align(
              //                 alignment: const AlignmentDirectional(0.9, 0),
              //                 child: Icon(
              //                   Icons.arrow_forward_ios,
              //                   color: AppTheme.of(context).secondaryText,
              //                   size: 18,
              //                 ),
              //               ),
              //             ),
              //           ],
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
                child: InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    //TODO: Forum is blocked for version 1.0.4
                    showSnackbar(context, "Coming Soon...");
                    // Get.toNamed(GetRoutes.chatPage);
                  },
                  child: Container(
                    width: double.infinity,
                    height: 60,
                    decoration: BoxDecoration(
                      color: AppTheme.of(context).secondaryBackground,
                      boxShadow: const [
                        BoxShadow(
                          blurRadius: 3,
                          color: Color(0x33000000),
                          offset: Offset(
                            0,
                            1,
                          ),
                        )
                      ],
                      borderRadius: BorderRadius.circular(8),
                      shape: BoxShape.rectangle,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Icon(
                            Icons.notifications_none,
                            color: AppTheme.of(context).secondaryText,
                            size: 24,
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                            child: Text(
                              'Forum',
                              style:
                              AppTheme.of(context).labelLarge.overriden(
                                fontFamily: 'Roboto Mono',
                                letterSpacing: 0,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Align(
                              alignment: const AlignmentDirectional(0.9, 0),
                              child: Icon(
                                Icons.arrow_forward_ios,
                                color: AppTheme.of(context).secondaryText,
                                size: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(24, 16, 0, 0),
                child: Text(
                  'App Settings',
                  style: AppTheme.of(context).labelMedium.overriden(
                    fontFamily: 'Roboto Mono',
                    letterSpacing: 0,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
                child: InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    Get.toNamed(GetRoutes.supportPage);
                  },
                  child: Container(
                    width: double.infinity,
                    height: 60,
                    decoration: BoxDecoration(
                      color: AppTheme.of(context).secondaryBackground,
                      boxShadow: const [
                        BoxShadow(
                          blurRadius: 3,
                          color: Color(0x33000000),
                          offset: Offset(
                            0,
                            1,
                          ),
                        )
                      ],
                      borderRadius: BorderRadius.circular(8),
                      shape: BoxShape.rectangle,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Icon(
                            Icons.help_outline_rounded,
                            color: AppTheme.of(context).secondaryText,
                            size: 24,
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                            child: Text(
                              'Support',
                              style:
                              AppTheme.of(context).labelLarge.overriden(
                                fontFamily: 'Roboto Mono',
                                letterSpacing: 0,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Align(
                              alignment: const AlignmentDirectional(0.9, 0),
                              child: Icon(
                                Icons.arrow_forward_ios,
                                color: AppTheme.of(context).secondaryText,
                                size: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
                child: InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    Get.toNamed(GetRoutes.termsPage);
                  },
                  child: Container(
                    width: double.infinity,
                    height: 60,
                    decoration: BoxDecoration(
                      color: AppTheme.of(context).secondaryBackground,
                      boxShadow: const [
                        BoxShadow(
                          blurRadius: 3,
                          color: Color(0x33000000),
                          offset: Offset(
                            0,
                            1,
                          ),
                        )
                      ],
                      borderRadius: BorderRadius.circular(8),
                      shape: BoxShape.rectangle,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Icon(
                            Icons.privacy_tip_rounded,
                            color: AppTheme.of(context).secondaryText,
                            size: 24,
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                            child: Text(
                              'Terms of Service',
                              style:
                              AppTheme.of(context).labelLarge.overriden(
                                fontFamily: 'Roboto Mono',
                                letterSpacing: 0,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Align(
                              alignment: const AlignmentDirectional(0.9, 0),
                              child: Icon(
                                Icons.arrow_forward_ios,
                                color: AppTheme.of(context).secondaryText,
                                size: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(16, 4, 0, 8),
                    child: Text(
                      'Follow us on',
                      style: AppTheme.of(context).labelMedium.overriden(
                        fontFamily: 'Roboto Mono',
                        letterSpacing: 0,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        FlutterFlowIconButton(
                          borderColor: AppTheme.of(context).alternate,
                          borderRadius: 12,
                          borderWidth: 1,
                          buttonSize: 48,
                          fillColor: AppTheme.of(context).secondaryBackground,
                          icon: FaIcon(
                            FontAwesomeIcons.globe,
                            color: AppTheme.of(context).secondaryText,
                            size: 24,
                          ),
                          showLoadingIndicator: true,
                          onPressed: () async {
                            await launchUrl(Uri.parse(GlobalConstants.websiteLink));
                          },
                        ),
                        FlutterFlowIconButton(
                          borderColor: AppTheme.of(context).alternate,
                          borderRadius: 12,
                          borderWidth: 1,
                          buttonSize: 48,
                          fillColor: AppTheme.of(context).secondaryBackground,
                          icon: FaIcon(
                            FontAwesomeIcons.discord,
                            color: AppTheme.of(context).secondaryText,
                            size: 24,
                          ),
                          showLoadingIndicator: true,
                          onPressed: () async {
                            await launchUrl(Uri.parse(GlobalConstants.discordLink));
                          },
                        ),
                        FlutterFlowIconButton(
                          borderColor: AppTheme.of(context).alternate,
                          borderRadius: 12,
                          borderWidth: 1,
                          buttonSize: 48,
                          fillColor: AppTheme.of(context).secondaryBackground,
                          icon: FaIcon(
                            FontAwesomeIcons.instagram,
                            color: AppTheme.of(context).secondaryText,
                            size: 24,
                          ),
                          showLoadingIndicator: true,
                          onPressed: () async {
                            await launchUrl(Uri.parse(GlobalConstants.instagramLink));
                          },
                        ),
                        FlutterFlowIconButton(
                          borderColor: AppTheme.of(context).alternate,
                          borderRadius: 12,
                          borderWidth: 1,
                          buttonSize: 48,
                          fillColor: AppTheme.of(context).secondaryBackground,
                          icon: FaIcon(
                            FontAwesomeIcons.linkedin,
                            color: AppTheme.of(context).secondaryText,
                            size: 24,
                          ),
                          showLoadingIndicator: true,
                          onPressed: () async {
                            await launchUrl(Uri.parse(GlobalConstants.linkedInLink));
                          },
                        ),
                        FlutterFlowIconButton(
                          borderColor: AppTheme.of(context).alternate,
                          borderRadius: 12,
                          borderWidth: 1,
                          buttonSize: 48,
                          fillColor: AppTheme.of(context).secondaryBackground,
                          icon: FaIcon(
                            FontAwesomeIcons.hashtag,
                            color: AppTheme.of(context).secondaryText,
                            size: 24,
                          ),
                          showLoadingIndicator: true,
                          onPressed: () async {
                            await launchUrl(Uri.parse(GlobalConstants.hashNodeLink));
                          },
                        ),
                      ].divide(const SizedBox(width: 8)),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(24, 20, 0, 10),
                child: Text(
                  'Version: ${packageInfo.version}',
                  style: AppTheme.of(context).labelMedium.overriden(
                    fontFamily: 'Roboto Mono',
                    letterSpacing: 0,
                  ),
                ),
              ),
              Align(
                alignment: const AlignmentDirectional(0, 0),
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 24, 0, 0),
                  child: FFButtonWidget(
                    onPressed: () async {
                      await _model.logOut();
                    },
                    text: 'Log Out',
                    options: FFButtonOptions(
                      width: 150,
                      height: 44,
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                      iconPadding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                      color: AppTheme.of(context).primaryBackground,
                      textStyle: AppTheme.of(context).bodyMedium.overriden(
                        fontFamily: 'Roboto Mono',
                        color: AppTheme.of(context).primaryText,
                        letterSpacing: 0,
                      ),
                      elevation: 0,
                      borderSide: BorderSide(
                        color: AppTheme.of(context).accent3,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(38),
                    ),
                  ).animateOnPageLoad(
                      animationsMap['buttonOnPageLoadAnimation']!),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
