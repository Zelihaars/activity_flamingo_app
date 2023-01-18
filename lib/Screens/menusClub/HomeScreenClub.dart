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
        Navigator.push(context,MaterialPageRoute(builder: (context) => CreateFlamScreen(
          currentUserId: widget.currentUserId,
        )));
      },
    ),
  );
  }
}
