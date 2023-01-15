import 'package:flamingo_app/theme.dart';
import 'package:flutter/material.dart';
import 'package:flamingo_app/constants.dart';

class DetailPage extends StatelessWidget {

  const DetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: Container(
              margin: EdgeInsets.only(
                top: 400,
              ),
              decoration: BoxDecoration(
                color:bgColor2,
              ),
              child: Container(
                margin: EdgeInsets.only(left: 30, right: 30),
                child: ListView(
                  children: [
                    SizedBox(
                      height: 160,
                    ),
                    Text(
                      'Açıklama',
                      style: TextStyle(
                          color: Colors.white
                      ),
                    ),
                    SizedBox(
                      height: 9,
                    ),
                    Text(
                      'Tarihi bir kale olan Palu Kalesinde bizimle beraber eşşiz bir etkinliğe ne dersiniz',
                      style: TextStyle(
                        color: Colors.white
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          SafeArea(
            child: Container(
              margin: EdgeInsets.only(top: 310),
              padding: EdgeInsets.symmetric(horizontal: 30),
              height: 230,
              decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(40),
                      bottomRight: Radius.circular(40))),
              child: ListView(children: [
                SizedBox(
                  height: 110,
                ),
                Row(
                  children: [
                    Text(
                      "Palu Kalesi,",
                      style: textStyle1.copyWith(color: mainCOlor),
                    ),
                    SizedBox(
                      width: 9,
                    ),
                    Text(
                      "Elazığ",
                      style: textStyle1.copyWith(color: mainCOlor),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                              BorderRadius.all(Radius.circular(12))),
                          child: Center(
                            child: Image.asset('assets/star.png'),
                          ),
                        ),
                        SizedBox(
                          width: 9,
                        ),
                        Text(
                          '4.92',
                          style: TextStyle(
                            color: Colors.white
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                              BorderRadius.all(Radius.circular(12))),
                          child: Center(
                            child: Image.asset('assets/awan.png'),
                          ),
                        ),
                        SizedBox(
                          width: 9,
                        ),
                        Text(
                          '27ºC',
                          style: TextStyle(
                              color: Colors.white
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                              BorderRadius.all(Radius.circular(12))),
                          child: Center(
                            child: Image.asset('assets/pesawat.png'),
                          ),
                        ),
                        SizedBox(
                          width: 9,
                        ),
                        Text(
                          '9 Jam',
                          style: TextStyle(
                              color: Colors.white
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ]),
            ),
          ),
          SafeArea(
            child: Container(
              height: 400,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/nusa.jpg'), fit: BoxFit.cover),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(40),
                      bottomRight: Radius.circular(40))),
            ),
          ),
          GestureDetector(
          onTap: (){
            Navigator.pop(context);
          },
          ),
          SafeArea(
              child: Container(
                margin: EdgeInsets.only(top: 30, left: 30),
                // color: mainCOlor,
                child: Image.asset('assets/back.png'),
              )),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 30),
              color: bgColor,
              height: 68,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Fiyat",
                        style: TextStyle(
                            color: Colors.white
                        ),
                      ),
                      Text(
                        "50 TL",
                        style: textStyle2.copyWith(color: mainCOlor),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    child: Text('Rezerve et'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kPrimaryColor,
                      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10), // <-- Radius
                      ),
                    ),
                    onPressed: () =>
                       print("ödeme yapıldı")
                  ),

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
