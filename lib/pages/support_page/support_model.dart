import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:url_launcher/url_launcher.dart';
import 'support_widget.dart' show SupportWidget;
import 'package:flutter/material.dart';

class SupportModel extends FlutterFlowModel<SupportWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for PageView widget.
  PageController? pageViewController;

  int get pageViewCurrentIndex => pageViewController != null &&
      pageViewController!.hasClients &&
      pageViewController!.page != null
      ? pageViewController!.page!.round()
      : 0;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}

  // Function to launch LinkedIn profile TODO
  Future<void> launchLinkedIn(String linkedInUrl) async {
    final Uri linkedInUri = Uri.parse(linkedInUrl.startsWith('http')
        ? linkedInUrl
        : 'https://$linkedInUrl'); // Ensure the URL is complete

    if (await canLaunchUrl(linkedInUri)) {
      await launchUrl(linkedInUri);
    } else {
      throw 'Could not launch $linkedInUrl';
    }
  }

  // Function to send email TODO
  Future<void> sendEmail(String mailId) async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: mailId,
      query: 'subject=Hello from Student Club App', // Use query instead of queryParameters
    );

    if (await canLaunchUrl(emailLaunchUri)) {
      await launchUrl(emailLaunchUri);
    } else {
      throw 'Could not launch $emailLaunchUri';
    }
  }
}
