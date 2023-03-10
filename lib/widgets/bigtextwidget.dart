import 'package:flutter/material.dart';
class BigText extends StatelessWidget {
  final Color color;
  final String text;
  final double size;

  const BigText( {Key? key,required this.color,required this.text,required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text,style: TextStyle(color:color,fontSize: size,fontWeight:FontWeight.bold , ),);
  }
}
