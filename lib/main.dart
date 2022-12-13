import 'package:firebase_core/firebase_core.dart';
import 'package:flamingo_app/Screens/FeedScreeen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flamingo_app/Screens/login/LoginScreen.dart';
import 'package:flamingo_app/Screens/login/RegistrationClupScreen.dart';
import 'package:flamingo_app/Screens/SliderScreen.dart';
import 'package:flamingo_app/Screens/login/RegistrationScreen.dart';
import 'package:flamingo_app/Services/auth_service.dart';
import 'package:flamingo_app/Screens/WelcomeScreen.dart';
import 'package:flutter/material.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
 Widget getScreenId(){
   return StreamBuilder(
       stream: FirebaseAuth.instance.authStateChanges(),
       builder: (BuildContext context , snapshot){
         if(snapshot.hasData){
           return FeedScreen(currentUserId: snapshot.data!.uid,);
         }else{
           return WelcomeScreen();
         }
       });
 }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      home:getScreenId(),
    );
  }
}

