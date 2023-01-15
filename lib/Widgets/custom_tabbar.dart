import 'package:flamingo_app/theme.dart';
import 'package:flutter/material.dart';

class  Customtabbar  extends StatelessWidget {
  final List<String> titles;
  const  Customtabbar ({Key? key, required this.titles}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.horizontal,
      children: titles
          .map((e) => Padding(
        padding: EdgeInsets.only(right: 30),
        child: Container(
          height: 30,
          width: 50,
          color: Colors.blue,
          child: Column(
            children: [
              Text(
                e,
                style: textStyle4,
              ),
              Container(
                width: 20,
                height: 2,
                decoration: BoxDecoration(
                    color: mainCOlor,
                    borderRadius: BorderRadius.all(Radius.circular(4))),
              )
            ],
          ),
        ),
      ))
          .toList(),
    );
  }
}
