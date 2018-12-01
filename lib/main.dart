import 'package:flutter/material.dart';

import 'login.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(),
      theme: ThemeData(
        primaryColor: Colors.redAccent,
      ),
    ) ;
  }
}