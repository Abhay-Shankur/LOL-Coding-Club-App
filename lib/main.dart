import 'package:app/firebaseHelpers/firebase_notifications.dart';
import 'package:app/handlers/check_connection_stream.dart';
import 'package:app/providers/events_list_provider.dart';
import 'package:app/providers/forum_provider.dart';
import 'package:app/providers/profile_provider.dart';
import 'package:app/utils/constants.dart';
import 'package:app/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';


final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

late PackageInfo packageInfo;


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await FirebaseMessagingHandler().initNotifications();
  // await FirebaseMessagingHandler.initFirebase();

  await GlobalConstants.initialize();

  packageInfo = await PackageInfo.fromPlatform();

  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProfileProvider()),
        ChangeNotifierProvider(create: (context) => EventsListProvider()),
        ChangeNotifierProvider(create: (context) => ForumProvider()),
        // ChangeNotifierProvider(create: (context) => NotificationProvider()),

      ],
      child: GetMaterialApp(
        title: 'LOL CODING CLUB',
        navigatorKey: navigatorKey,
        themeMode: ThemeMode.system,
        getPages: GetRoutes.routes,
        initialRoute: GetRoutes.splash,
        // initialRoute: GetRoutes.chatPage,
        initialBinding: InitialBindings(),
      ),
    );
  }
}

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(CheckConnectionStream());
  }
}
