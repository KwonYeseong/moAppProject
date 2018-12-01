import "dart:async";

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'userInfo.dart' as userInfo;
import "ListItem.dart";
import "favorite.dart";
import "hosting.dart";
import 'login.dart';

class Mypage extends StatefulWidget {
  @override
  MypageState createState() => new MypageState();
}

class MypageState extends State<Mypage> {
  double _imageHeight = 400.0;


  Future<LoginPage>  _signOut()  async{
    await auth.signOut();
    return new LoginPage();
  }


  @override
  void initState() {
    super.initState();
  }

  List<ListItem> items = [
    new ListItem(title: "Logout", icon: Icons.input),
    new ListItem(title: "저장 목록", icon: Icons.favorite_border),
    new ListItem(title: "호스팅 페이지", icon: Icons.home),
  ];

  Widget _buildIamge() {
    return Container(
        width: 600.0,
        child: Image.network(
          'https://i.pinimg.com/564x/8d/41/e4/8d41e442e18dbc5e837a735aca8ca5c0.jpg',
          fit: BoxFit.fitWidth,
          colorBlendMode: BlendMode.srcOver,
          color: new Color.fromARGB(120, 20, 10, 40),
        ));
  }

  Widget _buildProfileRow() {
    return new Padding(
      padding:
      new EdgeInsets.only(left: 20.0, right: 10.0, top: _imageHeight / 4),
      child: new Row(
        children: <Widget>[
          new CircleAvatar(
            minRadius: 50.0,
            maxRadius: 50.0,
            backgroundImage: new NetworkImage(userInfo.user.photoUrl),
          ),
          new Padding(
            padding: const EdgeInsets.only(left: 30.0),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                new Text(
                  userInfo.user.email,
                  style: new TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 8.0),
                new Text(
                  userInfo.user.email,
                  style: new TextStyle(
                      fontSize: 16.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildBottomPart() {
    return new Padding(
        padding: new EdgeInsets.only(top: _imageHeight - 140),
        child: Container(
          decoration: new BoxDecoration(
              color: Colors.white,
              borderRadius: new BorderRadius.only(
                  topLeft:  const  Radius.circular(40.0),
                  topRight: const  Radius.circular(40.0))
          ),
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 25.0),
              _buildMyTasksHeader(),
              SizedBox(height: 15.0),
              _buildTasksList(),
            ],
          ),
        )
    );
  }

//TODO
  Widget _buildTasksList() {
    return new Expanded(
        child: Container(
            padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
            child:
            ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                if(index == 0){
                  return Padding(
                      padding: const EdgeInsets.fromLTRB(10.0, 10.0, 20.0, 10.0),
                      child: Column(children: <Widget>[
                        ListTile(
                            title: Text(
                              item.title,
                              style: Theme.of(context).textTheme.headline,
                            ),
                            trailing: Icon(item.icon),
                            onTap:
                                () =>
                                _signOut().then((LoginPage loginPage) {
                                  Navigator
                                      .of(context)
                                      .push(MaterialPageRoute(
                                      builder: (BuildContext context) => LoginPage()
                                  ));
                                })

                        ),
                        SizedBox(height: 10.0),
                        Divider(height:5.0)
                      ]));
                }
                else if(index == 1){
                  return Padding(
                      padding: const EdgeInsets.fromLTRB(10.0, 10.0, 20.0, 10.0),
                      child: Column(children: <Widget>[
                        ListTile(
                            title: Text(
                              item.title,
                              style: Theme.of(context).textTheme.headline,
                            ),
                            trailing: Icon(item.icon),
                            onTap: () =>
                                Navigator
                                    .of(context)
                                    .push(MaterialPageRoute(
                                    builder: (BuildContext context) => FavoriteList()
                                ))


                        ),
                        SizedBox(height: 10.0),
                        Divider(height:5.0)
                      ]));
                }
                else if(index == 2){
                  return Padding(
                      padding: const EdgeInsets.fromLTRB(10.0, 10.0, 20.0, 10.0),
                      child: Column(children: <Widget>[
                        ListTile(
                            title: Text(
                              item.title,
                              style: Theme.of(context).textTheme.headline,
                            ),
                            trailing: Icon(item.icon),
                            onTap: () =>  Navigator
                                .of(context)
                                .push(MaterialPageRoute(
                                builder: (BuildContext context) => HostingPage()
                            ))

                        ),
                        SizedBox(height: 10.0),
                        Divider(height:5.0)
                      ]));
                }
              },
            )));
  }

  Widget _buildMyTasksHeader() {
    return new Padding(
      padding: new EdgeInsets.only(left: 30.0),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Text(
            '${userInfo.user.displayName} Page',
            style: new TextStyle(fontSize: 25.0, fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 7.0),
          new Text(
            'Welcome To My Page',
            style: new TextStyle(color: Colors.grey, fontSize: 15.0),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: Text("DeepPurple")),
        body: SafeArea(
            child: Row(children: <Widget>[
              Expanded(
                child: Stack(
                  children: <Widget>[
                    _buildIamge(),
                    _buildProfileRow(),
                    _buildBottomPart(),
                  ],
                ),
              )
              //_buildFab()
            ])));
  }
}