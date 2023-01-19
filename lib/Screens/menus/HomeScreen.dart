import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flamingo_app/Models/Etkinlik.dart';
import 'package:flamingo_app/Models/Tweet.dart';
import 'package:flamingo_app/Models/UserModel.dart';
import 'package:flamingo_app/Models/place.dart';
import 'package:flamingo_app/Screens/WelcomeScreen.dart';
import 'package:flamingo_app/Screens/menus/CreateActivity.dart';
import 'package:flamingo_app/Screens/menus/CreateFlamScreen.dart';
import 'package:flamingo_app/Screens/menus/EditProfileScreen.dart';
import 'package:flamingo_app/ek/detail_page.dart';
import 'package:flamingo_app/Services/DatabaseServices.dart';
import 'package:flamingo_app/Services/auth_service.dart';
import 'package:flamingo_app/Widgets/EtkinlikContainer.dart';
import 'package:flamingo_app/Widgets/TweetContainer.dart';
import 'package:flamingo_app/Widgets/event.dart';
import 'package:flamingo_app/Widgets/navigation_bar.dart';
import 'package:flamingo_app/Widgets/place_card.dart';
import 'package:flamingo_app/constants.dart';
import 'package:flamingo_app/ek/detail_page1.dart';
import 'package:flamingo_app/ek/detail_page3.dart';
import 'package:flamingo_app/ek/elazig.dart';
import 'package:flamingo_app/ek/tunceli.dart';
import 'package:flamingo_app/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flamingo_app/Widgets/custom_tabbar.dart';
Size? size;
class HomeScreen extends StatefulWidget {
  final String currentUserId;
  final String visitedUserId;

  const HomeScreen({Key? key, required this.currentUserId, required this.visitedUserId}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int _profileSegmentedValue=0;
  // bool _isUser=true;

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
          Navigator.push(context,MaterialPageRoute(builder: (context) => CreateFlamScreen(
            currentUserId: widget.currentUserId,
          )));
        },
      ),
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        centerTitle: true,
        elevation: 0.5,

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
                               userModel.name ,
                               style: const TextStyle(
                                 fontSize: 15,

                               ),
                             ),

                           ]

                       ),

                     ],
                   ),

                 ],
               ),
             ),
             Container(
               margin: EdgeInsets.only(top: 25, left: 30),
               child: Text(
                 'Etkinliklere katılmaya hazır mısın',
                 style: TextStyle(
                     fontSize: 22,
                     fontWeight: FontWeight.bold,
                     color: Colors.black
                 ),
               ),
             ),

             Container(
               margin: EdgeInsets.only(top: 36, left: 30, right: 30),
               child: Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                   Text(
                     "Şehirler",
                     style: textStyle2,
                   ),

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
                     return GestureDetector(
                       onTap: (){
                         Navigator.push(context, MaterialPageRoute(builder: (context)=>Elazig(),
                         ),);
                       },
                       onLongPress: (){
                         Navigator.push(context, MaterialPageRoute(builder: (context)=>Tunceli(),
                         ),);
                       },

                       child: Container(
                         child: PlaceCard(
                           place: places[index],
                           index: index,
                         ),
                         padding: const EdgeInsets.only(right: 20),

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
                       onDoubleTap: (){
                         Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailPage1(),),);
                       },
                       onLongPress: (){
                         Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailPage3(),),);
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
