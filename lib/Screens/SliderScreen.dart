import 'package:flamingo_app/Screens/LoginScreen.dart';
import 'package:flamingo_app/Widgets/app_large_text.dart';
import 'package:flamingo_app/Widgets/app_text.dart';
import 'package:flamingo_app/Widgets/responsive_button.dart';
import 'package:flamingo_app/Widgets/elevated_button.dart';
import 'package:flamingo_app/misc/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'RegistrationScreen.dart';
class SliderScreen extends StatefulWidget {
  const SliderScreen({Key? key}) : super(key: key);

  @override
  State<SliderScreen> createState() => _SliderScreenState();
}

class _SliderScreenState extends State<SliderScreen> {

  List images=[
    "camping.jpg",
    "mountain.jpg",
    "trekking.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:PageView.builder(
          scrollDirection: Axis.vertical,
          itemCount: images.length,
          itemBuilder:(_,index){
            return Container(
              width: double.maxFinite,
              height: double.maxFinite,
              decoration: BoxDecoration(
                  image:DecorationImage(
                      image:AssetImage(
                          "assets/img/"+images[index]
                      ),
                      fit:BoxFit.cover
                  )
              ),
              child: Container(
                margin: const EdgeInsets.only(top:150,left:20,right: 20),
                child:Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppLargeText(text: "Flamingo"),
                        AppText(text: "Etkinlik",size: 30),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: 250,
                          child: AppText(
                            text: "Doğa sporları, kültürel etkinlikler, "
                                "sosyal etkinlikler ve daha fazlası için...",
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        ResponsiveButton(),
                      ],
                    ),
                    Column(
                      children: List.generate(3, (indexDots){
                        return Container(
                          margin: const EdgeInsets.only(bottom: 2),
                          width:8,
                          height: index==indexDots?25:8,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: index==indexDots?AppColors.mainColor:AppColors.mainColor.withOpacity(0.3)
                          ),
                        );
                        }),

                )
                  ]
                )
              ),
            );
          }),
    );
  }
}
