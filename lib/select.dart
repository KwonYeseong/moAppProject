import 'package:flutter/material.dart';
import 'package:flutter_moapp_project/select_page/intro_page_view.dart';

class Select extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: IntroPageView(),
    );
  }
}