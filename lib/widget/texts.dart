import 'package:flutter/material.dart';

class SectionText extends StatelessWidget {
  String text;
  Color textColor;
  SectionText({super.key, required this.text, required this.textColor});
//
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: textColor,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
