import 'package:flutter/material.dart';
class Smalltext extends StatelessWidget {
  final String text;
  final  Color color;
  final double size;

  const Smalltext( {Key? key, required this.text, required this.color, required this.size,
    }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.transparent,
        child: Text(text,style: TextStyle(color: color,fontSize: size),));
  }
}
