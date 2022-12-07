import 'dart:typed_data';

import 'package:flamingo_app/Screens/FeedScreeen.dart';
import 'package:flamingo_app/Screens/LoginScreen.dart';
import 'package:flamingo_app/Screens/ProfilScreen.dart';
import 'package:flutter/material.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

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
    color: Colors.purple,
    child:InkWell(
      onTap: ()=>{
        Navigator.pop(context),
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => const ProfilScreen())),
      },
      child: Container(
      padding: EdgeInsets.only(
      top:24+MediaQuery.of(context).padding.top,
      bottom: 24,
    ),
    child: Column(
      children: const[
        CircleAvatar(
          radius: 52,
          backgroundImage: NetworkImage(
            'https://images.unsplash.com/photo-1517841905240-472988babdf9?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80'
          ),
        ),
        SizedBox(height: 12),
        Text(
            'username',
          style: TextStyle(fontSize: 28,color: Colors.white),
        ),
        Text(
          'user@gmail.com',
          style: TextStyle(fontSize: 16,color: Colors.white),
        ),

      ],
    ),
      ),
    ));

  Widget  buildMenuItems(BuildContext context) =>Container(
    padding: const EdgeInsets.all(24),
    child: Wrap(
      runSpacing:16 ,
      children: [
        ListTile(
         leading: const Icon(Icons.home_outlined),
         title:const Text('Anasayfa'),
         onTap: ()=>{
           Navigator.of(context)
               .push(MaterialPageRoute(builder: (context) => const FeedScreen())),
         },
      ),
        ListTile(
         leading: const Icon(Icons.person_outline),
         title:const Text('Profilim'),
         onTap: ()=>{
           Navigator.of(context)
               .push(MaterialPageRoute(builder: (context) => const ProfilScreen())),
         },
      ),
         const Divider(color: Colors.purple),
        ListTile(
         leading: const Icon(Icons.favorite_border),
         title:const Text('Favorilerim'),
         onTap: ()=>{
           Navigator.of(context)
               .push(MaterialPageRoute(builder: (context) => const FeedScreen())),
         },

  ),

        ListTile(
         leading: const Icon(Icons.workspaces_outline),
          title:const Text('Etkinliklerim'),

          onTap: ()=>{
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => const FeedScreen())),
          },
      ),
        ListTile(
          leading: const Icon(Icons.account_tree_outlined),
           title:const Text('Paylaşımlarım'),
           onTap: ()=>{
             Navigator.of(context)
                 .push(MaterialPageRoute(builder: (context) => const FeedScreen())),
           },
      ),
        ListTile(
          leading: const Icon(Icons.logout_outlined),
         title:const Text('Çıkış'),
          onTap: ()=>{
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => const LoginScreen())),
          },
      ),
    ],
    ),
  );

}