import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'grey.dart';
import 'mypage.dart';
import 'favorite.dart';
class HomePage extends StatefulWidget {
  HomePage():super();

  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  TabController controller;




  ////
  int _currentIndex = 0;
  final List<Widget> _children = [

    new Grey(),
    new FavoriteList(),
    new Mypage(),
  ];
  ////

  @override
  Widget build(BuildContext context) {




    if(controller == null) {
      controller=new TabController(length: 4, vsync: this);
    }
    return new Scaffold(

      /*
        bottomNavigationBar: new Material (
          child: new TabBar(
            labelColor: Colors.redAccent, // Icon color
            indicatorColor: Colors.black, // 어디있는지 알려주는거

            tabs: <Tab> [
              new Tab(icon: new Icon(Icons.search)),
              //new Tab(icon: new Icon(Icons.add)),
              //new Tab(icon: new Icon(Icons.star_border)),
              //new Tab(icon: new Icon(Icons.chat_bubble_outline)),
              new Tab(icon: new Icon(Icons.perm_identity))
            ],
            controller: controller,
          ),
          color: Colors.transparent,
        ),


        body: new TabBarView(
          children: <Widget> [
            new Grey(),
            //new Hosting(),
            new Mypage(),
          ],
          controller: controller,
        )
      */

      body: _children[_currentIndex], // new
      bottomNavigationBar: BottomNavigationBar(


        fixedColor: Colors.red,


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

          //  new BottomNavigationBarItem(
          //      icon: Icon(Icons.person),
          //      title: Text('Profile')
          //  )
        ],
      ),





    );
  }


  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}