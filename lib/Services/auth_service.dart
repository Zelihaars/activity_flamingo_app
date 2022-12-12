
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  static final _auth = FirebaseAuth.instance;
  static final _fireStore = FirebaseFirestore.instance;

  static Future<bool> signUp(String name,String surname, String email, String phone, String password) async {
    try {
      UserCredential authResult = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      User? signedInUser = authResult.user;

      if (signedInUser != null) {
        _fireStore.collection('users').doc(signedInUser.uid).set({
          'name': name,
          'surname':surname,
          'email': email,
          'phone':phone,
          'profilePicture': '',
          'coverImage': '',
          'bio': '',
          'userType':1

        });
        return true;
      }

      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }

  static Future<bool> ClubsignUp(String club_name,String  club_alan, String email, String phone, String password) async {
    try {
      UserCredential authResult = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      User? signedInClub = authResult.user;

      if (signedInClub != null) {
        _fireStore.collection('clubs').doc(signedInClub.uid).set({
          'club_name':  club_name,
          'club_alan': club_alan,
          'email': email,
          'phone':phone,
          'profilePicture': '',
          'coverImage': '',
          'bio': '',
          'userType':0
        });
        return true;
      }

      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }

  static Future<bool> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return true;

    } catch (e) {
      print(e);
      return false;
    }
  }
  static void logout() {
    try {
      _auth.signOut();
    } catch (e) {
      print(e);
    }
  }
}