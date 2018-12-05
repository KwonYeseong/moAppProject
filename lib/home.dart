import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'grey.dart';
import 'mypage.dart';
import 'favorite.dart';
import 'color.dart';
class HomePage extends StatefulWidget {
  HomePage():super();

  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  TabController controller;
  int _currentIndex = 0;

  final List<Widget> _children = [
    new Grey(),
    new FavoriteList(),
    new Mypage(),
  ];

  @override
  Widget build(BuildContext context) {
    if(controller == null) {
      controller=new TabController(length: 4, vsync: this);
    }
    return new Scaffold(
        body: _children[_currentIndex],
        bottomNavigationBar : new Theme(
          data: Theme.of(context).copyWith(
              canvasColor: pur1
          ),
          child : BottomNavigationBar(
            fixedColor: Colors.white,

            onTap: onTabTapped, // new
            currentIndex: _currentIndex, // new
            items: [
              new BottomNavigationBarItem(

                icon: new Icon(Icons.search),
                backgroundColor: Colors.black,
                title: Text('Search'),

              ),
              new BottomNavigationBarItem(
                icon: new Icon(Icons.favorite, size: 25.0,),
                title: Text('Favorite' ),
              ),
              new BottomNavigationBarItem(
                icon: new Icon(Icons.perm_identity),
                title: Text('My Page'),
              ),
            ],
          ),
        )
    );
  }
  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}