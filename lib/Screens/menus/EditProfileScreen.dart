
import 'dart:io';
import 'package:flamingo_app/Models/UserModel.dart';
import 'package:flamingo_app/Services/DatabaseServices.dart';
import 'package:flamingo_app/Services/StorageService.dart';
import 'package:flamingo_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileScreen extends StatefulWidget {
  final UserModel user;
  const EditProfileScreen({Key? key, required this.user}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  String? _name;
  String? _email;
  String? _surname;
  String? _bio;
  File? _profileImage;
  File? _coverImage;
  late String _imagePickedType;
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  displayCoverImage() {
    if(_coverImage==null){
      if(widget.user.coverImage.isEmpty){
        return AssetImage('assets/images/background.png');
      }else{
        return NetworkImage(widget.user.coverImage);
      }
    }else{
      return FileImage(_coverImage!);
    }
  }
  displayProfileImage() {
    if(_profileImage==null){
      if(widget.user.profilePicture.isEmpty){
        return AssetImage('assets/images/placeholder.png');
      }else{
        return NetworkImage(widget.user.profilePicture);
      }
    }else{
      return FileImage(_profileImage!);
    }
  }
  saveProfile() async {
    _formKey.currentState!.save();
    if (_formKey.currentState!.validate() && !_isLoading) {
      setState(() {
        _isLoading = true;
      });
      String profilePictureUrl = '';
      String coverPictureUrl = '';
      if (_profileImage == null) {
        profilePictureUrl = widget.user.profilePicture;
      } else {
        profilePictureUrl = await StorageService.uploadProfilePicture(
            widget.user.profilePicture, _profileImage!);
      }
      if (_coverImage == null) {
        coverPictureUrl = widget.user.coverImage;
      } else {
        coverPictureUrl = await StorageService.uploadCoverPicture(
            widget.user.coverImage, _coverImage!);
      }
      UserModel user = UserModel(
        id: widget.user.id,
        name: _name!,
        surname: _surname!,
        profilePicture: profilePictureUrl,
        bio: _bio!,
        email: _email!,
        coverImage: coverPictureUrl,
      );

      DatabaseServices.updateUserData(user);
      Navigator.pop(context);
    }
  }

  handleImageFromGallery()async{
    try{
      final ImagePicker _picker = ImagePicker();
      final XFile? imageFile = await _picker.pickImage(source: ImageSource.gallery);
      if (imageFile != null){
        if (_imagePickedType == 'profile'){
          setState(() {
            _profileImage= File(imageFile.path);
          });
        }else if (_imagePickedType == 'cover') {
          setState(() {
            _coverImage = File(imageFile.path);
          });
        }
      }
    }catch (e) {
      print(e);
    }
  }
  @override
  void initState(){
    super.initState();
    _name=widget.user.name;
    _surname=widget.user.surname;
    _bio=widget.user.bio;

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:ListView(
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
        children: [
          GestureDetector(
            onTap: (){
              _imagePickedType='cover';
              handleImageFromGallery();
            },
            child: Stack(
              children: [
                Container(
                    height: 150,
                  decoration: BoxDecoration(
                    color: kPrimaryColor,
                    image: _coverImage == null && widget.user.coverImage.isEmpty
                        ? null
                        : DecorationImage(
                      fit: BoxFit.cover,
                      image: displayCoverImage(),
                    ),
                  ),
                ),
                Container(
                  height: 150,
                  color:Colors.black54,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.camera_alt_outlined,
                        size: 70,
                        color: Colors.white,
                      ),
                      Text(
                        'Fotoğrafı Değiştir',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color:Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            transform: Matrix4.translationValues(0.0, -40.0, 0.0),
             padding: EdgeInsets.symmetric(horizontal: 20),
            child:Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: (){
                          _imagePickedType='profile';
                           handleImageFromGallery();
                              },
                      child: Stack(
                        children: [
                          CircleAvatar(
                            radius: 45,
                            backgroundImage: displayProfileImage(),
                          ),
                          CircleAvatar(
                            radius: 45,
                            backgroundColor: Colors.black54,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Icon(
                                  Icons.camera_alt_outlined,
                                  size: 25,
                                  color: Colors.white,),
                                Text(
                                   'Profil Fotoğrafını Değiştir',
                                    textAlign: TextAlign.center,
                                     style: TextStyle(
                                     color:Colors.white,
                                    fontSize:10,
                                  fontWeight: FontWeight.bold
                                    ),
                      )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: saveProfile,
                      child: Container(
                        width: 100,
                        height: 35,
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: kPrimaryColor,
                        ),
                        child: Center(
                          child: Text(
                            'Kaydet',
                            style: TextStyle(
                                fontSize: 17,
                                color:Colors.white,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                Form(
                  key: _formKey,
                  child:Column(
                    children: [
                      SizedBox(height: 30,),
                      TextFormField(
                        initialValue: _name,
                        decoration: InputDecoration(
                          labelText: 'İsim',
                          labelStyle: TextStyle(
                            color: kPrimaryColor
                          )
                        ),
                        validator: (input)=>input!.trim().length<2?
                            'Lütfen geçerli bir isim girin'
                            :null,
                        onSaved: (value){
                          _name=value!;
                        },
                      ),
                      SizedBox(height: 30,),
                      TextFormField(
                        initialValue: _surname,
                        decoration: InputDecoration(
                            labelText: 'Soyisim',
                            labelStyle: TextStyle(
                                color: kPrimaryColor
                            )
                        ),
                        validator: (input)=>input!.trim().length<2?
                        'Lütfen geçerli bir soyisim girin'
                            :null,
                        onSaved: (value){
                          _surname=value!;
                        },
                      ),
                      SizedBox(height: 30,),
                      TextFormField(
                        initialValue: _bio,
                        decoration: InputDecoration(
                            labelText: 'Hakkında',
                            labelStyle: TextStyle(
                                color: kPrimaryColor
                            )
                        ),
                        onSaved: (value){
                          _bio=value!;
                        },
                      ),
                      SizedBox(height: 30,),
                      _isLoading
                      ? CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation(kPrimaryColor),
                      )
                          :SizedBox.shrink()

                    ],
                  ) ,
                )
              ],
    )

          )
        ],
          ),
    );
  }
}
