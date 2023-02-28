import 'package:firebase/utilis/utilis.dart';
import 'package:firebase/widgets/bigtextwidget.dart';
import 'package:firebase/widgets/round_Button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  bool loading=false;
  final passwordController=TextEditingController();
  final auth=FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BigText(text: "Forgot password",color: Colors.white,size: 12),

      ),
      body: Column(
        children: [
          SizedBox(height: 80,),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal:20),
            child: TextFormField(
              controller: passwordController,
              decoration: InputDecoration(
                hintText: "Enter your email",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          SizedBox(height: 80,),
          Button(height: 50,width: 150,title: "Forgot Password",loading:loading,onTap: (){
            setState(() {
              loading=true;
            });
            auth.sendPasswordResetEmail(email:passwordController.text.toString()).then((value){
              setState(() {
                loading=false;
              });
              Utils().toastMessage("we have send email to your email, please  check your email");
            }).onError((error, stackTrace) {
              setState(() {
                loading=false;
              });
              Utils().toastMessage(error.toString());
            });
          },)




        ],
      ),
    );
  }
}
