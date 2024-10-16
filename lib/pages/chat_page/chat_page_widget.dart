import 'dart:io';

import 'package:app/firebaseHelpers/auth_service.dart';
import 'package:app/pages/components/options/options_widget.dart';
import 'package:app/providers/forum_provider.dart';
import 'package:app/providers/profile_provider.dart';
import 'package:app/utils/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import 'chat_page_model.dart';
export 'chat_page_model.dart';

class ChatPageWidget extends StatefulWidget {
  const ChatPageWidget({super.key});

  @override
  State<ChatPageWidget> createState() => _ChatPageWidgetState();
}

class _ChatPageWidgetState extends State<ChatPageWidget> {

  ForumProvider forumProvider = ForumProvider();

  late ChatPageModel _model;
  late User _auth;
  late types.User _user;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  DocumentSnapshot? lastVisible;
  bool isLoading = false;
  final int limit = 20;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ChatPageModel());

    _model.textController ??= TextEditingController();
    _model.textFieldFocusNode ??= FocusNode();

    _auth = AuthService.auth.currentUser!;
    _user = types.User(
        id: _auth.uid,
    );

    _loadMessages();
    // forumProvider.initialize();
  }

  Future<void> _initData() async {
    // await Provider.of<ProfileProvider>(context).initialize();
    var profile = Provider.of<ProfileProvider>(context).profile;


    if(profile != null) {
      _user = types.User(
          id: profile.uid.toString(),
          firstName: profile.name.toString(),
          imageUrl: profile.image.toString(),
        // id: AuthService.auth.currentUser!.photoURL!,
        // firstName: "LOL CODING CLUB",
        // imageUrl: 'https://firebasestorage.googleapis.com/v0/b/lol-club-app-d1538.appspot.com/o/Notifications%2FLOLBadgeFull.png?alt=media&token=72cbac36-302c-4eac-b481-31fdcae43b4c'
      );
      // _user.firstName = profile.name.toString();
      // _user.imageUrl = profile.image.toString();
    }
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  // bool _checkDocsExists(DocumentReference docRef) {
  //   docRef.get().then((docSnapshot) {
  //     return docSnapshot.exists;
  //   }).catchError((error) {
  //     debugPrint("Error checking document existence: $error");
  //     return false;
  //   });
  //   return false;
  // }

  // Future<void> _saveMessageToFirestore(types.Message message)  async {
  //   FirebaseFirestore.instance
  //       .collection('${FirestoreConst.appDataCollection}/forums/#announcements')
  //       .doc(message.id)  // Set the custom document name here
  //       .set(message.toJson());
  // }

  // void _addMessage(types.Message message) {
  //   setState(() {
  //     _messages.insert(0, message);
  //     _saveMessageToFirestore(message);
  //   });
  // }

  // void _handleAttachmentPressed() {
  //   showModalBottomSheet<void>(
  //     context: context,
  //     builder: (BuildContext context) => SafeArea(
  //       child: SizedBox(
  //         height: 144,
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.stretch,
  //           children: <Widget>[
  //             TextButton(
  //               onPressed: () {
  //                 Navigator.pop(context);
  //                 _handleImageSelection();
  //               },
  //               child: const Align(
  //                 alignment: AlignmentDirectional.centerStart,
  //                 child: Text('Photo'),
  //               ),
  //             ),
  //             TextButton(
  //               onPressed: () {
  //                 Navigator.pop(context);
  //                 _handleFileSelection();
  //               },
  //               child: const Align(
  //                 alignment: AlignmentDirectional.centerStart,
  //                 child: Text('File'),
  //               ),
  //             ),
  //             TextButton(
  //               onPressed: () => Navigator.pop(context),
  //               child: const Align(
  //                 alignment: AlignmentDirectional.centerStart,
  //                 child: Text('Cancel'),
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

  // void _handleFileSelection() async {
  //   final result = await FilePicker.platform.pickFiles(
  //     type: FileType.any,
  //   );
  //
  //   if (result != null && result.files.single.path != null) {
  //     final message = types.FileMessage(
  //       author: _user,
  //       createdAt: DateTime.now().millisecondsSinceEpoch,
  //       id: const Uuid().v4(),
  //       mimeType: lookupMimeType(result.files.single.path!),
  //       name: result.files.single.name,
  //       size: result.files.single.size,
  //       uri: result.files.single.path!,
  //     );
  //
  //     // _addMessage(message);
  //   }
  // }

  // void _handleImageSelection() async {
  //   final result = await ImagePicker().pickImage(
  //     imageQuality: 70,
  //     maxWidth: 1440,
  //     source: ImageSource.gallery,
  //   );
  //
  //   if (result != null) {
  //     final bytes = await result.readAsBytes();
  //     final image = await decodeImageFromList(bytes);
  //
  //     final message = types.ImageMessage(
  //       author: _user,
  //       createdAt: DateTime.now().millisecondsSinceEpoch,
  //       height: image.height.toDouble(),
  //       id: const Uuid().v4(),
  //       name: result.name,
  //       size: bytes.length,
  //       uri: result.path,
  //       width: image.width.toDouble(),
  //     );
  //
  //     // _addMessage(message);
  //   }
  // }

  void _handleMessageTap(BuildContext _, types.Message message) async {
    if (message is types.FileMessage) {
      var localPath = message.uri;

      if (message.uri.startsWith('http')) {
        try {
          final index =
          forumProvider.messageList.indexWhere((element) => element.id == message.id);
          final updatedMessage =
          (forumProvider.messageList[index] as types.FileMessage).copyWith(
            isLoading: true,
          );

          setState(() {
            forumProvider.messageList[index] = updatedMessage;
          });

          final client = http.Client();
          final request = await client.get(Uri.parse(message.uri));
          final bytes = request.bodyBytes;
          final documentsDir = (await getApplicationDocumentsDirectory()).path;
          localPath = '$documentsDir/${message.name}';

          if (!File(localPath).existsSync()) {
            final file = File(localPath);
            await file.writeAsBytes(bytes);
          }
        } finally {
          final index =
          forumProvider.messageList.indexWhere((element) => element.id == message.id);
          final updatedMessage =
          (forumProvider.messageList[index] as types.FileMessage).copyWith(
            isLoading: null,
          );

          setState(() {
            forumProvider.messageList[index] = updatedMessage;
          });
        }
      }

      await OpenFilex.open(localPath);
    }
  }

  void _handleMessageLongPress(BuildContext _, types.Message message) async {
    if(message.author.id == _user.id) {
      await showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        enableDrag: false,
        useSafeArea: true,
        context: context,
        builder: (context) {
          return GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Padding(
              padding: MediaQuery.viewInsetsOf(context),
              child: OptionsWidget(
                message: message,
              ),
            ),
          );
        },
      ).then((value) => safeSetState(() {
        forumProvider.messageList;
      }));
    }
  }

  void _handlePreviewDataFetched(
      types.TextMessage message,
      types.PreviewData previewData,
      ) {
    final index = forumProvider.messageList.indexWhere((element) => element.id == message.id);
    final updatedMessage = (forumProvider.messageList[index] as types.TextMessage).copyWith(
      previewData: previewData,
    );

    setState(() {
      forumProvider.messageList[index] = updatedMessage;
    });
  }

  void _handleSendPressed(types.PartialText message) {
    final textMessage = types.TextMessage(
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: "${const Uuid().v4()} ${DateTime.now().millisecondsSinceEpoch}",
      text: message.text,
    );

    forumProvider.stackMessage(textMessage);
    setState(() {
      forumProvider.messageList;
    });
    // _addMessage(textMessage);
  }

  Future<void> _loadMessages() async {
    if (isLoading) return;

    setState(() {
      isLoading = true;
    });

    forumProvider.initialize();

    setState(() {
      forumProvider.messageList;
      isLoading = false;
    });

    // FirebaseFirestore.instance
    //     .collection('${FirestoreConst.appDataCollection}/forums/#announcements')
    //     .orderBy('createdAt', descending: true)
    //     .snapshots()
    //     .listen((snapshot) {
    //   final messages = snapshot.docs.map((doc) {
    //     final data = doc.data();
    //     return types.TextMessage(
    //       author: types.User.fromJson(data['author']),
    //       createdAt: data['createdAt'],
    //       id: data['id'],
    //       text: data['text'],
    //     );
    //   }).toList();
    //
    //   setState(() {
    //     _messages.clear();
    //     _messages.addAll(messages);
    //   });
    // });
  }

  get _customBottomWidget {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(10, 5, 10, 5),
      child: Material(
        color: Colors.transparent,
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: AppTheme.of(context).info,
            borderRadius: BorderRadius.circular(50),
            border: Border.all(
              color: AppTheme.of(context).accent3,
            ),
          ),
          child: Form(
            key: _model.formKey,
            autovalidateMode: AutovalidateMode.disabled,
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  // FlutterFlowIconButton(
                  //   borderColor: AppTheme.of(context).secondaryText,
                  //   borderRadius: 20,
                  //   borderWidth: 1,
                  //   buttonSize: 40,
                  //   icon: Icon(
                  //     Icons.attach_file,
                  //     color: AppTheme.of(context).primaryText,
                  //     size: 24,
                  //   ),
                  //   onPressed: () {
                  //     // _handleAttachmentPressed();
                  //   },
                  // ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
                      child: TextFormField(
                        controller: _model.textController,
                        focusNode: _model.textFieldFocusNode,
                        autofocus: true,
                        obscureText: false,
                        decoration: InputDecoration(
                          hintText: 'Your thought...',
                          hintStyle:
                              AppTheme.of(context).labelMedium.overriden(
                                    fontFamily: 'Roboto Mono',
                                    letterSpacing: 0,
                                  ),
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          focusedErrorBorder: InputBorder.none,
                        ),
                        style: AppTheme.of(context).bodyMedium.overriden(
                              fontFamily: 'Roboto Mono',
                              letterSpacing: 0,
                            ),
                        validator:
                            _model.textControllerValidator.asValidator(context),
                      ),
                    ),
                  ),
                  FlutterFlowIconButton(
                    borderColor: AppTheme.of(context).secondaryText,
                    borderRadius: 20,
                    borderWidth: 1,
                    buttonSize: 40,
                    icon: Icon(
                      Icons.send_rounded,
                      color: AppTheme.of(context).primaryText,
                      size: 24,
                    ),
                    onPressed: () async {
                      if (_model.formKey.currentState == null ||
                          !_model.formKey.currentState!.validate()) {
                        return;
                      } else {
                        types.PartialText message = types.PartialText(text: _model.textController!.value.text);
                        _handleSendPressed(message);
                        _model.textController!.clear();
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
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
          leading: Padding(
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
          title: Text(
            'Forum #announcements',
            // style: AppTheme.of(context).headlineMedium.overriden(
            //   fontFamily: 'PT Sans',
            //   fontSize: 22,
            //   letterSpacing: 0,
            // ),
            style: AppTheme.of(context).headlineMedium.overriden(
              fontFamily: 'Roboto Mono'
            )
          ),
          actions: const [],
          centerTitle: false,
          elevation: 2,
        ),
        body: FutureBuilder(
            future: _initData(),
            builder: (context, snapshot) {
              return SafeArea(
                top: true,
                child: Consumer<ForumProvider>(
                    builder: (_, consumer, __) {
                      consumer.initialize();
                      var messages = consumer.messageList;
                      return Chat(
                        messages: messages,
                        // onAttachmentPressed: _handleAttachmentPressed,
                        onMessageTap: _handleMessageTap,
                        onMessageLongPress: _handleMessageLongPress,
                        onPreviewDataFetched: _handlePreviewDataFetched,
                        onSendPressed: _handleSendPressed,
                        showUserAvatars: true,
                        showUserNames: true,
                        user: _user,
                        customBottomWidget: _customBottomWidget,
                      );
                    }
                ),
              );
            }),
      ),
    );
  }
}
