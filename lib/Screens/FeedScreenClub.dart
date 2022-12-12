import 'package:flamingo_app/Screens/menus/ChatScreen.dart';
import 'package:flamingo_app/Screens/menus/CreateFlamScreen.dart';
import 'package:flamingo_app/Screens/menus/HomeScreen.dart';
import 'package:flamingo_app/Screens/menus/NotificationScreen.dart';
import 'package:flamingo_app/Screens/menus/SearchScreen.dart';
import 'package:flamingo_app/Screens/menus/akisScreen.dart';
import 'package:flamingo_app/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Widgets/navigation_bar.dart';

class FeedScreenClub extends StatefulWidget {
  const FeedScreenClub({Key? key}) : super(key: key);

  @override
  State<FeedScreenClub> createState() => _FeedScreenClubState();
}

class _FeedScreenClubState extends State<FeedScreenClub> {
  int _selectedTab=0;
  List<Widget>_feedScreens=[
    HomeScreen(),
    AkisScreen(),
    SearchScreen(),
    NotificationScreen(),

  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Clup Anasayfa'),
        backgroundColor: kPrimaryColor,
      ),
      drawer: const NavigationDrawer(),
      body:_feedScreens.elementAt(_selectedTab),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        child: Image.asset('assets/images/login.svg'),
        onPressed:() {
          Navigator.push(context,MaterialPageRoute(builder: (context) => const CreateFlamScreen()));
        },
      ),
      bottomNavigationBar: CupertinoTabBar(
        onTap: (index){
          setState(() {
            _selectedTab=index;
          });
        },
        activeColor: kPrimaryColor,
        currentIndex: _selectedTab,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home)),
          BottomNavigationBarItem(icon: Icon(Icons.flash_on_sharp)),
          BottomNavigationBarItem(icon: Icon(Icons.search)),
          BottomNavigationBarItem(icon: Icon(Icons.notifications)),



        ],
      ),
    );
  }
}
