import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel{
  String id;
  String name;
  String surname;
  String profilePicture;
  String email;
  String bio;
  String coverImage;

  UserModel(
      {required this.id,
        required this.name,
        required this.surname,
        required this.profilePicture,
        required this.email,
        required this.bio,
        required this.coverImage});

  factory UserModel.fromDoc(DocumentSnapshot doc){
    final data = doc.data();
    return UserModel(
        id: doc.id,
        name: doc['name'],
        surname: doc['surname'],
        profilePicture: doc['profilePicture'],
        email: doc['email'],
        bio: doc['bio'],
        coverImage: doc['coverImage'],
    );
  }
}