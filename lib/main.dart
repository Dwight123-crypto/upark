import 'package:flutter/material.dart';
import 'package:upark/screens/welcome_screen.dart';
import 'package:upark/screens/map_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => WelcomeScreen(),
        '/map': (context) => MapScreen(),
      },
    );
  }
}