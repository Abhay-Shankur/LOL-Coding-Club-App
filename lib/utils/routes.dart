
import 'package:app/pages/chat_page/chat_page_widget.dart';
import 'package:app/pages/committee_list/committee_list_widget.dart';
import 'package:app/pages/event_details/event_details_widget.dart';
import 'package:app/pages/home_page/home_page_members_widget.dart';
import 'package:app/pages/login_page/login_page_widget.dart';
import 'package:app/pages/members_profile/profile_members_widget.dart';
import 'package:app/pages/notification_list/notifications_list_widget.dart';
import 'package:app/pages/setting_page/settings_members_widget.dart';
import 'package:app/pages/splash_screen/splash_screen_widget.dart';
import 'package:app/pages/support_page/support_widget.dart';
import 'package:app/pages/terms_page/terms_page_widget.dart';
import 'package:get/get.dart';

class GetRoutes {
  // static String blank = '/blankPage';
  static String splash = '/splashScreen';
  static String login = '/loginPage';
  static String home = '/homePage';
  static String settings = '/settings';
  static String eventDetails = '/eventDetailsPage';
  static String profile = '/profile';
  static String committeeList = '/committeeList';
  static String notificationList = '/notificationList';
  static String chatPage = '/chatPage';
  static String supportPage = '/supportPage';
  static String termsPage = '/termsPage';
  // static String createEvent = '/createEvent';
  // static String generateSheet = '/generateSheet';
  // static String eventsAttendance = '/eventsAttendance';

  static final routes = [
    // GetPage(name: blank, page: () => const HomePage(), transition: Transition.fadeIn),
    GetPage(name: splash, page: () => const SplashScreenWidget(), transition: Transition.fadeIn),
    GetPage(name: login, page: () => const LoginPageWidget(), transition: Transition.fadeIn),
    GetPage(name: home, page: () => const HomePageMembersWidget(), transition: Transition.fadeIn),
    GetPage(name: settings, page: () => const SettingsMembersWidget(), transition: Transition.fadeIn),
    GetPage(name: eventDetails, page: () => const EventDetailsWidget(), transition: Transition.fadeIn),
    GetPage(name: profile, page: () => const ProfileMembersWidget(), transition: Transition.fadeIn),
    GetPage(name: committeeList, page: () => const CommitteeListWidget(), transition: Transition.fadeIn),
    GetPage(name: notificationList, page: () => const NotificationsListWidget(), transition: Transition.fadeIn),
    // GetPage(name: chatPage, page: () => const ChatPage(), transition: Transition.fadeIn),
    GetPage(name: chatPage, page: () => const ChatPageWidget(), transition: Transition.fadeIn),
    GetPage(name: supportPage, page: () => const SupportWidget(), transition: Transition.fadeIn),
    GetPage(name: termsPage, page: () => const TermsPageWidget(), transition: Transition.fadeIn),
    // GetPage(name: generateSheet, page: () => const GenerateSheetWidget(), transition: Transition.fadeIn),
    // GetPage(name: eventsAttendance, page: () => const EventsHistoryWidget(), transition: Transition.fadeIn),
  ];
}