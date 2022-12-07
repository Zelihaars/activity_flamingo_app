import 'package:flamingo_app/Screens/FeedScreeen.dart';
import 'package:flamingo_app/Screens/RegistrationScreen.dart';
import 'package:flutter/material.dart';

import '../Services/auth_service.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late String _email;
  late String _password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.purple,
        centerTitle: true,
        elevation: 0,
        title: Text(
          'Giriş',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            TextField(
              decoration: InputDecoration(
                hintText: 'email adresinizi girin',
              ),
              onChanged: (value) {
                _email = value;
              },
            ),
            SizedBox(
              height: 30,
            ),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'şifrenizi girin',
              ),
              onChanged: (value) {
                _password = value;
              },
            ),
            SizedBox(
              height: 40,
            ),

            ElevatedButton(
              child: Text('Giriş '),
              style: ElevatedButton.styleFrom(
                elevation: 5,
                padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 20),
                primary: Colors.purple,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30), // <-- Radius
                ),
              ),
              onPressed: ()async{
                bool isValid=await AuthService.login(_email,_password);
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => const FeedScreen()));
                if(isValid){
                  print("Giriş Yapıldı");
                }else{
                  print("Giriş Yapılamadı");
                }
              },

            ),
          ],
        ),
      ),

    );
  }
}
