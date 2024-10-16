import 'package:app/providers/profile_provider.dart';
import 'package:app/utils/theme.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'profile_members_model.dart';
export 'profile_members_model.dart';

class ProfileMembersWidget extends StatefulWidget {
  const ProfileMembersWidget({super.key});

  @override
  State<ProfileMembersWidget> createState() => _ProfileMembersWidgetState();
}

class _ProfileMembersWidgetState extends State<ProfileMembersWidget> {
  late ProfileMembersModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  String _defaultImage = "https://img.freepik.com/free-vector/businessman-character-avatar-isolated_24877-60111.jpg?w=740&t=st=1722703753~exp=1722704353~hmac=fe8ea6f998f01a3bd2be08885ce075dd2d408604565976c99a444f42b50f9892";

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ProfileMembersModel());

    _model.yourNameTextController ??= TextEditingController();
    _model.yourNameFocusNode ??= FocusNode();

    _model.emailTextController ??= TextEditingController();
    _model.emailFocusNode ??= FocusNode();

    _model.contactTextController ??= TextEditingController();
    _model.contactFocusNode ??= FocusNode();
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: AppTheme.of(context).secondaryBackground,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: AppBar(
          backgroundColor: AppTheme.of(context).secondaryBackground,
          automaticallyImplyLeading: false,
          actions: const [],
          flexibleSpace: FlexibleSpaceBar(
            title: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 14),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 8),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                          child: FlutterFlowIconButton(
                            borderColor: Colors.transparent,
                            borderRadius: 30,
                            borderWidth: 1,
                            buttonSize: 50,
                            icon: Icon(
                              Icons.arrow_back_rounded,
                              color: AppTheme.of(context).primaryText,
                              size: 30,
                            ),
                            onPressed: () async {
                              Get.back();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(24, 0, 0, 0),
                        child: Text(
                          'Your Profile',
                          style: AppTheme.of(context).headlineMedium.overriden(
                            fontFamily: 'PT Sans',
                            color: AppTheme.of(context).primaryText,
                            fontSize: 22,
                            letterSpacing: 0,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 12, 0),
                        child: InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            await _model.membershipReceipt();
                          },
                          child: RichText(
                            textScaler: MediaQuery.of(context).textScaler,
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Download Invoice',
                                  style: AppTheme.of(context).bodyMedium.overriden(
                                    fontFamily: 'Roboto Mono',
                                    color: AppTheme.of(context).primary,
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline,
                                  ),
                                )
                              ],
                              style: AppTheme.of(context).bodyMedium.overriden(
                                fontFamily: 'Roboto Mono',
                                letterSpacing: 0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                  ,
                ],
              ),
            ),
            centerTitle: true,
            expandedTitleScale: 1.0,
          ),
          elevation: 0,
        ),
      ),
      body: SafeArea(
        top: true,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Consumer<ProfileProvider>(
                        builder: (_, consumer, __) {
                          _defaultImage = consumer.profile?.image ?? _defaultImage;
                          return InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              // Navigator.pop(context);
                              if(consumer.profile?.image == null || consumer.profile!.image!.isEmpty) {
                                /*TODO: UPDATE PHOTO*/
                              }
                            },
                            child: Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                color: AppTheme.of(context).alternate,
                                shape: BoxShape.circle,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(2),
                                child: Container(
                                  width: 90,
                                  height: 90,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: FadeInImage(
                                    placeholder: const AssetImage('assets/images/image-placeholder.jpg'),
                                    image: NetworkImage(_defaultImage),
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 16),
                child: Consumer<ProfileProvider> (
                  builder: (_, consumer, __) {
                    bool readStatus = false;
                    if(consumer.profile != null && consumer.profile!.name !=null && consumer.profile!.name!.isNotEmpty) {
                      _model.yourNameTextController.text = consumer.profile!.name!;
                      readStatus=true;
                    }
                    return TextFormField(
                      controller: _model.yourNameTextController,
                      focusNode: _model.yourNameFocusNode,
                      textCapitalization: TextCapitalization.words,
                      obscureText: false,
                      readOnly: readStatus,
                      decoration: InputDecoration(
                        labelText: 'Your Name',
                        labelStyle: AppTheme.of(context).labelMedium.overriden(
                          fontFamily: 'Roboto Mono',
                          letterSpacing: 0,
                        ),
                        hintStyle: AppTheme.of(context).labelMedium.overriden(
                          fontFamily: 'Roboto Mono',
                          letterSpacing: 0,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: AppTheme.of(context).alternate,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: AppTheme.of(context).primary,
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
                        fillColor: AppTheme.of(context).secondaryBackground,
                        contentPadding: const EdgeInsetsDirectional.fromSTEB(20, 24, 0, 24),
                      ),
                      style: AppTheme.of(context).bodyMedium.overriden(
                        fontFamily: 'Roboto Mono',
                        letterSpacing: 0,
                      ),
                      validator:
                      _model.yourNameTextControllerValidator.asValidator(context),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 16),
                child: Consumer<ProfileProvider> (
                  builder: (_, consumer, __) {
                    bool readStatus = false;
                    if(consumer.profile != null && consumer.profile!.email != null && consumer.profile!.email!.isNotEmpty) {
                      _model.emailTextController.text = consumer.profile!.email!;
                      readStatus=true;
                    }
                    return TextFormField(
                      controller: _model.emailTextController,
                      focusNode: _model.emailFocusNode,
                      textCapitalization: TextCapitalization.words,
                      obscureText: false,
                      readOnly: readStatus,
                      decoration: InputDecoration(
                        labelText: 'Your Email',
                        labelStyle: AppTheme.of(context).labelMedium.overriden(
                          fontFamily: 'Roboto Mono',
                          letterSpacing: 0,
                        ),
                        hintStyle: AppTheme.of(context).labelMedium.overriden(
                          fontFamily: 'Roboto Mono',
                          letterSpacing: 0,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: AppTheme.of(context).alternate,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: AppTheme.of(context).primary,
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
                        fillColor: AppTheme.of(context).secondaryBackground,
                        contentPadding: const EdgeInsetsDirectional.fromSTEB(20, 24, 0, 24),
                      ),
                      style: AppTheme.of(context).bodyMedium.overriden(
                        fontFamily: 'Roboto Mono',
                        letterSpacing: 0,
                      ),
                      validator:
                      _model.emailTextControllerValidator.asValidator(context),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 16),
                child: Consumer<ProfileProvider> (
                  builder: (_, consumer, __) {
                    bool readStatus = false;
                    if(consumer.profile != null && consumer.profile!.year != null && consumer.profile!.year!.isNotEmpty) {
                      _model.yearValue = consumer.profile!.year!;
                      readStatus = true;
                    }
                    return FlutterFlowDropDown<String>(
                      controller: _model.yearValueController ??=
                          FormFieldController<String>(_model.yearValue),
                      options: const ['First Year', 'Second Year', 'Third Year', 'Final Year'],
                      disabled: readStatus,
                      onChanged: (val) => setState(() => _model.yearValue = val),
                      width: double.infinity,
                      height: 56,
                      textStyle: AppTheme.of(context).bodyMedium.overriden(
                        fontFamily: 'Roboto Mono',
                        letterSpacing: 0,
                      ),
                      hintText: 'Your Class',
                      icon: Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: AppTheme.of(context).secondaryText,
                        size: 24,
                      ),
                      fillColor: AppTheme.of(context).secondaryBackground,
                      elevation: 2,
                      borderColor: AppTheme.of(context).alternate,
                      borderWidth: 2,
                      borderRadius: 8,
                      margin: const EdgeInsetsDirectional.fromSTEB(16, 4, 16, 4),
                      hidesUnderline: true,
                      isOverButton: true,
                      isSearchable: false,
                      isMultiSelect: false,
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 16),
                child: Consumer<ProfileProvider> (
                  builder: (_, consumer, __) {
                    bool readStatus = false;
                    if(consumer.profile != null && consumer.profile!.dept != null && consumer.profile!.dept!.isNotEmpty) {
                      _model.departmentValue = consumer.profile!.dept!;
                      readStatus = true;
                    }
                    return FlutterFlowDropDown<String>(
                      controller: _model.departmentValueController ??=
                          FormFieldController<String>(_model.departmentValue),
                      options: const ['Civil', 'CSE', 'E&TC', 'ECE', 'IT', 'Mech'],
                      onChanged: (val) => setState(() => _model.departmentValue = val),
                      disabled: readStatus,
                      width: double.infinity,
                      height: 56,
                      textStyle: AppTheme.of(context).bodyMedium.overriden(
                        fontFamily: 'Roboto Mono',
                        letterSpacing: 0,
                      ),
                      hintText: 'Your Department',
                      icon: Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: AppTheme.of(context).secondaryText,
                        size: 24,
                      ),
                      fillColor: AppTheme.of(context).secondaryBackground,
                      elevation: 2,
                      borderColor: AppTheme.of(context).alternate,
                      borderWidth: 2,
                      borderRadius: 8,
                      margin: const EdgeInsetsDirectional.fromSTEB(16, 4, 16, 4),
                      hidesUnderline: true,
                      isOverButton: true,
                      isSearchable: false,
                      isMultiSelect: false,
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 16),
                child: Consumer<ProfileProvider> (
                  builder: (_, consumer, __) {
                    bool readStatus = false;
                    if(consumer.profile != null && consumer.profile!.contact != null && consumer.profile!.contact!.isNotEmpty) {
                      _model.contactTextController.text = consumer.profile!.contact!;
                      readStatus = true;
                    }
                    return TextFormField(
                      controller: _model.contactTextController,
                      focusNode: _model.contactFocusNode,
                      obscureText: false,
                      readOnly:  readStatus,
                      decoration: InputDecoration(
                        labelText: 'Your Contact',
                        labelStyle: AppTheme.of(context).labelMedium.overriden(
                          fontFamily: 'Roboto Mono',
                          letterSpacing: 0,
                        ),
                        hintStyle: AppTheme.of(context).labelMedium.overriden(
                          fontFamily: 'Roboto Mono',
                          letterSpacing: 0,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: AppTheme.of(context).alternate,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: AppTheme.of(context).primary,
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
                        fillColor: AppTheme.of(context).secondaryBackground,
                        contentPadding: const EdgeInsetsDirectional.fromSTEB(20, 24, 0, 24),
                      ),
                      style: AppTheme.of(context).bodyMedium.overriden(
                        fontFamily: 'Roboto Mono',
                        letterSpacing: 0,
                      ),
                      keyboardType: TextInputType.phone,
                      validator:
                      _model.contactTextControllerValidator.asValidator(context),
                    );
                  },
                ),
              ),
              Consumer<ProfileProvider>(
                  builder: (_, consumer, __){
                    if(consumer.profile!.toMap().values.any((e) => (e == null)||(e.toString().isEmpty))) {
                      return Padding(
                        padding: const EdgeInsets.all(12),
                        child: FFButtonWidget(
                          onPressed: () async {
                            debugPrint("Press...");
                            if ((_model.formKey.currentState == null ||
                                !_model.formKey.currentState!.validate()) &&
                                _model.yearValue == null && _model.departmentValue == null) {
                              return;
                            } else {
                              debugPrint("In else.");
                              var profile = consumer.profile;
                              profile?.image = _defaultImage;
                              profile?.name = _model.yourNameTextController?.value.text;
                              profile?.year = _model.yearValueController?.value;
                              profile?.dept = _model.departmentValueController?.value;
                              profile?.contact = _model.contactTextController?.value.text;
                              await consumer.updateProfile(profile!);
                            }
                          },
                          text: 'Button',
                          options: FFButtonOptions(
                            width: double.infinity,
                            height: 40,
                            padding: const EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                            iconPadding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                            color: AppTheme.of(context).primary,
                            textStyle: AppTheme.of(context).titleSmall.overriden(
                              fontFamily: 'Roboto Mono',
                              color: Colors.white,
                              letterSpacing: 0,
                            ),
                            elevation: 3,
                            borderSide: const BorderSide(
                              color: Colors.transparent,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      );
                    }
                    return Container();
                  }
              )
            ],
          ),
        ),
      ),
    );
  }
}
