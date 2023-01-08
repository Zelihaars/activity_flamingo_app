import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flamingo_app/Models/Etkinlik.dart';
import 'package:flamingo_app/Models/UserModel.dart';
import 'package:flamingo_app/Screens/menus/CreateActivity.dart';
import 'package:flamingo_app/Screens/menus/CreateFlamScreen.dart';
import 'package:flamingo_app/Services/DatabaseServices.dart';
import 'package:flamingo_app/Widgets/navigation_bar.dart';
import 'package:flamingo_app/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'ProfilScreen.dart';

class HomeScreen extends StatefulWidget {
  final String currentUserId;
  final String visitedUserId;
  const HomeScreen({Key? key, required this.currentUserId, required this.visitedUserId}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<QuerySnapshot> ?_activity;
  TextEditingController _searchController=TextEditingController();

  clearSearch(){
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _searchController.clear());
    setState(() {
      _activity = null!;
    });
  }
  buildActivityTile(Etkinlik etkinlik){
    return ListTile(
      leading: CircleAvatar(
        radius: 20,
        backgroundImage: NetworkImage(etkinlik.image),
      ),
      title: Text(etkinlik.activityName),
      onTap: () {
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        child: Image.asset('assets/images/plus.png'),
        onPressed:() {
          Navigator.push(context,MaterialPageRoute(builder: (context) => CreateActivityScreen(
            currentUserId: widget.currentUserId,
          )));
        },
      ),

      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        centerTitle: true,
        elevation: 0.5,
        title: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical:15),
            hintText: 'Ara...',
            hintStyle: TextStyle(
              color:Colors.white,
            ),
            border: InputBorder.none,
            prefixIcon: Icon(Icons.search,color:Colors.white,),
            suffixIcon: IconButton(
              icon:Icon(
                Icons.clear,color: Colors.white,
              ), onPressed: () {  },

            ),
            filled: true,
          ),
        ),
      ),
      drawer: NavigationDrawer(currentUserId: '',),




    );
  }
}
