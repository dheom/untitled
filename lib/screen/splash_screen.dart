import 'package:flutter/material.dart';
import 'package:untitled/widget/appbars.dart';
import 'package:untitled/widget/buttons.dart';
import 'package:untitled/widget/texts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 3), () {
      Navigator.popAndPushNamed(context, '/login'); //현재화면을 죽이고 넘어가겠다
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(title: '안녕', isLeading: true),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/app_logo.png', width: 120, height: 120),
            const SizedBox(height: 46),
            Text(
              'Food Pick',
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
