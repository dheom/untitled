import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String text, [int duration = 2]) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(text), duration: Duration(seconds: duration)),
  );
}
