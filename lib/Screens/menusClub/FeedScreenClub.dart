import 'package:flamingo_app/Screens/menus/ChatScreen.dart';
import 'package:flamingo_app/Screens/menus/CreateFlamScreen.dart';
import 'package:flamingo_app/Screens/menus/HomeScreen.dart';
import 'package:flamingo_app/Screens/menus/NotificationScreen.dart';
import 'package:flamingo_app/Screens/menus/ProfilScreen.dart';
import 'package:flamingo_app/Screens/menus/SearchScreen.dart';
import 'package:flamingo_app/Screens/menus/akisScreen.dart';
import 'package:flamingo_app/Screens/menusClub/HomeScreenClub.dart';
import 'package:flamingo_app/Widgets/navigation_bar.dart';
import 'package:flamingo_app/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FeedScreenClub extends StatefulWidget {
  final String currentUserId;
  const FeedScreenClub({Key? key, required this.currentUserId}) : super(key: key);

  @override
  State<FeedScreenClub> createState() => _FeedScreenClubState();
}

class _FeedScreenClubState extends State<FeedScreenClub> {
  int _selectedTab=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:[
        HomeScreenClub(
          currentUserId: widget.currentUserId,
          visitedUserId: widget.currentUserId,
        ),
        SearchScreen(
          currentUserId: widget.currentUserId,
        ),
        NotificationScreen(
          currentUserId: widget.currentUserId,
        ),
        ProfilScreen(
          currentUserId: widget.currentUserId,
          visitedUserId: widget.currentUserId,
        ),
      ].elementAt(_selectedTab),
      bottomNavigationBar: CupertinoTabBar(
        onTap: (index){
          setState(() {
            _selectedTab=index;
          });
        },
        activeColor:kPrimaryColor,
        currentIndex: _selectedTab,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home)),
          BottomNavigationBarItem(icon: Icon(Icons.search)),
          BottomNavigationBarItem(icon: Icon(Icons.notifications)),
          BottomNavigationBarItem(icon: Icon(Icons.person)),


        ],
      ),
    );
  }
}
