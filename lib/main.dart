import 'package:flutter/material.dart';
import 'package:my_vocab/Physical/Screens/HomeScreen.dart';
import 'package:my_vocab/Physical/Screens/Sign-In-Screen.dart';
import 'package:my_vocab/Physical/Screens/Sign-Up-Screen.dart';
import 'package:my_vocab/Physical/Screens/Welcome-Screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light().copyWith(
        primaryColor:Color(0xffff4f18),
      ),
      initialRoute: WelcomeScreen.id,
      routes: {
        SignInScreen.id: (context)=>SignInScreen(),
        WelcomeScreen.id: (context)=> WelcomeScreen(),
        SignUpScreen.id: (context)=> SignUpScreen(),
        HomePage.id: (context)=> HomePage(),
      },
    );
  }
}
