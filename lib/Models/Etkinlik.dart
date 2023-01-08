import 'package:cloud_firestore/cloud_firestore.dart';

class Etkinlik{
  String id;
  String authorId;
  String activityName;
  String activityPrice;
  String image;
  Timestamp timestamp;
  int add;
  int likes;

  Etkinlik(
      {
      required this.id,
      required this.timestamp,
      required this.add,
      required this.likes,
      required this.authorId,
      required this.image,
      required this.activityName,
      required this.activityPrice,});


  factory Etkinlik.fromDoc(DocumentSnapshot doc){
    final data = doc.data();
    return Etkinlik(
      id: doc.id,
      authorId: doc['authorId'],
      activityName: doc['activityName'],
      image: doc['image'],
      activityPrice: doc['activityPrice'],
      timestamp: doc['timestamp'],
      add: doc['likes'],
      likes: doc['retweets'],
    );
  }
}