import 'package:flamingo_app/Screens/menus/CreateFlamScreen.dart';
import 'package:flamingo_app/Widgets/navigation_bar.dart';
import 'package:flamingo_app/constants.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        backgroundColor: kBackgroundColor,
      ),
      drawer: const NavigationDrawer(currentUserId: ''),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        child: Image.asset('assets/images/plus.png'),
        onPressed:() {
          Navigator.push(context,MaterialPageRoute(builder: (context) => const CreateFlamScreen()));
        },
      ),
      body: Center(
        child: Text('Anasayfa'),
      ),
    );
  }
}
