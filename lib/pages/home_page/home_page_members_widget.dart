import 'package:app/providers/events_list_provider.dart';
import 'package:app/utils/custom_utils.dart';
import 'package:app/utils/routes.dart';
import 'package:app/utils/theme.dart';

import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '/pages/components/empty_list/empty_list_widget.dart';
import '/pages/components/event_card_item/event_card_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'home_page_members_model.dart';
export 'home_page_members_model.dart';

class HomePageMembersWidget extends StatefulWidget {
  const HomePageMembersWidget({super.key});

  @override
  State<HomePageMembersWidget> createState() => _HomePageMembersWidgetState();
}

class _HomePageMembersWidgetState extends State<HomePageMembersWidget>
    with TickerProviderStateMixin {
  late HomePageMembersModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HomePageMembersModel());

    animationsMap.addAll({
      'containerOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 400.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
          MoveEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 400.0.ms,
            begin: const Offset(0.0, 40.0),
            end: const Offset(0.0, 0.0),
          ),
          ScaleEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 400.0.ms,
            begin: const Offset(0.8, 0.8),
            end: const Offset(1.0, 1.0),
          ),
        ],
      ),
      'textOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
          MoveEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: const Offset(30.0, 0.0),
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

    Provider.of<EventsListProvider>(context, listen: false).initialize();
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
        appBar: AppBar(
          backgroundColor: AppTheme.of(context).primary,
          automaticallyImplyLeading: false,
          title: Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              'LOL Club',
              style: AppTheme.of(context).headlineLarge.overriden(
                fontFamily: 'Roboto Mono',
                letterSpacing: 0,
              ),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
              child: FlutterFlowIconButton(
                borderRadius: 30,
                borderWidth: 1,
                buttonSize: 60,
                icon: Icon(
                  Icons.account_circle_outlined,
                  color: AppTheme.of(context).primaryText,
                  size: 30,
                ),
                onPressed: () async {
                  Get.toNamed(GetRoutes.settings);
                },
              ),
            ),
          ],
          centerTitle: false,
          elevation: 0,
        ),
        body: SafeArea(
          top: true,
          // child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
                  child: Container(
                    width: double.infinity,
                    height: 230,
                    decoration: BoxDecoration(
                      color: AppTheme.of(context).secondaryBackground,
                      boxShadow: const [
                        BoxShadow(
                          blurRadius: 4,
                          color: Color(0x250F1113),
                          offset: Offset(
                            0.0,
                            1,
                          ),
                        )
                      ],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      height: double.infinity,
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(
                              'assets/images/LOLBadgeFull.png',
                              width: MediaQuery.sizeOf(context).width,
                              height: MediaQuery.sizeOf(context).height * 1,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                            padding:
                            const EdgeInsetsDirectional.fromSTEB(12, 12, 12, 0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: FFButtonWidget(
                                    onPressed: () async {
                                      Get.toNamed(GetRoutes.committeeList);
                                    },
                                    text: 'Explore Committee Now',
                                    options: FFButtonOptions(
                                      width: double.infinity,
                                      height: 44,
                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                          0, 0, 0, 0),
                                      iconPadding:
                                      const EdgeInsetsDirectional.fromSTEB(
                                          0, 0, 0, 0),
                                      color:
                                      AppTheme.of(context).primary,
                                      textStyle: AppTheme.of(context)
                                          .titleSmall
                                          .overriden(
                                        fontFamily: 'Roboto Mono',
                                        letterSpacing: 0,
                                      ),
                                      elevation: 2,
                                      borderSide: const BorderSide(
                                        color: Colors.transparent,
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ).animateOnPageLoad(
                      animationsMap['containerOnPageLoadAnimation']!),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 0, 12),
                  child: Text(
                    'upcoming Events',
                    style: AppTheme.of(context).labelLarge.overriden(
                      fontFamily: 'Roboto Mono',
                      letterSpacing: 0,
                    ),
                  ).animateOnPageLoad(
                      animationsMap['textOnPageLoadAnimation']!),
                ),
                Expanded(
                  child: Consumer<EventsListProvider>(
                      builder: (_, consumer, __) {
                        if(consumer.list.isEmpty) {
                          return const EmptyListWidget();
                        }

                        final listItem = consumer.list;
                        return RefreshIndicator(
                          onRefresh: () async {
                            await consumer.initialize();
                          },
                          child: ListView.builder(
                            padding: const EdgeInsets.fromLTRB(0,0,0,100,),
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: listItem.length,
                            itemBuilder: (context, listItemIndex) {
                              final listItemItem = listItem[listItemIndex];
                              debugPrint(listItemItem.toString());
                              return wrapWithModel(
                                model: _model.eventCardItemModels.getModel(
                                  listItemIndex.toString(),
                                  listItemIndex,
                                ),
                                updateCallback: () => setState(() {}),
                                child: EventCardItemWidget(
                                  key: Key(
                                    'Key89q_$listItemItem',
                                  ),
                                  image: listItemItem.image,
                                  id: listItemItem.id,
                                  title: listItemItem.title,
                                  // date: listItemItem.dateTime.toString().split(" ")[0],
                                  date: dateFormat.format(DateTime.parse(listItemItem.dateTime.toString())),
                                  // time: listItemItem.dateTime.toString().split(" ")[1].split(".")[0],
                                  time: timeFormat12Hour.format(DateTime.parse(listItemItem.dateTime.toString())),
                                  location: listItemItem.location,
                                ),
                              );
                              // return EventCardItemWidget(
                              //   key: Key(
                              //     'Key89q_$listItemItem',
                              //   ),
                              //   id: listItemItem?['id'],
                              //   title: listItemItem?['title'],
                              //   date: listItemItem?['dateTime'].toString().split(" ")[0],
                              //   time: listItemItem?['dateTime'].toString().split(" ")[1].split(".")[0],
                              //   location: listItemItem?['location'],
                              // );
                            },
                          ),
                        );
                      }
                  ),
                ),
              ].addToEnd(const SizedBox(height: 20)),
            ),
          // ),
        ),
      ),
    );
  }
}
