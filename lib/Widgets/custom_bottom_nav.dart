import 'package:flamingo_app/theme.dart';
import 'package:flutter/material.dart';

class CustomNavbar extends StatelessWidget {

  const CustomNavbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 68,
      color: bgColor2,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image(image: AssetImage('assets/home.png')),
              SizedBox(
                width: 8,
              ),
              Container(
                child: Center(
                  child: Text('Home',
                      style: textStyle3.copyWith(
                          decoration: TextDecoration.none,
                          color: mainCOlor,
                          fontSize: 14,
                          fontWeight: FontWeight.w500)),
                ),
              )
            ],
          ),
          Image(image: AssetImage('assets/Notif.png')),
          Image(image: AssetImage('assets/Menu.png')),
          Image(image: AssetImage('assets/Setting.png')),
        ],
      ),
    );
  }
}
