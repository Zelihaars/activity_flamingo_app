import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

//const kPrimaryColor = Color(0xFF6A62B7);
const kPrimaryColor = Color(0xFF7042F6);
const kPrimaryLightColor = Color(0xFFF1E6FF);
const kBackgroundColor = Color(0xFFE5E5E5);
const grayColor=Color(0xFF7D7777);
const kOrangeColor=Color(0xFFFF7300);
const double defaultPadding = 16.0;

final _firestore=FirebaseFirestore.instance;

final usersRef=_firestore.collection('users');

final clubsRef=_firestore.collection('clubs');

final followersRef=_firestore.collection('followers');

final followingRef=_firestore.collection('following');

final tweetsRef=_firestore.collection('tweets');

final feedRefs=_firestore.collection('feeds');

final homeRefs=_firestore.collection('homes');

final likesRef=_firestore.collection('likes');

final etkinlikRef=_firestore.collection('etkinlikler');

final activitiesRef=_firestore.collection('activities');

final storageRef=FirebaseStorage.instance.ref();



