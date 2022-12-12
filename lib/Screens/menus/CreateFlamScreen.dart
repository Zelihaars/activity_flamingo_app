import 'package:flutter/material.dart';

class CreateFlamScreen extends StatefulWidget {

  const CreateFlamScreen({Key? key}) : super(key: key);

  @override
  State<CreateFlamScreen> createState() => _CreateFlamScreenState();
}

class _CreateFlamScreenState extends State<CreateFlamScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Paylaşım Yap'),
      ),
    );
  }
}
