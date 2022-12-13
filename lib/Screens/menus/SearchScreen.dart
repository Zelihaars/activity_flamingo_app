import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flamingo_app/Models/UserModel.dart';
import 'package:flamingo_app/Screens/menus/ProfilScreen.dart';
import 'package:flamingo_app/Services/DatabaseServices.dart';
import 'package:flamingo_app/constants.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  final String currentUserId;
  const SearchScreen({Key? key, required this.currentUserId}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
   Future<QuerySnapshot> ?_users;
  TextEditingController _searchController=TextEditingController();

  clearSearch(){
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _searchController.clear());
    setState(() {
      _users = null!;
    });
  }
   buildUserTile(UserModel user){
     return ListTile(
       leading: CircleAvatar(
         radius: 20,
         backgroundImage: NetworkImage(user.profilePicture),
       ),
       title: Text(user.name),
       onTap: () {
         Navigator.of(context).push(MaterialPageRoute(
             builder: (context) => ProfilScreen(
               currentUserId: widget.currentUserId,
               visitedUserId: user.id,
             )));
       },
     );
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              ),
              onPressed: () {
                clearSearch();
              },
            ),
            filled: true,
          ),
          onChanged: (input){
            if(input.isNotEmpty){
              setState(() {
                _users=DatabaseServices.searchUsers(input);
              });
            }
          },
        ),
      ),
      body:_users==null
          ? Center(
            child: Column(
             mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.search,size:200),
                Text(
                  'Arama yap',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w400
                  ),
                )
              ],
            ),
          )
          : FutureBuilder(
          future: _users,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.data.docs.length == 0) {
              return Center(
                child: Text('Kullanıcı bulunamadı'),
              );
            }
            return ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (BuildContext context, int index) {
                  UserModel user = UserModel.fromDoc(snapshot.data.docs[index]);
                  return buildUserTile(user);
                });
          }),


    );
  }
}
