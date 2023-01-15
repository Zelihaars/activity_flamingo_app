import 'package:flamingo_app/Models/Etkinlik.dart';
import 'package:flamingo_app/Models/Tweet.dart';
import 'package:flamingo_app/Models/UserModel.dart';
import 'package:flamingo_app/Models/place.dart';
import 'package:flamingo_app/Screens/WelcomeScreen.dart';
import 'package:flamingo_app/Screens/menus/CreateActivity.dart';
import 'package:flamingo_app/Screens/menus/EditProfileScreen.dart';
import 'package:flamingo_app/Screens/menus/detail_page.dart';
import 'package:flamingo_app/Services/DatabaseServices.dart';
import 'package:flamingo_app/Services/auth_service.dart';
import 'package:flamingo_app/Widgets/EtkinlikContainer.dart';
import 'package:flamingo_app/Widgets/TweetContainer.dart';
import 'package:flamingo_app/Widgets/event.dart';
import 'package:flamingo_app/Widgets/navigation_bar.dart';
import 'package:flamingo_app/Widgets/place_card.dart';
import 'package:flamingo_app/constants.dart';
import 'package:flamingo_app/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flamingo_app/Widgets/custom_tabbar.dart';

class HomeScreenClub extends StatefulWidget {
  final String currentUserId;
  final String visitedUserId;
  const HomeScreenClub({Key? key, required this.currentUserId, required this.visitedUserId}) : super(key: key);

  @override
  State<HomeScreenClub> createState() => _HomeScreenClubState();
}

class _HomeScreenClubState extends State<HomeScreenClub> {

  int _profileSegmentedValue=0;
  List<Tweet>? _allTweets;
  List<Etkinlik>? _allEtkinlik;

  Widget buildProfileWidgets(UserModel author){
    switch(_profileSegmentedValue){
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
      case 1:
        return ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: _allEtkinlik!.length,
            itemBuilder: (context, index) {
              return EtkinlikContainer(
                currentUserId: widget.currentUserId,
                author: author,
                etkinlik: _allEtkinlik![index],
              );
            });
        break;
      case 2:
        return const Center(child: Text('Beğeniler',style: TextStyle(fontSize: 25),),);
        break;
      default:
        return const Center(child: Text('Bir şeyler yanlış gitti ',style: TextStyle(fontSize: 25),),);
        break;
    }
  }

  @override
  void initState(){
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    List<String> titles = [
      'Tümü',
      'Trekking',
      'Hiking',
      'Kayak',
      'Su ',
      'Kültürel'
    ];
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        child: Image.asset('assets/images/plus.png'),
        onPressed:() {
          Navigator.push(context,MaterialPageRoute(builder: (context) => CreateActivityScreen(
            currentUserId: widget.currentUserId,
          )));
        },
      ),

      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        centerTitle: true,
        elevation: 0.5,
        title: TextField(

          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical:15),
            hintText: 'Ara...',
            hintStyle: TextStyle(
              color:Colors.white,
            ),
            border: InputBorder.none,
            prefixIcon: Icon(Icons.search,color:Colors.white,),
            suffixIcon: IconButton(
              icon:Icon(
                Icons.clear,color: Colors.white,
              ), onPressed: () {  },

            ),
            filled: true,
          ),
        ),
      ),
      drawer: NavigationDrawer(currentUserId: '',),
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
                  margin: EdgeInsets.only(top: 10, left: 10, right: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundImage: userModel.profilePicture.isEmpty
                                ? AssetImage('assets/images/placeholder.png') as  ImageProvider
                                : NetworkImage(userModel.profilePicture),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children:[
                                Text(
                                  'Hoşgeldin',
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold

                                  ),
                                ),
                                Text(
                                  userModel.name +" "+ userModel.surname,
                                  style: const TextStyle(
                                    fontSize: 15,

                                  ),
                                ),

                              ]

                          ),

                        ],
                      ),
                      Container(
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
                            'Kulüp',
                            style: TextStyle(
                                fontSize: 17,
                                color: kPrimaryColor,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 25, left: 30),
                  child: Text(
                    "Yeni etkinliklere hazır mısın ",
                    style: textStyle1,
                  ),
                ),
                Container(
                    height: 30,
                    margin: EdgeInsets.only(top: 25, left: 30),
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: titles.length,
                        itemBuilder: (_, index) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 30),
                            child: Column(
                              children: [
                                Text(
                                  titles[index],
                                  style: textStyle4.copyWith(
                                      color: (index == 0) ? mainCOlor : Colors.black),
                                ),
                                (index == 0)
                                    ? Container(
                                  width: 20,
                                  height: 2,
                                  decoration: BoxDecoration(
                                      color: mainCOlor,
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(4))),
                                )
                                    : SizedBox()
                              ],
                            ),
                          );
                        })),
                Container(
                  margin: EdgeInsets.only(top: 36, left: 30, right: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Popüler Yerler",
                        style: textStyle2,
                      ),
                      Text(
                        "Tümünü gör",
                        style: textStyle4,
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 30, top: 20),
                  height: 200,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: places.length,
                      itemBuilder: (_, index) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: PlaceCard(
                            place: places[index],
                            index: index,
                          ),
                        );
                      }),
                ),
                Container(
                  margin: EdgeInsets.only(left: 30, right: 30, top: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Etkinlikler',
                        style: textStyle2,
                      ),
                      Text(
                        'Tümünü gör',
                        style: textStyle4,
                      )
                    ],
                  ),
                ),
                Container(
                  height: 210,
                  width: 230,
                  margin: EdgeInsets.only(top: 40, right: 30, left: 30),
                  child: ListView.builder(
                      itemCount: events.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (_, index) {
                        return GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailPage(),),);
                          },
                          child: Container(
                            child: Event(
                              place: events[index],
                            ),
                            padding: const EdgeInsets.only(right: 20),

                          ),


                        );
                      }
                  ),
                ),
                SizedBox(
                  height: 100,
                )
              ],
            );
          }

      ),
    );
  }
}
