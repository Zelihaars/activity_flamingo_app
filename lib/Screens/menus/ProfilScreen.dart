import 'package:flamingo_app/Models/Etkinlik.dart';
import 'package:flamingo_app/Models/Tweet.dart';
import 'package:flamingo_app/Models/UserModel.dart';
import 'package:flamingo_app/Screens/WelcomeScreen.dart';
import 'package:flamingo_app/Screens/menus/CreateFlamScreen.dart';
import 'package:flamingo_app/Screens/menus/EditProfileScreen.dart';
import 'package:flamingo_app/Services/DatabaseServices.dart';
import 'package:flamingo_app/Services/auth_service.dart';
import 'package:flamingo_app/Widgets/EtkinlikContainer.dart';
import 'package:flamingo_app/Widgets/TweetContainer.dart';
import 'package:flamingo_app/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class ProfilScreen extends StatefulWidget {
  final String currentUserId;
  final String visitedUserId;

  const ProfilScreen({Key? key, required this.currentUserId, required this.visitedUserId}) : super(key: key);

  @override
  State<ProfilScreen> createState() => _ProfilScreenState();
}

class _ProfilScreenState extends State<ProfilScreen> {
  int _followersCount=0;
  int _followingCount=0;
  bool _isFollowing=false;
  int _profileSegmentedValue=0;
  List<Tweet>? _allTweets;
  List<Etkinlik>? _allEtkinlik;
  List<Etkinlik>? _mediaActivity=[];
  List<Tweet>? _mediaTweets=[];
  Map<int, Widget> _profileTabs = <int, Widget>{
    0: Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        'Paylaşımlar',
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
      ),
    ),
    1: Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        'Görseller',
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
      ),
    ),
  };

  Widget buildProfileWidgets(UserModel author) {
    switch (_profileSegmentedValue) {
      case 0:
        return ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: _allTweets!.length,
            itemBuilder: (context, index) {
              return TweetContainer(
                currentUserId: widget.currentUserId,
                author: author,
                tweet: _allTweets![index],
              );
            });
        break;
      case 1:
        return ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: _mediaTweets!.length,
            itemBuilder: (context, index) {
              return TweetContainer(
                currentUserId: widget.currentUserId,
                author: author,
                tweet: _mediaTweets![index],
              );
            });
        break;
      default:
        return Center(
            child: Text('Birşeyler yanlış gitti', style: TextStyle(fontSize: 25)));
        break;
    }
  }


  getFollowersCount()async{
    int followersCount=await DatabaseServices.followersNum(widget.visitedUserId);
    if(mounted){
      setState(() {
        _followersCount=followersCount;
      });
    }
  }
  getFollowingCount()async{
    int followingCount=await DatabaseServices.followingNum(widget.visitedUserId);
    if(mounted){
      setState(() {
        _followingCount=followingCount;
      });
    }
  }

  followOrUnfollow(){
    if (_isFollowing) {
      unFollowUser();
    } else {
      followUser();
    }
  }
  unFollowUser() {
    DatabaseServices.unFollowUser(widget.currentUserId, widget.visitedUserId);
    setState(() {
      _isFollowing = false;
      _followersCount--;
    });
  }
  followUser() {
    DatabaseServices.followUser(widget.currentUserId, widget.visitedUserId);
    setState(() {
      _isFollowing = true;
      _followersCount++;
    });
  }
  setupIsFollowing() async {
    bool isFollowingThisUser = await DatabaseServices.isFollowingUser(
        widget.currentUserId, widget.visitedUserId);
    setState(() {
      _isFollowing = isFollowingThisUser;
    });
  }
  getAllTweets() async {
    List<Tweet>? userTweets = (await DatabaseServices.getUserTweets(widget.visitedUserId)).cast<Tweet>();
    if (mounted) {
      setState(() {
        _allTweets = userTweets;
        _mediaTweets =
            _allTweets!.where((element) => element.image.isNotEmpty).toList();
      });
    }
  }

  getAllActivity() async {
    List<Etkinlik>? clubetkinlikler = (await DatabaseServices.getUserActivity(widget.visitedUserId)).cast<Etkinlik>();
    if (mounted) {
      setState(() {
        _allEtkinlik = clubetkinlikler;
        _mediaActivity =_allEtkinlik!.where((element) => element.image.isNotEmpty).toList();
      });
    }
  }

  @override
  void initState(){
    super.initState();
    getFollowersCount();
    getFollowingCount();
    setupIsFollowing();
    getAllTweets();
    getAllActivity();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        child: Image.asset('assets/images/plus.png'),
        onPressed:() {
          Navigator.push(context,MaterialPageRoute(builder: (context) => CreateFlamScreen(
            currentUserId: widget.currentUserId,
          )));
        },
      ),
      backgroundColor: Colors.white,
      body: FutureBuilder(
          future: usersRef.doc(widget.visitedUserId).get(),
          builder: (BuildContext context, AsyncSnapshot snapshot){
            if (!snapshot.hasData){
              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(kPrimaryColor),
                ),
              );
            }
            UserModel userModel = UserModel.fromDoc(snapshot.data);
            return ListView(
            physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
            ),
              children: [
                Container(
                  height: 150,
                    decoration: BoxDecoration(
                        color: kPrimaryColor,
                      image:DecorationImage(
                        fit: BoxFit.cover,
                        image:userModel.coverImage.isEmpty
                            ?AssetImage('assets/images/background.png')as ImageProvider
                            : NetworkImage(userModel.coverImage)

                      ),
                    ),
                  child:Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:[
                          const SizedBox.shrink(),
                          widget.currentUserId==widget.visitedUserId?
                          PopupMenuButton(
                              icon:const Icon(
                                Icons.more_horiz,
                                color: Colors.white,
                                size:30,
                              ),itemBuilder:(_){
                            return <PopupMenuItem<String>>[
                              new PopupMenuItem(
                                child: Text('Çıkış'),
                                value: 'logout',
                              )
                            ];

                          },
                              onSelected: (selectedItem){
                                if (selectedItem == 'logout'){
                                  AuthService.logout();
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              WelcomeScreen()));
                                }
                              },
                          )
                              :const SizedBox(),
                        ]
                    ),
                  )

                ),
                Container(
                  transform: Matrix4.translationValues(0.0, -40.0, 0.0),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          CircleAvatar(
                            radius: 45,
                            backgroundImage: userModel.profilePicture.isEmpty
                                ? AssetImage('assets/images/placeholder.png') as  ImageProvider
                                : NetworkImage(userModel.profilePicture),
                          ),
                          widget.currentUserId==widget.visitedUserId
                              ?GestureDetector(
                            onTap: ()async{
                              await Navigator.push(context, MaterialPageRoute(builder: (context)=>EditProfileScreen(
                                user:userModel,
                              ),
                              ),
                              );
                              setState(() {

                              });
                            },
                            child: Container(
                              width: 100,
                              height: 35,
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white,
                                border: Border.all(color: kPrimaryColor),
                              ),
                              child: const Center(
                                child: Text(
                                  'Düzenle',
                                  style: TextStyle(
                                    fontSize: 17,
                                    color: kPrimaryColor,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                              ),
                            ),
                          )
                              :GestureDetector(
                            onTap: followOrUnfollow,
                            child: Container(
                              width: 100,
                              height: 35,
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color:  _isFollowing?kPrimaryColor:Colors.white,
                                border: Border.all(color: kPrimaryColor),
                              ),
                              child: Center(
                                child: Text(
                                  _isFollowing? 'Takip Ediliyor':'Takip Et',
                                  style: TextStyle(
                                      fontSize: 12,
                                      color:  _isFollowing?Colors.white:kPrimaryColor,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    const SizedBox(height: 10,),
                    Text(
                     userModel.name +" "+ userModel.surname,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                     const SizedBox(height: 10,),
                       Text(
                      userModel.bio,
                      style: const TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 15,),
                    Row(
                      children: [
                        Text(
                          '$_followingCount Takip Edilen',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 2,
                          ),
                        ),
                        const SizedBox(width: 20,),
                          Text(
                          '$_followersCount Takipçi',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 2,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20,),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: CupertinoSlidingSegmentedControl(
                        groupValue: _profileSegmentedValue,
                        thumbColor: kPrimaryColor,
                        backgroundColor: Colors.blueGrey,
                        children: _profileTabs,
                        onValueChanged: (i) {
                          setState(() {
                            _profileSegmentedValue = i!;
                          });
                        },
                      ),
                    )
                    ],
                  ),
                ),
                buildProfileWidgets(userModel),
              ],
            );
          }

      ),
    );
  }
}
