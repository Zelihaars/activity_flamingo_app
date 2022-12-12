import 'package:flamingo_app/Screens/WelcomeScreen.dart';
import 'package:flamingo_app/misc/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flamingo_app/Screens/login/LoginScreen.dart';
import '../Screens/login/RegistrationScreen.dart';

class ResponsiveButton extends StatelessWidget {
  bool? isResponsive;
  double? width;
  final String btnText;
  ResponsiveButton({this.btnText="  Başla > ",Key? key,this.width,this.isResponsive=false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      color: Colors.deepPurpleAccent,
      borderRadius: BorderRadius.circular(30),
      child: MaterialButton(
        onPressed: () => Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => WelcomeScreen())),
        minWidth: 100,
        height: 60,
        child: Text(
          btnText,
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    );
  }
}
