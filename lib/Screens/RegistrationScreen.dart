import 'package:flamingo_app/Services/auth_service.dart';
import 'package:flutter/material.dart';
class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  late String _name;
  late String _surname;
  late String _phone;
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
          'Kayıt',
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
                hintText: 'adınızı girin',
              ),
              onChanged: (value) {
                _name = value;
              },
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              decoration: InputDecoration(
                hintText: 'soyadınızı girin',
              ),
              onChanged: (value) {
                _surname = value;
              },
            ),
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
              decoration: InputDecoration(
                hintText: 'telefon nosu girin',
              ),
              onChanged: (value) {
                _phone = value;
              },
            ),
            SizedBox(
              height: 20,
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
              child: Text('Kayıt Ol '),
              style: ElevatedButton.styleFrom(
                elevation: 5,
                padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 20),
                primary: Colors.purple,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30), // <-- Radius
                ),
              ),
              onPressed: ()async{
                bool isValid=await AuthService.signUp(_name,_surname,_email,_phone,_password);
                if(isValid){
                  Navigator.pop(context);
                }else{
                  print("Kayıt oluşturulmadı");
                }
              },

            ),
          ],
        ),
      ),
    );
  }
}
