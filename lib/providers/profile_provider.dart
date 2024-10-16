import 'package:app/firebaseHelpers/auth_service.dart';
import 'package:app/firebaseHelpers/firestore_service.dart';
import 'package:flutter/material.dart';


class Profile {
  String? uid;
  String? image;
  String? name;
  String? email;
  String? year;
  String? dept;
  String? contact;
  bool? membership;


  Profile({required this.uid, required this.image,required  this.name,required  this.email,required  this.year,required  this.dept,required  this.contact, required this.membership});

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'imageFile': image,
      'userName': name,
      'userEmail': email,
      'class': year,
      'department': dept,
      'userContact': contact,
      'membership': membership,
    };
  }

  factory Profile.fromJson(Map<String,dynamic> map) {
    return Profile(
        uid : map['uid'],
        image : map['imageFile'],
        name: map['userName'],
        email: map['userEmail'],
        year: map['class'],
        dept: map['department'],
        contact: map['userContact'],
        membership: map['membership']
    );
  }

}

class ProfileProvider extends ChangeNotifier{

  Profile? _profile;

  // ProfileProvider() {
  //   _init();
  // }

  Future<bool> initialize() async {
    try {
      await _init();
      return true;
    } catch(e) {
      return false;
    }
  }

  Future<void> _init() async{
    try {
      String? email = AuthService.auth.currentUser?.email;
      if(email != null) {
        FirestoreService firestore = FirestoreService("_init ProfileProvider");
        Map<String, dynamic>? data = await firestore.getDocument("${FirestoreConst.appDataCollection}/users/Members", email);
        data ??= await firestore.getDocument("${FirestoreConst.appDataCollection}/users/Non-Members", email);
        if(data != null) {
          _profile = Profile.fromJson(data);
          // notifyListeners();
          debugPrint('Profile Data Initialized.');
          notifyListeners();
        }
        await firestore.closeConnection("_init ProfileProvider");
      } else {
        throw Exception('User not Authenticated');
      }
    } catch (e) {
      debugPrint('Failed to Initialize ProfileProvider: $e');
    }
  }

  Profile? get profile => _profile;

  Future<void> updateProfile(Profile profile) async {
    try {
      _profile = profile;
      notifyListeners();

      String? uid = AuthService.auth.currentUser?.uid;
      String? email = AuthService.auth.currentUser?.email;
      String? subColl = _profile!.membership! ? "Members" : "Non-Members";
      FirestoreService firestore = FirestoreService("updateProfile");
      // await firestore.insertOrUpdateDocument(FirestoreConst.appDataCollection, "members",{email! : uid!});
      // await firestore.insertOrUpdateDocument("${FirestoreConst.userCollection}/members", uid, _profile!.toMap());
      await firestore.addToList(FirestoreConst.appDataCollection, "users", subColl,{ email : uid });
      await firestore.addToSubCollections(FirestoreConst.appDataCollection, "users", subColl, email!, _profile!.toMap());
      debugPrint("Profile Updated.");
      await firestore.closeConnection("updateProfile");
      notifyListeners();
    } catch (e) {
      debugPrint('Failed to Update ProfileProvider: $e');
    }
  }
}