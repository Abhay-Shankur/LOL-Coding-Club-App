
import 'package:app/firebaseHelpers/firestore_service.dart';
import 'package:flutter/foundation.dart';

class GlobalConstants {
  static late final String secretKey;
  static late final String appDataSheetID;
  static late final String appDataSheetMembership;
  static late final String appDataSheetCommittee;

  static late final String websiteLink;
  static late final String discordLink;
  static late final String instagramLink;
  static late final String linkedInLink;
  static late final String hashNodeLink;


  static Future<void> initialize() async {
    try {

      FirestoreService service = FirestoreService("initialize");
      var collection = await service.getDocument("App Data", "constants");
      secretKey = collection?["secretKey"] ?? '448810e4ca678cf549029071ecbd482e7ac969cca18cdffaf03c1494a98d4d60';
      appDataSheetID = collection?["appDataSheetID"] ?? '1qYlB3nMxbNBVZPPe_AEXY79TiPQD8EzMqE0Ob9nmjis';
      appDataSheetMembership = collection?["appDataSheetMembership"] ?? 'Membership';
      appDataSheetCommittee = collection?["appDataSheetCommittee"] ?? 'Committee';
      debugPrint("Constants Init: $secretKey, $appDataSheetID, $appDataSheetMembership, $appDataSheetCommittee");

      var links = await service.getDocument("App Data", "links");
      websiteLink = links?["websiteLink"] ?? 'https://lolclubwit.web.app/';
      discordLink = links?["discordLink"] ?? 'https://discord.com/invite/bjSxDHzEte';
      instagramLink = links?["instagramLink"] ?? 'https://www.instagram.com/lolcodingclub_wit/';
      linkedInLink = links?["linkedInLink"] ?? 'https://www.linkedin.com/company/lol-coding-club/';
      hashNodeLink = links?["hashNodeLink"] ?? 'https://hashnode.com/@lolclubwit';
      debugPrint("Links Init: $discordLink, $instagramLink, $linkedInLink, $hashNodeLink");
      await service.closeConnection("initialize");
    } catch(e) {
      debugPrint("Failed to Initialize GlobalConstants : $e");
    }
  }
}
// const String secretKey = "448810e4ca678cf549029071ecbd482e7ac969cca18cdffaf03c1494a98d4d60";