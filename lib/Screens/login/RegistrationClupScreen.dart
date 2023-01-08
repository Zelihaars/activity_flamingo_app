import 'package:flamingo_app/Screens/login/LoginScreen.dart';
import 'package:flamingo_app/Services/auth_service.dart';
import 'package:flamingo_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
class RegistrationClupScreen extends StatefulWidget {
  const RegistrationClupScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationClupScreen> createState() => _RegistrationClupScreenState();
}

class _RegistrationClupScreenState extends State<RegistrationClupScreen> {
  late String name;
  late String surname;
  late String _phone;
  late String _email;
  late String _password;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    double viewInset = MediaQuery.of(context).viewInsets.bottom;
    double defaultLoginSize = size.height - (size.height * 0.2);
    double defaultRegisterSize = size.height - (size.height * 0.1);
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
                      SvgPicture.asset('assets/images/login.svg'),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 7),
                        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                        width: size.width*0.8,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: kPrimaryColor.withAlpha(50)
                        ),
                        child: TextField(
                          cursorColor: kPrimaryColor,
                          decoration: InputDecoration(
                            icon: Icon(Icons.home,color: kPrimaryColor,),
                            hintText: 'Kulüp veya Üniversite adını girin',
                            border: InputBorder.none,
                          ),
                          onChanged: (value) {
                            name = value;
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 7),
                        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                        width: size.width*0.8,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: kPrimaryColor.withAlpha(50)
                        ),
                        child: TextField(
                          cursorColor: kPrimaryColor,
                          decoration: InputDecoration(
                            icon: Icon(Icons.home_outlined,color: kPrimaryColor,),
                            hintText: 'Kulüp dalını girin',
                            border: InputBorder.none,
                          ),
                          onChanged: (value) {
                            surname = value;
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 7),
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
                        margin: EdgeInsets.symmetric(vertical:7),
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
                        margin: EdgeInsets.symmetric(vertical: 7),
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
                      SizedBox(height: 10,
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
                          bool isValid=await AuthService.ClubsignUp(name,surname,_email,_phone,_password);
                          if(isValid){
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) => const LoginScreen()));
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

          ],
        )


    );
  }
}
