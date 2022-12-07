import 'package:firebase_core/firebase_core.dart';
import 'package:flamingo_app/Screens/FeedScreeen.dart';
import 'package:flamingo_app/Screens/SliderScreen.dart';
import 'package:flamingo_app/Screens/WelcomeScreen.dart';
import 'package:flutter/material.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      home:SliderScreen(),
    );
  }
}

