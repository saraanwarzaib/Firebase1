
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase/posts/post_screen.dart';
import 'package:firebase/widgets/bigtextwidget.dart';
import "package:flutter/material.dart";
import 'package:get/get.dart';

import '../utilis/utilis.dart';
import '../widgets/round_Button.dart';

class VerifyCodeScreen extends StatefulWidget {
 final  String verificationId;
  const VerifyCodeScreen({Key? key,required this.verificationId}) : super(key: key);

  @override
  State<VerifyCodeScreen> createState() => _VerifyCodeScreenState();
}


class _VerifyCodeScreenState extends State<VerifyCodeScreen> {

  TextEditingController verifyCodeController = TextEditingController();
  bool loading = false;
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery
        .of(context)
        .size;
    return Scaffold(
      appBar: AppBar(
          title: const BigText(color: Colors.white, text: "Verify", size: 16)),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 30,),
            TextFormField(
              controller: verifyCodeController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                  hintText: '6 digit code'

              ),
            ),
            const SizedBox(height: 30,),
            Button(width: size.width * 0.6,
                height: size.height * 0.06,
                title: "Verify",
                loading: loading,
                onTap: () async{
                setState(() {
                  loading=true;

                });
                  final credential =PhoneAuthProvider.credential(verificationId:widget.verificationId, smsCode: verifyCodeController.text.toString());
                  try{
                     await auth.signInWithCredential(credential);
                     Get.to(const PostScreen());
                     setState(() {
                       loading=false;

                     });
                  }catch(e){

                   Utils().toastMessage(e.toString());
                   setState(() {
                     loading=false;
                   });
                  }
                }
            )

          ],
        ),
      ),
    );
  }
}