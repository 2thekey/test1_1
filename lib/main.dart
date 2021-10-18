import 'package:flutter/material.dart';
import 'package:test1_1/result_screen.dart';
import 'package:test1_1/add_screen.dart';
void main() => runApp(MyApp());
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes:{
        '/':(context) => ResultScreen("all"),
        'a':(context) => ResultScreen("purchase"),
        'b':(context) => ResultScreen("price"),
        'c':(context) => AddScreen(),
      },
    );
  }
}