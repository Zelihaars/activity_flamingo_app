import 'package:flamingo_app/Screens/menus/FeedScreeen.dart';
import 'package:flamingo_app/Screens/menusClub/FeedScreenClub.dart';
import 'package:flamingo_app/Services/auth_service.dart';
import 'package:flamingo_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginScreenClub extends StatefulWidget {

  const LoginScreenClub({Key? key}) : super(key: key);

  @override
  State<LoginScreenClub> createState() => _LoginScreenClubState();
}

class _LoginScreenClubState extends State<LoginScreenClub> {
  bool isLogin = true;
  late Animation<double> containerSize;
  Duration animationDuration = Duration(milliseconds: 270);

  @override
  void initState() {
    super.initState();

  }



  late String _email;
  late String _password;
  late String userType;

  bool _isObscure = true;

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
                      Text(
                        "Hoş Geldiniz",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24
                        ),
                      ),

                      SvgPicture.asset('assets/images/login.svg'),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
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
                        margin: EdgeInsets.symmetric(vertical:3),
                        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                        width: size.width*0.8,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: kPrimaryColor.withAlpha(50)
                        ),
                        child: TextField(
                          obscureText: _isObscure,
                          cursorColor: kPrimaryColor,
                          decoration: InputDecoration(

                            prefixIcon: IconButton(
                              icon: Icon(Icons.password,color: kPrimaryColor),
                            onPressed: () {
                              setState(() {
                                _isObscure = !_isObscure;
                              });
                            }
                            ),
                            hintText: 'şifrenizi girin',
                            border: InputBorder.none,
                          ),
                          onChanged: (value) {
                            _password = value;
                          },
                        ),

                      ),
                      SizedBox(height: 5,),
                      ElevatedButton(
                        child: Text('Giriş '),
                        style: ElevatedButton.styleFrom(
                          elevation: 5,
                          padding: const EdgeInsets.symmetric(horizontal: 130, vertical: 20),
                          backgroundColor: kPrimaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10), // <-- Radius
                          ),
                        ),
                        onPressed: ()async{
                          bool isValid=await AuthService.login(_email,_password);
                          if(isValid){
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) => const FeedScreenClub(currentUserId: '')));
                            print("Giriş Başarılı");
                          }else{
                            _showDialog(context);
                            print("Giriş Yapılamadı");
                          }
                        },

                      ),
                      SizedBox(height: 20,),
                      ElevatedButton(
                        child: Text('Google ile Giriş '),
                        style: ElevatedButton.styleFrom(
                          elevation: 5,
                          padding: const EdgeInsets.symmetric(horizontal: 95, vertical: 20),
                          backgroundColor:kOrangeColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10), // <-- Radius
                          ),
                        ),
                        onPressed: ()async{

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
void _showDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: new Text("Uyarı"),
        content: new Text(
          "kullanıcı maili ya da şifre yanlış",
          style: TextStyle(
              color: Colors.red
          ),
        ),

        actions: <Widget>[
          new ElevatedButton(
            child: new Text("Kapat"),
            style: ElevatedButton.styleFrom(
              backgroundColor: kPrimaryColor,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}