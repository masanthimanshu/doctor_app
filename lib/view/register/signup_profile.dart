import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctors_app/components/navigation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class SignupProfile extends StatefulWidget {
  const SignupProfile({super.key});

  @override
  State<SignupProfile> createState() => _SignupProfileState();
}

class _SignupProfileState extends State<SignupProfile> {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final _userId = FirebaseAuth.instance.currentUser!.uid;
  final _storageRef = FirebaseStorage.instance.ref();
  final ImagePicker _picker = ImagePicker();

  late File _imageFile;
  bool _hideUI = true;
  bool _showImg = false;

  String _name = "";
  String _email = "";
  String _imageUrl = "https://cdn-icons-png.flaticon.com/512/149/149071.png";

  _checkData() {
    _db.collection("users").doc(_userId).get().then((value) {
      if (value.exists) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const BottomNavbar()),
          ModalRoute.withName("/home"),
        );
      } else {
        setState(() {
          _hideUI = false;
        });
      }
    });
  }

  _uploadImage() async {
    debugPrint("Clicked");

    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 75,
    );

    if (image != null) {
      setState(() {
        _imageFile = File(image.path);
        _showImg = true;
      });

      try {
        final imageRef = _storageRef.child("images/$_userId");
        await imageRef.putFile(_imageFile);
        _imageUrl = await imageRef.getDownloadURL();
      } on FirebaseException {
        Fluttertoast.showToast(msg: "Error Uploading Image");
      }
    } else {
      debugPrint("Error occurred while uploading image");
    }
  }

  _handleSubmit() {
    final data = <String, String>{
      "name": _name,
      "user": _userId,
      "email": _email,
      "image": _imageUrl,
    };

    _db.collection("users").doc(_userId).set(data).then((value) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const BottomNavbar()),
        ModalRoute.withName("/home"),
      );
    });
  }

  @override
  void initState() {
    super.initState();
    _checkData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: _hideUI
          ? SizedBox(
              height: 300,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CircularProgressIndicator(
                    color: Colors.teal.shade800,
                  ),
                  const SizedBox(
                    height: 50,
                    width: double.infinity,
                  ),
                  const Text("Welcome to our Application"),
                ],
              ),
            )
          : Stack(
              children: [
                Container(
                  height: 50,
                  color: Colors.teal.shade800,
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.25,
                  decoration: BoxDecoration(
                    color: Colors.teal.shade800,
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                Container(
                  height: 375,
                  width: double.infinity,
                  margin: const EdgeInsets.fromLTRB(20, 75, 20, 0),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.25),
                        spreadRadius: 5,
                        blurRadius: 5,
                      ),
                    ],
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        _showImg
                            ? Container(
                                height: 125,
                                width: 125,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: FileImage(_imageFile),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              )
                            : Container(
                                width: 125,
                                height: 125,
                                decoration: const BoxDecoration(
                                  color: Colors.grey,
                                  shape: BoxShape.circle,
                                ),
                                child: IconButton(
                                  onPressed: _uploadImage,
                                  icon: const Icon(
                                    Icons.upload,
                                    size: 30,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                        const SizedBox(height: 20),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              width: 2,
                              color: Colors.grey,
                            ),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.person),
                              const SizedBox(width: 10),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.5,
                                child: TextField(
                                  onChanged: (text) => _name = text,
                                  decoration: const InputDecoration(
                                    hintText: "Full Name",
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              width: 2,
                              color: Colors.grey,
                            ),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.alternate_email),
                              const SizedBox(width: 10),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.5,
                                child: TextField(
                                  onChanged: (text) => _email = text,
                                  decoration: const InputDecoration(
                                    hintText: "Email",
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 15),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: _handleSubmit,
                            child: const Text("Next"),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
