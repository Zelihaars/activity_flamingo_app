import 'package:flutter/material.dart';

class ProfilScreen extends StatefulWidget {

  const ProfilScreen({Key? key}) : super(key: key);

  @override
  State<ProfilScreen> createState() => _ProfilScreenState();
}

class _ProfilScreenState extends State<ProfilScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Profil Bilgileri'),
      ),
    );
  }
}
