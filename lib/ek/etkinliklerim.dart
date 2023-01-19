import 'package:flamingo_app/Models/place.dart';
import 'package:flamingo_app/Widgets/event.dart';
import 'package:flamingo_app/constants.dart';
import 'package:flamingo_app/ek/detail_page.dart';
import 'package:flamingo_app/ek/detail_page_copy.dart';
import 'package:flutter/material.dart';

class Etkinliklerim extends StatefulWidget {

  const Etkinliklerim({Key? key}) : super(key: key);

  @override
  State<Etkinliklerim> createState() => _EtkinliklerimState();
}

class _EtkinliklerimState extends State<Etkinliklerim> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        centerTitle: true,
        elevation: 0.5,

      ),
      body: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(top:20, left: 30),
            child: Text(
              'Etkinliklerim',
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black
              ),
            ),
          ),
          Container(
            height: 210,
            width: 230,
            margin: EdgeInsets.only(top: 60, right: 50, left: 30),
            child: ListView.builder(
                itemCount: events.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (_, index) {
                  return GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailPageCopy(),),);
                    },

                    child: Container(
                      child: Event(
                        place: events[0],
                      ),
                      padding: const EdgeInsets.only(right: 20),

                    ),


                  );
                }
            ),
          ),
          SizedBox(
            height: 100,
          )
        ],
      ),

    );
  }
}
