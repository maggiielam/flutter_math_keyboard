import 'package:flutter/material.dart';

class MyKey extends StatelessWidget {
  final color;
  final textColor;
  final keyValue;
  final keyFace;
  final pressed;

  MyKey ({this.color, this.textColor, this.keyValue, this.keyFace, this.pressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: pressed,
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),) ),),
      child: Center(child: Text(keyFace, style: TextStyle(fontSize: 25, color: textColor))));
  }
}