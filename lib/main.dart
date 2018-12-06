import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'login.dart';
import 'userInfo.dart';

void main() async {
  final FirebaseApp app = FirebaseApp.instance;

  storage = FirebaseStorage(
      app: app, storageBucket: 'gs://airbnb-c9e3e.appspot.com');
  runApp(new MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(),
    ) ;
  }
}