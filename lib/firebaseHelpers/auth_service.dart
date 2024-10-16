import 'package:app/firebaseHelpers/firebase_notifications.dart';
import 'package:app/firebaseHelpers/firestore_service.dart';
import 'package:app/handlers/google_sheets_api.dart';
import 'package:app/utils/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final GoogleSignIn _googleSignIn = GoogleSignIn();

  static FirebaseAuth get auth => _auth;

  static Future<void> signOut() async {
    var token = await FirebaseMessagingHandler.getFCMToken;
    FirestoreService service = FirestoreService("signOut");
    await service.removeTokenFromNotification(token!);
    await service.closeConnection("signOut");
    await _auth.signOut();
  }

  static Future<bool> logInStatus() async {
    return _auth.currentUser != null;
  }

  static Future<bool> isUserDisabled(String uid) async {
    try {
      FirestoreService service = FirestoreService("isUserDisabled");
      var data = await service.getDocument("App Data", "disabledStudents") ?? {};
      await service.closeConnection("isUserDisabled");
      List list = data['list'] ?? [];
      return list.contains(uid);
    } catch (e) {
      debugPrint("Error checking user status: $e");
      return false; // Assume user is disabled in case of an error
    }
  }

  static Future<User?> createAccountWithEmail(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return result.user;
    } catch (e) {
      debugPrint(e.toString());
      // Get.showSnackbar(GetSnackBar(message: "$e", duration: const Duration(seconds: 4),));
      return null;
    }
  }

  static Future<User?> signInWithEmail(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return result.user;
    } catch (e) {
      debugPrint(e.toString());
      // Get.showSnackbar(GetSnackBar(message: "$e", duration: const Duration(seconds: 4),));
      return null;
    }
  }

  static Future<User?> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        // The user canceled the sign-in
        return null;
      }

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      // // Verify the email using the custom function
      bool isVerified = await verifyEmail(googleUser.email);
      if (!isVerified) {
        // Email verification failed
        return null;
      }

      // Create a new credential
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in with the credential
      UserCredential result = await _auth.signInWithCredential(credential);
      return result.user;
    } catch (e) {
      debugPrint("Exception in signInWithGoogle: $e");
      return null;
    }
  }


  static Future<bool> verifyEmail(String email) async {
    try {
      GoogleSheetsService sheetsService = GoogleSheetsService();
      await sheetsService.init();
      sheetsService.spreadsheetId = GlobalConstants.appDataSheetID;
      sheetsService.worksheet = GlobalConstants.appDataSheetMembership;

      var headers = await sheetsService.getSheetHeaders() ?? [];
      var emailIndex = headers.indexOf("Email Address");
      var sheetData = await sheetsService.getSheetData(sheetsService.worksheet);
      var index = sheetData.indexWhere((row) => row[emailIndex]==email);

      return index!=-1 ? true : false ;
    } catch (e) {
      debugPrint("Exception: $e");
      return false;
    }
  }
}
