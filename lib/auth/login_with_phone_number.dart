import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase/auth/verify_code.dart';
import 'package:firebase/utilis/utilis.dart';
import 'package:firebase/widgets/bigtextwidget.dart';
import 'package:firebase/widgets/round_Button.dart';
import 'package:flutter/foundation.dart';

import "package:flutter/material.dart";
import 'package:get/get.dart';

class LoginWithPhoneNumber extends StatefulWidget {
  const LoginWithPhoneNumber({Key? key}) : super(key: key);

  @override
  State<LoginWithPhoneNumber> createState() => _LoginWithPhoneNumberState();
}

class _LoginWithPhoneNumberState extends State<LoginWithPhoneNumber> {
  TextEditingController   phoneController=TextEditingController();
  bool loading=false;
  final auth= FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final Size size=MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title:const  BigText(color: Colors.white, text: "Login", size: 16)),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 30,),
            TextFormField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(

                hintText:'Enter phone number',
                //prefixText:'+92 ',
                border: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue,width: 1.5)),

              ),
            ),
            const SizedBox(height: 30,),
            Button(width:size.width*0.6 , height:size.height*0.1, title: "Login",loading: loading,
                onTap: (){
              setState(() {
                loading=true;
              });
                auth.verifyPhoneNumber(
                  phoneNumber: phoneController.text,
                    verificationCompleted:(_){
                    loading=false;
                    },
                    verificationFailed: (e){
                    Utils().toastMessage(e.toString());
                    if (kDebugMode) {
                      print('hello error = $e');
                    }
                    setState(() {
                      loading=false;
                    });
                    },
                    codeSent: (String verificationId ,int? token){
                    if (kDebugMode) {
                      print('verificationId$verificationId');
                    }
                    Get.to( VerifyCodeScreen(verificationId:verificationId,));
                    setState(() {
                      loading=false;
                    });
                    },
                    codeAutoRetrievalTimeout: (e){Utils().toastMessage(e.toString());
                    setState(() {
                      loading=false;
                    });
                  });
                }
            )

          ],
        ),
      ),
    );
  }
}


