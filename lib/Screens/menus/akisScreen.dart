import 'package:flutter/material.dart';

class AkisScreen extends StatefulWidget {

  const AkisScreen({Key? key}) : super(key: key);

  @override
  State<AkisScreen> createState() => _AkisScreenState();
}

class _AkisScreenState extends State<AkisScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Paylaşımlar'),
      ),
    );
  }
}
