import 'package:cloud_firestore/cloud_firestore.dart';

class Etkinlik{
  String id;
  String authorId;
  String activityName;
  String activityPrice;
  String activityLocation;
  String activityDetail;
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
      required this.activityPrice,
      required this.activityLocation,
      required this.activityDetail

      });


  factory Etkinlik.fromDoc(DocumentSnapshot doc){
    final data = doc.data();
    return Etkinlik(
      id: doc.id,
      authorId: doc['authorId'],
      activityName: doc['activityName'],
      image: doc['image'],
      activityPrice: doc['activityPrice'],
      activityLocation: doc['activityLocation'],
      activityDetail: doc['activityDetail'],
      timestamp: doc['timestamp'],
      add: doc['likes'],
      likes: doc['retweets'],
    );
  }
}