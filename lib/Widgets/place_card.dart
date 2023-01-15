import 'package:flamingo_app/Models/place.dart';
import 'package:flamingo_app/theme.dart';
import 'package:flutter/material.dart';

class PlaceCard extends StatelessWidget {
  final Place place;
  final int index;
  const PlaceCard({Key? key, required this.place, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 170,
      width: 120,
      margin: EdgeInsets.only(top: 20),

      child: Column(
        children: [
          Stack(
            children: [
              Container(
                height: 120,
                width: 120,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                    image: DecorationImage(
                        image: AssetImage(place.imageUrl), fit: BoxFit.cover)),
              ),
              (index == 0)
                  ? Positioned(
                  top: 0.0,
                  right: 0.0,
                  child: Container(
                    height: 30,
                    width: 70,
                  

                  ))
                  : SizedBox()
            ],
          ),
          Container(
            width: 120,
            height: 50,
            decoration: BoxDecoration(
              color: mainCOlor,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20)),
            ),
            child: Center(
              child: Text(
                place.city,
                style: textStyle3,
              ),
            ),
          )
        ],
      ),
    );
  }
}
