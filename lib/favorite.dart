import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'userInfo.dart';
import 'package:collection/collection.dart';

import 'favoriteItem.dart';
import 'color.dart';
bool editButtonFlag = false;
bool selected = false;
int houseIndex;
var temp;

List favoriteList = [];
List<FavoriteItem> removeItem = [];
List<FavoriteItem> favoriteItems2 = [];



class FavoriteList extends StatefulWidget {
  @override
  FavoriteListState createState() => new FavoriteListState();
}

class FavoriteListState extends State<FavoriteList> {
  Function deepEq = const DeepCollectionEquality().equals;
  bool longPressFlag = false;
  FavoriteItem templist = new FavoriteItem();
  String dbstring = "";

  void initState(){
    super.initState();
    setState(() {
      _getFavorite().then((bool value){
        _loadFavoriteList();
      });
    });
  }


  Future<bool> _getFavorite() async{
    print('getFavorite');
    favoriteList.clear();
    favoriteItems2.clear();

    var value;
    await Firestore.instance.collection('USER').document('${user.uid}').get()
        .then((events){
      print('순서왜이래\n');
      value =  events.data['favorite'].toString();
      print('value: $value');
    });


    favoriteList = value.split('/');
    favoriteList.removeAt(0);
    print('size: ${favoriteList.length}');
    for (var value1 in favoriteList) {
      print('value:$value1');
    }
    return true;

  }

  void addItem(FavoriteItem item) {
    favoriteItems2.add(item);
    print('size of favoriteitem2: ${favoriteItems2.length}');
  }


  Future<void> _loadFavoriteList() async{
    //favoriteItems2.clear();

    for(String a in favoriteList) {
      int index = int.parse(a);
      print('어 왜??');
      Firestore.instance.collection('HOUSE').document('$index').snapshots()
          .listen((data) {
        print('??');
        templist = new FavoriteItem(
          houseID: data['houseID'],
          roomname: data['roomname'],
          dong: data['dong'],
          roomtype: data['roomtype'],
          price: data['price'],
          photoURL1: data['photourl1'],
          photoURL2: data['photourl2'],
          photoURL3: data['photourl3'],
          photoURL4: data['photourl4'],
        );
        addItem(templist);
        setState(() {});
      });
    }

  }


  String editText() {
    if (editButtonFlag == false)
      return '삭제';
    else
      return '취소';
  }

  void removeItem(FavoriteItem item){
    dbstring = "";
    int length = favoriteItems2.length;
    int idx;
    if(length == 1)
      idx = 0;
    else
      idx = favoriteItems2.indexOf(item);
    print('idx:$idx');
    //리스트에서 삭제
    setState(() {
      if(favoriteItems2.contains(item)) {
        print('remove\n');
        favoriteItems2.remove(item);
        favoriteList.removeAt(idx);

        //favoriteList에 아무것도 없을 때
        if(length == 1)
          dbstring = "";
        else {
          favoriteList.forEach((n) {
            print('??');
            print('n ${n.toString()}');
            dbstring = dbstring + "/${n.toString()}";
          });
          print('dbstring $dbstring');
          Firestore.instance.document('USER/${user.uid}').setData(
              {'favorite': '$dbstring'});
        }
      }
    });
  }

  void editButtonPress() {
    setState(() {
      if (editButtonFlag == false) {
        selected = false;
        editButtonFlag = true;
      }
      else{
        selected = false;
        editButtonFlag = false;
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 4.0, vertical: 10.0),
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width /1.5,
                        padding: EdgeInsets.fromLTRB(150.0, 0.0, 0.0, 0.0),
                        child:new Text(
                          "저장 목록",
                          style: new TextStyle(
                              fontSize: 30.0,
                              color: purple5_1,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                          width: MediaQuery.of(context).size.width /7,
                          child:
                          InkWell(
                            onTap: () => editButtonPress(),
                            child: Container(
                                padding: EdgeInsets.all(10.0),
                                child: new Text(editText(),
                                    style: new TextStyle(
                                      fontSize: 20.0,
                                      color: accpurple1,
                                      //fontWeight: FontWeight),)
                                    ))),
                          )
                      ),


                    ],
                  ),
                ),
                Divider(height: 2.0, indent: 2.0),
                Expanded(
                    child: new ListView(
                        children: favoriteItems2
                            .map((item) => new FavoriteItem(
                          houseID: item.houseID,
                          roomname: item.roomname,
                          dong: item.dong,
                          roomtype: item.roomtype,
                          price: item.price,
                          photoURL1: item.photoURL1,
                          photoURL2: item.photoURL2,
                          photoURL3: item.photoURL3,
                          photoURL4: item.photoURL4,
                          callback: () {
                            print('callback\n');
                            removeItem(item);
                          },
                        ))
                            .toList())),
              ])),
    );
  }



}