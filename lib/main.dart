import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:untitled/screen/login_screen.dart';
import 'package:untitled/screen/register_screen.dart';
import 'package:untitled/screen/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); //main method에서 비동기로 데이터 다룰 때 최초에 호출해줘야함
  //init supabase
  await Supabase.initialize(
    url: 'https://shxaydpsutadkjpvwxfo.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InNoeGF5ZHBzdXRhZGtqcHZ3eGZvIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDIzMDM0ODUsImV4cCI6MjA1Nzg3OTQ4NX0.fo4u1z4OpAsX4gFuTuWNGhIDpoHTCX6i9OIxGeP-S3Q',
  );//await 은 비동기형태로 진행할수있도록 하는거임


  runApp(const MyApp());
}
//common은 로직적인 부분 모아두는것..?
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/login': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen(),
      },
    );
  }
}
