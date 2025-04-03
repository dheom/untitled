import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: TextButton(onPressed:()
    {
      Navigator.pushNamed(context, '/register');
    },child: Text('회원가입 이동')
    ,
    )
    ,
    )
    );
  }
}
