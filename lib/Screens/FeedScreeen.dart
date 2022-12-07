import 'package:flamingo_app/Screens/ChatScreen.dart';
import 'package:flamingo_app/Screens/CreateFlamScreen.dart';
import 'package:flamingo_app/Screens/HomeScreen.dart';
import 'package:flamingo_app/Screens/NotificationScreen.dart';
import 'package:flamingo_app/Screens/ProfilScreen.dart';
import 'package:flamingo_app/Screens/SearchScreen.dart';
import 'package:flamingo_app/Screens/akisScreen.dart';
import 'package:flamingo_app/Widgets/navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  int _selectedTab=0;
  List<Widget>_feedScreens=[
    HomeScreen(),
    AkisScreen(),
    SearchScreen(),
    NotificationScreen(),
    ChatScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        backgroundColor: Colors.purple,
      ),
      drawer: const NavigationDrawer(),
      body:_feedScreens.elementAt(_selectedTab),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        child: Image.asset('assets/images/plus.png'),
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
        activeColor: Colors.purple,
        currentIndex: _selectedTab,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home)),
          BottomNavigationBarItem(icon: Icon(Icons.flash_on_sharp)),
          BottomNavigationBarItem(icon: Icon(Icons.search)),
          BottomNavigationBarItem(icon: Icon(Icons.notifications)),
          BottomNavigationBarItem(icon: Icon(Icons.chat)),


        ],
      ),
    );
  }
}


