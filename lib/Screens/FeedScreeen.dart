import 'package:flamingo_app/Screens/menus/ChatScreen.dart';
import 'package:flamingo_app/Screens/menus/CreateFlamScreen.dart';
import 'package:flamingo_app/Screens/menus/HomeScreen.dart';
import 'package:flamingo_app/Screens/menus/NotificationScreen.dart';
import 'package:flamingo_app/Screens/menus/ProfilScreen.dart';
import 'package:flamingo_app/Screens/menus/SearchScreen.dart';
import 'package:flamingo_app/Screens/menus/akisScreen.dart';
import 'package:flamingo_app/Widgets/navigation_bar.dart';
import 'package:flamingo_app/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FeedScreen extends StatefulWidget {
  final String currentUserId;
  const FeedScreen({Key? key, required this.currentUserId,}) : super(key: key);

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  int _selectedTab=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:[
        HomeScreen(),
        AkisScreen(),
        SearchScreen(
          currentUserId: widget.currentUserId,
        ),
        NotificationScreen(),
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
          BottomNavigationBarItem(icon: Icon(Icons.flash_on_sharp)),
          BottomNavigationBarItem(icon: Icon(Icons.search)),
          BottomNavigationBarItem(icon: Icon(Icons.notifications)),
          BottomNavigationBarItem(icon: Icon(Icons.person)),


        ],
      ),
    );
  }
}


