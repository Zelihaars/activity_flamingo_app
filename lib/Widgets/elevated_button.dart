import 'package:flutter/material.dart';

import '../Screens/RegistrationScreen.dart';

class ElevatedButton extends StatelessWidget {
  final String btnText;

  const ElevatedButton({this.btnText=">>>",  Key? key})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      color: Colors.purple,
      borderRadius: BorderRadius.circular(30),
      child: MaterialButton(
        onPressed: () => Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const RegistrationScreen())),
        minWidth: 320,
        height: 60,
        child: Text(
          btnText,
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    );
  }
}