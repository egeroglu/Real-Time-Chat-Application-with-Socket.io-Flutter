import 'package:flutter/material.dart';
import 'package:w_chat/Screens/LoginScreen.dart';
import 'package:w_chat/Screens/homescreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: "OpenSans",
        primaryColor: Color(0xFF075E54), 
        accentColor: Color.fromARGB(255, 255, 6, 81)
      ),
      home: LoginScreen(),
    );
  }
}
