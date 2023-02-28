import 'dart:io';

import 'package:firebase/widgets/bigtextwidget.dart';
import 'package:firebase/widgets/round_Button.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../utilis/utilis.dart';

class UploadImageScreen extends StatefulWidget {
  const UploadImageScreen({Key? key}) : super(key: key);

  @override
  State<UploadImageScreen> createState() => _UploadImageScreenState();
}

class _UploadImageScreenState extends State<UploadImageScreen> {
  bool loading = false;
  File? _image;
  final imagePicker = ImagePicker();
  DatabaseReference databaseRef = FirebaseDatabase.instance.ref("post");
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  Future getGellerImage() async {
    final pickedFile = await imagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 100,
    );
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print("object");
      }
    });
  }

  @override
  void initState(){

    super.initState();


  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BigText(
          text: "Uplaod image",
          size: 10,
          color: Colors.white,
        ),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: InkWell(
              onTap: () {
                getGellerImage();
              },
              child: Container(
                width: 200,
                height: 200,
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.green)),
                child: _image != null
                    ? Image.file(_image!.absolute)
                    : Center(child: Icon(Icons.image)),
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Button(
            height: 50,
            width: 300,
            title: "uplaod Image",
            loading: loading,
            onTap: () async {
              setState(() {
                loading = true;
              });
                firebase_storage.Reference ref =
                firebase_storage.FirebaseStorage.instance.ref("/image" +
                    DateTime.now().millisecondsSinceEpoch.toString());
                firebase_storage.UploadTask uploadeTask =
                ref.putFile(_image!.absolute);
                  Future.value(uploadeTask).then((value) async {
                    var newUrl = await ref.getDownloadURL();
                    setState(() {
                      newUrl:newUrl;
                    });
                    databaseRef.child("1").set(
                        {"id": "2222", "title":Container(
                            height:70,
                            width:50,
                            child:Image.network(newUrl.toString()))}).then((value) {
                      setState(() {
                        loading = false;
                        Utils().toastMessage("image uploaded");
                      });
                    }).onError((error, stackTrace) {
                      Utils().toastMessage(error.toString());
                      setState(() {
                        loading = false;
                      });
                    });
                  }).onError((error, stackTrace) {
                    setState(() {
                      loading = false;
                    });
                    Utils().toastMessage(error.toString());

                  });
            },
          )
        ],
      ),
    );
  }
}
