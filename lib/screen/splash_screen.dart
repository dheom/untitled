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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(title: '안녕', isLeading: true),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SectionText(text: '이메일', textColor: Colors.grey),
            ElevatedButtonCustom(
              text: '테스트버튼',
              backgroundColor: Colors.black,
              textColor: Colors.white,
              onPresesd: () {
                print('안녕하세요');
              },
            ),
          ],
        ),
      ),
    );
  }
}
