

import 'package:firebase/auth/forgot_password_screen.dart';
import 'package:firebase/auth/login_with_phone_number.dart';
import 'package:firebase/auth/signup_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../posts/post_screen.dart';
import '../utilis/utilis.dart';
import '../widgets/bigtextwidget.dart';
import '../widgets/round_Button.dart';

class LoginScreen extends StatefulWidget {
   const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool  loading=false;
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController =TextEditingController();
  TextEditingController passwordController =TextEditingController();

  FirebaseAuth  auth=FirebaseAuth.instance;

  void login(){


    setState(() {
      loading=true;
    });


    auth.signInWithEmailAndPassword(email:emailController.text.toString(),
        password: passwordController.text.toString()).then((value){
      Utils().toastMessage(value.user!.email.toString());
      Get.to(const PostScreen());

      setState(() {
        loading=false;
      });

    }).onError((error, stackTrace) {
      Utils().toastMessage(error.toString());

      setState(() {
        loading=false;
      });

    });
  }
  @override
  void initState(){
    SchedulerBinding.instance?.addPostFrameCallback((timeStamp) {
      login();
    });

    super.initState();


  }



  @override
  void dispose(){
    emailController.dispose();
    passwordController.dispose();
  }

  Widget build(BuildContext context) {
    final Size size =MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(title: const BigText(color:Colors.white, text: "Login ", size:16),
        centerTitle: true,),
        body:ListView(
          children:[
            Container(height: 30,),
            Column(
              children:[
                Form(
                  key: _formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: emailController,
                        decoration: const InputDecoration(
                          hintText: "Enter your email",
                          helperText: "enter email e.g @gmail.com",
                          prefixIcon: Icon(Icons.email),
                          border: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue,width: 1.5)),

                        ),
                        validator: (value){
                          if(value!.isEmpty){
                            return "enter your email";

                          }
                          return null;
                        },
                      ),
                    ),
                   const  SizedBox(height: 20,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextFormField(
                        keyboardType: TextInputType.visiblePassword,
                        controller: passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          hintText: "Enter your password",
                          prefixIcon: Icon(Icons.password),
                          border: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue,width: 1.5)),

                        ),
                        validator: (value){
                          if(value!.isEmpty){
                            return "enter your password";

                          }
                          return null;
                        },
                      ),
                    )

                  ],
                ),
              ),
                const  SizedBox(height: 40,),
                Button(width:size.width*0.3,height:size.height*0.07,title: "Login",loading:loading,onTap: (){
                  if(_formKey.currentState!.validate()){
                   login();
                  }
                }),

                SizedBox(height: 40,),
                TextButton(onPressed: (){
                  Get.to(const  ForgotPasswordScreen());
                }, child: const BigText(color:Colors.green ,size:16 ,text:"Forgot Password",)),
                SizedBox(height: 40,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal:40),
                  child: Row(
                    children:[ const BigText(color: Colors.green, text: "Don't have an account?", size: 16),
                     TextButton(onPressed: (){
                       Get.to(const SignupScreen());
                     }, child: const BigText(color:Colors.green ,size:16 ,text:"Sign up",))
                    ],
                  ),
                ),
            const  SizedBox(height:30,),

              Button(width: size.width*0.6, height: size.height*0.05, title:"Login with phone NO", onTap: (){
              Get.to(const LoginWithPhoneNumber());
              }),

            ]
            ),
      ]
          ),


    );
  }
}
