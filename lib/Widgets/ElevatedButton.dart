import 'package:flutter/material.dart';

class ElevatedButton extends StatelessWidget {
  final String btnText;
  final Function onBtnPressed;

  const ElevatedButton({required this.btnText,  Key? key, required this.onBtnPressed})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      color: Colors.purple,
      borderRadius: BorderRadius.circular(30),
      child: MaterialButton(
        onPressed: onBtnPressed(),
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