import 'package:flamingo_app/Models/Etkinlik.dart';
import 'package:flamingo_app/Models/UserModel.dart';
import 'package:flamingo_app/Services/DatabaseServices.dart';
import 'package:flamingo_app/constants.dart';
import 'package:flutter/material.dart';

class EtkinlikContainer extends StatefulWidget {
  final Etkinlik etkinlik;
  final UserModel author;
  final String currentUserId;

  const EtkinlikContainer({Key? key, required this.etkinlik, required this.author, required this.currentUserId}) : super(key: key);

  @override
  State<EtkinlikContainer> createState() => _EtkinlikContainerState();
}

class _EtkinlikContainerState extends State<EtkinlikContainer> {
  int _likesCount = 0;
  bool _isLiked = false;

  initActivityLikes() async {
    bool isLiked =
    await DatabaseServices.isLikeActivity(widget.currentUserId, widget.etkinlik);
    if (mounted) {
      setState(() {
        _isLiked = isLiked;
      });
    }
  }
  likeActivity() {
    if (_isLiked) {
      DatabaseServices.unlikeActivity(widget.currentUserId, widget.etkinlik);
      setState(() {
        _isLiked = false;
        _likesCount--;
      });
    } else {
      DatabaseServices.likeActivity(widget.currentUserId, widget.etkinlik);
      setState(() {
        _isLiked = true;
        _likesCount++;
      });
    }
  }
  @override
  void initState() {
    super.initState();
    _likesCount = widget.etkinlik.likes;
   initActivityLikes();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                  radius: 20,
                  backgroundImage: widget.author.profilePicture.isEmpty?
                  AssetImage('assets/images/placeholder.png') as ImageProvider
                      :NetworkImage(widget.author.profilePicture)
              ),
              SizedBox(height: 15,),
              Text(
                " "+" "+widget.author.name+" "+widget.author.surname,
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold
                ),
              )
            ],
          ),
          SizedBox(height: 15),
          Text(widget.etkinlik.activityName,
            style: TextStyle(
                fontSize: 15
            ),),
          widget.etkinlik.image.isEmpty?
          SizedBox.shrink():
          Column(
            children: [
              SizedBox(height: 15,),
              Container(
                height: 250,
                decoration: BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(widget.etkinlik.image),
                    )
                ),
              )
            ],
          ),
          SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(
                          _isLiked?Icons.favorite:Icons.favorite_border,
                          color: _isLiked?Colors.purple:Colors.black,
                        ),
                        onPressed:likeActivity,
                      ),
                      Text(
                        _likesCount.toString()+' Beğeni',
                      )
                    ],
                  ),

                ],
              ),
              Text(
                widget.etkinlik.timestamp.toDate().toString().substring(0,19),
                style: TextStyle(
                    color: Colors.grey
                ),
              )
            ],
          ),
          SizedBox(height: 15),
          Divider()
        ],
      ),
    );
  }
}
