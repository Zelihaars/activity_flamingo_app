import 'dart:async';
import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flamingo_app/Models/UserModel.dart';
import 'package:flamingo_app/constants.dart';
class DatabaseServices{

  static Future<int> followersNum(String userId)async{
    QuerySnapshot followersSnapshot=
        await followersRef.doc(userId).collection('Followers').get();
    return followersSnapshot.docs.length;

  }

  static Future<int> followingNum(String userId)async{
    QuerySnapshot followingSnapshot=
    await followingRef.doc(userId).collection('Following').get();
    return followingSnapshot.docs.length;

  }

  static void updateUserData(UserModel user) {
    usersRef.doc(user.id).update({
      'name': user.name,
      'surname':user.surname,
      'bio': user.bio,
      'profilePicture': user.profilePicture,
      'coverImage': user.coverImage,
    });
  }

  static Future<QuerySnapshot> searchUsers(String name)async{
    Future<QuerySnapshot> users=usersRef.where('name',isGreaterThanOrEqualTo: name)
        .where('name',isLessThan: name+'z').get();
    return users;
  }

  static void followUser(String currentUserId, String visitedUserId){
    followingRef
        .doc(currentUserId)
        .collection('Takip Edilenler')
        .doc(visitedUserId)
        .set({});
    followersRef
        .doc(visitedUserId)
        .collection('Takipçiler')
        .doc(currentUserId)
        .set({});

  }
  static void unFollowUser(String currentUserId, String visitedUserId) {
    followingRef
        .doc(currentUserId)
        .collection('Following')
        .doc(visitedUserId)
        .get()
        .then((doc) {
      if (doc.exists) {
        doc.reference.delete();
      }
    });

    followersRef
        .doc(visitedUserId)
        .collection('Takip Edilenler')
        .doc(currentUserId)
        .get()
        .then((doc) {
      if (doc.exists) {
        doc.reference.delete();
      }
    });
  }
  static Future<bool> isFollowingUser(
      String currentUserId, String visitedUserId) async {
    DocumentSnapshot followingDoc = await followersRef
        .doc(visitedUserId)
        .collection('Takipçiler')
        .doc(currentUserId)
        .get();
    return followingDoc.exists;
  }
}