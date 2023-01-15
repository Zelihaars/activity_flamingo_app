import 'dart:typed_data';
import 'package:flamingo_app/Screens/WelcomeScreen.dart';
import 'package:flamingo_app/Screens/menus/FeedScreeen.dart';
import 'package:flamingo_app/Screens/login/LoginScreen.dart';
import 'package:flamingo_app/Screens/menus/HomeScreen.dart';
import 'package:flamingo_app/Screens/menus/ProfilScreen.dart';
import 'package:flamingo_app/constants.dart';
import 'package:flutter/material.dart';

class NavigationDrawer extends StatelessWidget {
  final String currentUserId;
  const NavigationDrawer({Key? key, required this.currentUserId,}) : super(key: key);

  @override
  Widget build(BuildContext context) =>Drawer(
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          buildHeader(context),
          buildMenuItems(context),
        ],
      ),
    ),
  );
  Widget buildHeader(BuildContext context) =>Material(
    color: kPrimaryColor,
    child:InkWell(
      onTap: ()=>{
        Navigator.pop(context),
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => const FeedScreen(currentUserId:'' ,))),
      },
      child: Container(
      padding: EdgeInsets.only(
      top:24+MediaQuery.of(context).padding.top,
      bottom: 24,
    ),
    child: Column(
      children: const[

      ],
    ),
      ),
    ));
  Widget buildMenuItems(BuildContext context) =>Container(
    padding: const EdgeInsets.all(24),
    child: Wrap(
      runSpacing:16 ,
      children: [
        ListTile(
         leading: const Icon(Icons.home_outlined),
         title:const Text('Anasayfa'),
         onTap: ()=>{
           Navigator.of(context)
               .push(MaterialPageRoute(builder: (context) => const FeedScreen(currentUserId: '',))),
         },
      ),
        ListTile(
         leading: const Icon(Icons.person_outline),
         title:const Text('Profilim'),
         onTap: ()=>{
           Navigator.push(context,
               MaterialPageRoute(builder: (context)=>ProfilScreen(currentUserId: '', visitedUserId: '')))
         },
      ),
         const Divider(color: Colors.purple),
        ListTile(
          leading: const Icon(Icons.logout_outlined),
         title:const Text('Çıkış'),
          onTap: ()=>{
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => WelcomeScreen())),
          },
      ),
    ],
    ),
  );

}