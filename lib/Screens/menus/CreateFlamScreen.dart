import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flamingo_app/Models/Tweet.dart';
import 'package:flamingo_app/Services/DatabaseServices.dart';
import 'package:flamingo_app/Services/StorageService.dart';
import 'package:flamingo_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CreateFlamScreen extends StatefulWidget {
  final String currentUserId;
  const CreateFlamScreen({Key? key, required this.currentUserId}) : super(key: key);

  @override
  State<CreateFlamScreen> createState() => _CreateFlamScreenState();
}

class _CreateFlamScreenState extends State<CreateFlamScreen> {
  String? _tweetText;
  File? _pickedImage;
  bool _loading = false;

  handleImageFromGallery()async{
    try{
      final ImagePicker _picker = ImagePicker();
      final XFile? imageFile = await _picker.pickImage(source: ImageSource.gallery);

      if (imageFile != null){
          setState(() {
            _pickedImage= File(imageFile.path);
          });
      }
    }catch (e) {
      print(e);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          backgroundColor: kPrimaryColor,
            centerTitle: true,
          title: Text(
            'Paylaşım',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20
            ),
          ),
      ),
      body:Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
        children: [
         SizedBox(height: 20),
           TextField(
             maxLength: 270,
             maxLines: 7,
             decoration: InputDecoration(
               hintText: 'Paylaşım yap',
                ),
             onChanged: (value) {
               _tweetText = value;
              },
              ),
          SizedBox(height: 10),
          _pickedImage == null
              ? SizedBox.shrink()
              : Column(
            children: [
              Container(
                height: 200,
                decoration: BoxDecoration(
                    color: kPrimaryColor,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: FileImage(_pickedImage!),
                    )),
              ),
              SizedBox(height: 20),
            ],
          ),
          GestureDetector(
            onTap: handleImageFromGallery,
            child: Container(
              height: 70,
              width: 70,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                border: Border.all(
                  color: kPrimaryColor,
                  width: 2,
                ),
              ),
              child: Icon(
                Icons.camera_alt,
                size: 50,
                color: kPrimaryColor,
              ),
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            child: Text('Paylaşım Yap'),
            style: ElevatedButton.styleFrom(
              backgroundColor: kPrimaryColor,
              padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30), // <-- Radius
              ),
            ),
            onPressed: () async{
              setState(() {
                _loading = true;
              });
              if(_tweetText != null && _tweetText!.isNotEmpty){
                String image;
                if(_pickedImage == null){
                  image = '';
                }else {
                  image =
                  await StorageService.uploadTweetPicture(_pickedImage!);
                }
                Tweet tweet =Tweet(
                  id: '',
                  text: _tweetText!,
                  image: image,
                  authorId: widget.currentUserId,
                  likes: 0,
                  retweets: 0,
                  timestamp: Timestamp.fromDate(
                    DateTime.now(),
                  ),
                );
                DatabaseServices.createTweet(tweet);
                Navigator.pop(context);
              }
              setState(() {
                _loading = false;
              });
            }
          ),
          SizedBox(height: 20),
          _loading ? CircularProgressIndicator() : SizedBox.shrink()
        ],
      ),
    ),
              );
  }
}
