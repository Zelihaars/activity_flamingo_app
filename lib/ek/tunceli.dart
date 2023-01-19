import 'package:flamingo_app/Models/place.dart';
import 'package:flamingo_app/Widgets/event.dart';
import 'package:flamingo_app/constants.dart';
import 'package:flamingo_app/ek/detail_page.dart';
import 'package:flutter/material.dart';

class Tunceli extends StatefulWidget {

  const Tunceli({Key? key}) : super(key: key);

  @override
  State<Tunceli> createState() => _TunceliState();
}

class _TunceliState extends State<Tunceli> {
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
            margin: EdgeInsets.only(top:20, left: 40),
            child: Text(
              'Tunceli Etkinlikleri',
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
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailPage(),),);
                    },

                    child: Container(
                      child: Event(
                        place: events[1],
                      ),
                      padding: const EdgeInsets.only(right: 20),

                    ),


                  );
                }
            ),
          ),
          SizedBox(
            height: 100,
          ),

        ],
      ),

    );
  }
}
