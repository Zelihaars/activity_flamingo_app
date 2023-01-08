import 'package:flamingo_app/Models/Tweet.dart';
import 'package:flamingo_app/Models/UserModel.dart';
import 'package:flamingo_app/Screens/menus/CreateFlamScreen.dart';
import 'package:flamingo_app/Services/DatabaseServices.dart';
import 'package:flamingo_app/Widgets/TweetContainer.dart';
import 'package:flamingo_app/constants.dart';
import 'package:flutter/material.dart';

class AkisScreen extends StatefulWidget {
  final String currentUserId;
  final String visitedUserId;

  const AkisScreen({Key? key, required this.currentUserId, required this.visitedUserId,}) : super(key: key);

  @override
  State<AkisScreen> createState() => _AkisScreenState();
}

class _AkisScreenState extends State<AkisScreen> {
  List _followingTweets = [];
  bool _loading = false;

  buildTweets(Tweet tweet, UserModel author) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: TweetContainer(
        tweet: tweet,
        author: author,
        currentUserId: widget.currentUserId,
      ),
    );
  }
  showFollowingTweets(String currentUserId) {
    List<Widget> followingTweetsList = [];
    for (Tweet tweet in _followingTweets) {
      followingTweetsList.add(FutureBuilder(
          future: usersRef.doc(tweet.authorId).get(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              UserModel author = UserModel.fromDoc(snapshot.data);
              return buildTweets(tweet, author);
            } else {
              return SizedBox.shrink();
            }
          }));
    }
    return followingTweetsList;
  }


  setupFollowingTweets() async {
    setState(() {
      _loading = true;
    });
    List followingTweets =
    await DatabaseServices.getHomeTweets(widget.visitedUserId);
    if (mounted) {
      setState(() {
        _followingTweets = followingTweets;
         _loading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    setupFollowingTweets();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        child: Image.asset('assets/images/plus.png'),
        onPressed:() {
          Navigator.push(context,MaterialPageRoute(builder: (context) => CreateFlamScreen(
           currentUserId: widget.currentUserId,
          )));
        },
      ),

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        centerTitle: true,
        leading: Container(
          height: 40,
          child: Image.asset('assets/images/flamingo.png'),
        ),
        title: Text(
          'Paylaşımlar',
          style: TextStyle(
            color: kPrimaryColor,
          ),
        ),
      ),

      body: RefreshIndicator(
        onRefresh: () =>setupFollowingTweets(),
        child:ListView(
          physics: BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          children: [
            _loading ? LinearProgressIndicator() : SizedBox.shrink(),
            SizedBox(height: 5),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 5),
                Column(
                  children: _followingTweets.isEmpty && _loading == false
                      ? [
                    SizedBox(height: 5),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        'Henüz hiç paylaşım yok',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    )
                  ]
                      : showFollowingTweets(widget.currentUserId),

                ),
              ],
            )
          ],
        ),

      ),
    );
  }
}
