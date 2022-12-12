import 'package:flamingo_app/Models/UserModel.dart';
import 'package:flamingo_app/Screens/EditProfileScreen.dart';
import 'package:flamingo_app/Services/DatabaseServices.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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

  int _profileSegmentedValue=0;
  Map<int, Widget>_profileTabs = <int, Widget>{
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
    2: Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        'Beğeniler',
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
      ),
    ),
  };
  Widget buildProfileWidgets(){
    switch(_profileSegmentedValue){
      case 0:
        return Center(child: Text('Paylaşımlar',style: TextStyle(fontSize: 25),),);
        break;
      case 1:
        return Center(child: Text('Görseller',style: TextStyle(fontSize: 25),),);
        break;
      case 2:
        return Center(child: Text('Beğeniler',style: TextStyle(fontSize: 25),),);
        break;
      default:
        return Center(child: Text('Bir şeyler yanlış gitti ',style: TextStyle(fontSize: 25),),);
        break;
    }
  }

  getFollowersCount()async{
    int followersCount=await DatabaseServices.followersNum(widget.visitedUserId);
    if(mounted){
      setState(() {
        _followersCount=_followersCount;
      });
    }
  }
  getFollowingCount()async{
    int followingCount=await DatabaseServices.followingNum(widget.visitedUserId);
    if(mounted){
      setState(() {
        _followingCount=_followingCount;
      });
    }
  }
  @override
  void initState(){
    super.initState();
    getFollowersCount();
    getFollowingCount();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder(
          future: usersRef.doc(widget.visitedUserId).get(),
          builder: (BuildContext context, AsyncSnapshot snapshot){
            if (!snapshot.hasData){
              return Center(
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
                        image: userModel.coverImage.isEmpty
                            ? null
                            : DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(userModel.coverImage),
                        )
                    ),
                  child:Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:[
                          SizedBox.shrink(),
                          PopupMenuButton(
                              icon:const Icon(
                                Icons.more_horiz,
                                color: Colors.white,
                                size:30,
                              ),itemBuilder:(_){
                            return <PopupMenuItem<String>>[
                              new PopupMenuItem(
                                child: Text('Logout'),
                                value: 'logout',
                              )
                            ];

                          },
                              onSelected: (selectedItem){

                              }
                          )
                        ]
                    ),
                  )

                ),
                Container(
                  transform: Matrix4.translationValues(0.0, -40.0, 0.0),
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          CircleAvatar(
                            radius: 45,
                            backgroundImage: NetworkImage(userModel.profilePicture??'https://cdn-icons-png.flaticon.com/512/149/149071.png'),
                          ),
                          GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>EditProfileScreen(
                                user:userModel,
                              ),
                              ),
                              );
                            },
                            child: Container(
                              width: 100,
                              height: 35,
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white,
                                border: Border.all(color: kPrimaryColor),
                              ),
                              child: Center(
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
                        ],
                      ),
                    SizedBox(height: 10,),
                    Text(
                      userModel.name +" "+ userModel.surname,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                     SizedBox(height: 10,),
                       Text(
                      userModel.bio,
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(height: 15,),
                    Row(
                      children: [
                        Text(
                          '$_followingCount Takipçi',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 2,
                          ),
                        ),
                        SizedBox(width: 20,),
                          Text(
                          '$_followersCount Takip Edilenler',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 2,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20,),
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
                buildProfileWidgets(),
              ],
            );
          }

      ),
    );
  }
}
