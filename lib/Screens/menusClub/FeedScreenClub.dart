import 'package:flamingo_app/Screens/menus/HomeScreen.dart';
import 'package:flamingo_app/Screens/menus/HomeScreen.dart';
import 'package:flamingo_app/Screens/menus/ProfilScreen.dart';
import 'package:flamingo_app/Screens/menusClub/HomeScreenClub.dart';
import 'package:flamingo_app/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Widgets/navigation_bar.dart';

class FeedScreenClub extends StatefulWidget {
  final String currentUserId;
  const FeedScreenClub({Key? key, required this.currentUserId,}) : super(key: key);

  @override
  State<FeedScreenClub> createState() => _FeedScreenClubState();
}

class _FeedScreenClubState extends State<FeedScreenClub> {
  int _selectedTab=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: [
        HomeScreenClub(),
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
          BottomNavigationBarItem(icon: Icon(Icons.person)),


        ],

      ),

    );
  }
}
