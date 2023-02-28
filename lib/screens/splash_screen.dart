

import 'package:firebase/firebase_services/splash_services.dart';
import 'package:firebase/widgets/bigtextwidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  SplashServices SplashScreen = SplashServices();


  @override
  void initState(){
   super.initState();
   SchedulerBinding.instance.addPostFrameCallback((_) {
     SplashScreen.isLogin();
   });
  }
  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      body:  Center(
        child:  BigText(color: Colors.green, text: "Firebase Totorial ", size:22),
      ),
    );
  }
}
