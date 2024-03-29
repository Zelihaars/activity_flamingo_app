import 'package:flamingo_app/Models/place.dart';
import 'package:flamingo_app/theme.dart';
import 'package:flutter/material.dart';

class Event extends StatelessWidget {
  final Place place;
  const Event({Key? key, required this.place}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 210,
      width: 230,
      padding: EdgeInsets.only(left: 20, top: 20),
      decoration: BoxDecoration(
        // color: mainCOlor,
          borderRadius: BorderRadius.all(Radius.circular(20)),

          image: DecorationImage(
              image: AssetImage(place.imageUrl), fit: BoxFit.cover)),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${place.event},',
            style: textStyle3.copyWith(fontWeight: FontWeight.bold),
          ),
          Text(
            '${place.city}',
            style: textStyle3.copyWith(fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Image(image: AssetImage('assets/map.png')),
              SizedBox(
                width: 6,
              ),
              Text(
                '${place.country}',
                style: textStyle3.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          )
        ],

      ),
    );
  }
}
