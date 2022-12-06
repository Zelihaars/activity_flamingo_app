import 'package:flutter/material.dart';
import 'package:flamingo_app/Screens/LoginScreen.dart';
import 'package:flamingo_app/Screens/RegistrationScreen.dart';


class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}



class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                  ),
                  Image.asset(
                    'assets/images/flamingo.png',
                    height: 200,
                    width: 200,
                  ),
                  Text(
                    'Flamingo ',
                    style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),

                  ),
                ],
              ),
              Column(
                children: [
                  ElevatedButton(
                    child: Text('Giriş Yap'),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.deepPurpleAccent,
                      padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30), // <-- Radius
                      ),
                    ),
                    onPressed: () => Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) => const LoginScreen())),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                    child: Text('Kayıt ol'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 20),
                      primary: Colors.deepPurpleAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30), // <-- Radius
                      ),
                    ),
                    onPressed: () => Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) => const RegistrationScreen())),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}