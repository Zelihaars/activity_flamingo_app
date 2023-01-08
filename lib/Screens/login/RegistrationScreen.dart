import 'package:flamingo_app/Screens/menus/FeedScreeen.dart';
import 'package:flamingo_app/Screens/login/LoginScreen.dart';
import 'package:flamingo_app/Screens/login/RegistrationClupScreen.dart';
import 'package:flamingo_app/Services/auth_service.dart';
import 'package:flamingo_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> with SingleTickerProviderStateMixin {
  bool isLogin = true;
  late Animation<double> containerSize;
  late AnimationController animationController;
  Duration animationDuration = Duration(milliseconds: 270);

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(vsync: this, duration: animationDuration);
  }

  @override
  void dispose() {
    animationController!.dispose();
    super.dispose();
  }
  late String _name;
  late String _surname;
  late String _phone;
  late String _email;
  late String _password;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    double viewInset = MediaQuery.of(context).viewInsets.bottom;
    double defaultLoginSize = size.height - (size.height * 0.2);
    double defaultRegisterSize = size.height - (size.height * 0.1);

    containerSize = Tween<double>(begin: size.height * 0.1, end: defaultRegisterSize).animate(CurvedAnimation(parent: animationController, curve: Curves.linear));
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body:Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: SingleChildScrollView(
                child: Container(
                  width:size.height ,
                  height: defaultLoginSize,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset('assets/images/register.svg'),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 5),
                        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                        width: size.width*0.8,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: kPrimaryColor.withAlpha(50)
                        ),
                        child: TextField(
                          cursorColor: kPrimaryColor,
                          decoration: InputDecoration(
                            icon: Icon(Icons.person,color: kPrimaryColor,),
                            hintText: 'adınızı girin',
                            border: InputBorder.none,
                          ),
                          onChanged: (value) {
                            _name = value;
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 5),
                        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                        width: size.width*0.8,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: kPrimaryColor.withAlpha(50)
                        ),
                        child: TextField(
                          cursorColor: kPrimaryColor,
                          decoration: InputDecoration(
                            icon: Icon(Icons.person_outline,color: kPrimaryColor,),
                            hintText: 'soyadınızı girin',
                            border: InputBorder.none,
                          ),
                          onChanged: (value) {
                            _surname = value;
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical:5),
                        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                        width: size.width*0.8,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: kPrimaryColor.withAlpha(50)
                        ),
                        child: TextField(
                          cursorColor: kPrimaryColor,
                          decoration: InputDecoration(
                            icon: Icon(Icons.email,color: kPrimaryColor,),
                            hintText: 'email adresinizi girin',
                            border: InputBorder.none,
                          ),
                          onChanged: (value) {
                            _email = value;
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 5),
                        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                        width: size.width*0.8,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: kPrimaryColor.withAlpha(50)
                        ),
                        child: TextField(
                          cursorColor: kPrimaryColor,
                          decoration: InputDecoration(
                            icon: Icon(Icons.phone,color: kPrimaryColor,),
                            hintText: 'telefon nosu girin',
                            border: InputBorder.none,
                          ),
                          onChanged: (value) {
                            _phone = value;
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 5),
                        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                        width: size.width*0.8,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: kPrimaryColor.withAlpha(50)
                        ),
                        child: TextField(
                          obscureText: true,
                          cursorColor: kPrimaryColor,
                          decoration: InputDecoration(
                            icon: Icon(Icons.password,color: kPrimaryColor,),
                            hintText: 'şifrenizi girin',
                            border: InputBorder.none,
                          ),
                          onChanged: (value) {
                            _password = value;
                          },
                        ),
                      ),
                      SizedBox(height: 5,
                      ),
                      ElevatedButton(
                        child: Text('Kaydol '),
                        style: ElevatedButton.styleFrom(
                          elevation: 5,
                          padding: const EdgeInsets.symmetric(horizontal: 130, vertical: 20),
                          backgroundColor: kPrimaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10), // <-- Radius
                          ),
                        ),
                        onPressed: ()async{
                          bool isValid=await AuthService.signUp(_name,_surname,_email,_phone,_password);
                          if(isValid){
                            Navigator.pop(context);
                            print("Kayıt oluşturuldu ");
                          }else{
                            print("Kayıt oluşturulamadı");
                          }
                        },

                      ),
                    ],
                  ),
                ),
              ),
            ),
            AnimatedBuilder(
                animation: animationController,
                builder: (context,child){
              return buildClubContainer();
            })
          ],
        )


    );
  }

  Widget buildClubContainer() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: double.infinity,
        height: containerSize.value,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(100),
                topRight: Radius.circular(100)
            ),
            color: kBackgroundColor
        ),
        alignment: Alignment.center,
        child: GestureDetector(
          onTap: (){
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => const RegistrationClupScreen()));
          },
          child: Text(
            "Kulüp kaydı için tıklayın ...",
            style: TextStyle(
                color: Colors.black,
                fontSize: 18

            ),
          ),
        ),
      ),
    );
  }
}
