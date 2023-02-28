


import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase/auth/login_screen.dart';
import 'package:firebase/utilis/utilis.dart';
import 'package:firebase/widgets/bigtextwidget.dart';
import 'package:firebase/widgets/round_Button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool loading =false;
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController =TextEditingController();
  TextEditingController passwordController =TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  void signup(){
    setState(() {
      loading=true;
    });

    auth.createUserWithEmailAndPassword(email: emailController.text.toString(),
        password: passwordController.text.toString()).then((value) {

      setState(() {
        loading=false;
      });

    }).onError((error ,stackTrace ){
      Utils().toastMessage(error.toString());

      setState(() {
        loading=false;
      });

    });
  }
  @override
  void initState(){
    SchedulerBinding.instance?.addPostFrameCallback((timeStamp) {
      signup();
    });
    super.initState();

  }

  @override
  void dispose(){
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final Size size =MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const BigText(color:Colors.white, text: "Sign up", size:16),
        centerTitle: true,),
      body:ListView(
        children: [
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
              Button(width:size.width*0.3,height:size.height*0.07,title: "Signup",
                  loading: loading,onTap: (){
                if(_formKey.currentState!.validate()){
                  signup();
                }
              }),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Row(
                  children:[ const BigText(color: Colors.green, text: "Already have an account?", size: 16),
                    TextButton(onPressed: (){
                      Get.to(const LoginScreen());
                    }, child: const BigText(color:Colors.green ,size:16 ,text:"Login",))
                  ],
                ),
              )
            ]
        ),
    ]
      ),
    );
  }
}