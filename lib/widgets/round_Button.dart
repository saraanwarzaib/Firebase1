


import 'package:firebase/widgets/bigtextwidget.dart';
import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final double width ,height;
  final   String title;
  final  VoidCallback onTap;
  bool loading;


   Button({Key? key,required this.width,required this.height,
    required this.title,required this.onTap,this.loading=false }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
       width:width,
        height: height,
        alignment: Alignment.center,

        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
          color: Colors.purple,
        ),
        child:loading?CircularProgressIndicator(strokeWidth: 3,color: Colors.white,):  BigText(
            text:title, color: Color(0XFFffffff), size: 16),
      ),
      onTap: onTap,
    );
  }
}
