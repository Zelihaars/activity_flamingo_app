import 'package:flamingo_app/Models/Tweet.dart';
import 'package:flamingo_app/Models/UserModel.dart';
import 'package:flamingo_app/Services/DatabaseServices.dart';
import 'package:flamingo_app/constants.dart';
import 'package:flutter/material.dart';

class TweetContainer extends StatefulWidget {
  final Tweet tweet;
  final UserModel author;
  final String currentUserId;

  const TweetContainer({Key? key, required this.tweet, required  this.author, required this.currentUserId}) : super(key: key);

  @override
  State<TweetContainer> createState() => _TweetContainerState();
}

class _TweetContainerState extends State<TweetContainer> {

  int _likesCount = 0;
  bool _isLiked = false;

  initTweetLikes() async {
    bool isLiked =
    await DatabaseServices.isLikeTweet(widget.currentUserId, widget.tweet);
    if (mounted) {
      setState(() {
        _isLiked = isLiked;
      });
    }
  }
  likeTweet() {
    if (_isLiked) {
      DatabaseServices.unlikeTweet(widget.currentUserId, widget.tweet);
      setState(() {
        _isLiked = false;
        _likesCount--;
      });
    } else {
      DatabaseServices.likeTweet(widget.currentUserId, widget.tweet);
      setState(() {
        _isLiked = true;
        _likesCount++;
      });
    }
  }
  @override
  void initState() {
    super.initState();
    _likesCount = widget.tweet.likes;
    initTweetLikes();
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
          Text(widget.tweet.text,
            style: TextStyle(
              fontSize: 15
          ),),
          widget.tweet.image.isEmpty?
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
                        image: NetworkImage(widget.tweet.image),
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
                          onPressed:likeTweet,
                          ),
                      Text(
                       _likesCount.toString()+' Beğeni',
                      )
                    ],
                  ),

                ],
              ),
              Text(
                widget.tweet.timestamp.toDate().toString().substring(0,19),
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
