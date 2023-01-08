import 'package:cloud_firestore/cloud_firestore.dart';

class ClubModel{
  String id;
  String club_name;
  String club_alan;
  String profilePicture;
  String email;
  String bio;
  String coverImage;

  ClubModel(
      {required this.id,
        required this.club_name,
        required this.club_alan,
        required this.profilePicture,
        required this.email,
        required this.bio,
        required this.coverImage});

  factory ClubModel.fromDoc(DocumentSnapshot doc){
    final data = doc.data();
    return ClubModel(
      id: doc.id,
      club_name: doc['club_name'],
      club_alan: doc['club_alan'],
      profilePicture: doc['profilePicture'],
      email: doc['email'],
      bio: doc['bio'],
      coverImage: doc['coverImage'],
    );
  }
}