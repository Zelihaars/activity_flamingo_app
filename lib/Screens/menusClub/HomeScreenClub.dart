import 'package:flamingo_app/Widgets/navigation_bar.dart';
import 'package:flamingo_app/constants.dart';
import 'package:flutter/material.dart';

class HomeScreenClub extends StatefulWidget {

  const HomeScreenClub({Key? key}) : super(key: key);

  @override
  State<HomeScreenClub> createState() => _HomeScreenClubState();
}

class _HomeScreenClubState extends State<HomeScreenClub> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        backgroundColor: kBackgroundColor,
      ),
      drawer:NavigationDrawer(currentUserId: '',),
      body: Center(
        child: Text('Anasayfa'),
      ),
    );
  }
}
