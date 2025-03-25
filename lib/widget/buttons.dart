import 'dart:ui';

import 'package:flutter/material.dart';

class ElevatedButtonCustom extends StatelessWidget {
  String text;
  Color backgroundColor;
  Color textColor;
  Function onPresesd;

  ElevatedButtonCustom({
    super.key,
    required this.text,
    required this.backgroundColor,
    required this.textColor,
    required this.onPresesd,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => onPresesd.call(),
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        minimumSize: Size(double.infinity, 50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      ),
    );
  }
}
