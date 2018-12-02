import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'login.dart';
import 'userInfo.dart';

void main() async {
  final FirebaseApp app = FirebaseApp.instance;
  /*configure(
    name: 'yeseongee',
    options: FirebaseOptions(
      googleAppID: Platform.isIOS
          ? '1:159623150305:ios:4a213ef3dbd8997b'
          : '1:159623150305:android:ef48439a0cc0263d',
      gcmSenderID: '159623150305',
      apiKey: 'AIzaSyChk3KEG7QYrs4kQPLP1tjJNxBTbfCAdgg',
      projectID: 'flutterFinal',
    ),
  );
  */
  storage = FirebaseStorage(
      app: app, storageBucket: 'gs://airbnb-c9e3e.appspot.com');
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