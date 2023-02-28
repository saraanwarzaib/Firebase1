

import 'dart:async';

import 'package:firebase/auth/firestore/firestore_data_list_screen.dart';
import 'package:firebase/auth/uploaded_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase/auth/login_screen.dart';
import 'package:firebase/posts/post_screen.dart';
import 'package:get/get.dart';

class SplashServices{
  void isLogin(){

     final auth =FirebaseAuth.instance;
     final user=auth.currentUser;

    if(user!=null){
         Get.to(const PostScreen());
     //Get.to(const FireStoreScreen());
    //Get.to(UploadImageScreen());

     }
     else{
      Timer(const Duration(seconds: 001),()=>Get.to(const LoginScreen()));
    }



  }
}