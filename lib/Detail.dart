import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import 'DB.dart';
import 'userInfo.dart' as userInfo;

class DetailPage extends StatefulWidget {
  final Record1 record;

  DetailPage({@required this.record});

  @override
  _DetailPageState createState() => new _DetailPageState(record: record);
}

class _DetailPageState extends State<DetailPage>  with TickerProviderStateMixin{
  final Record1 record;
  final tagColor = Colors.redAccent;
  final shadowColor = Colors.red[300];
  List favoriteList = [];

  String favoriteString;

  _DetailPageState({@required this.record});

  @override
  initState(){
    super.initState();
    initFavoriteList();
  }

  Future<void> initFavoriteList() async{
    CollectionReference ref = Firestore.instance.collection('USER');
    QuerySnapshot events = await ref.getDocuments();
    events.documents.forEach((document){
      if(userInfo.user.uid == document.documentID){
        favoriteString = document['favorite'].toString();
        favoriteList = favoriteString.split('/');
      }
    });
    setState(() {});
  }

  void displayDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) => new CupertinoAlertDialog(
        title: new Text("연락처"),
        content: new Text("${record.phoneNumber}"),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: false,
            child: new Text("Close"),
            onPressed: () {Navigator.pop(context);},
          )
        ],
      ),
    );
  }
  void setupFacilityList(){

  }

  _buildProductImagesWidgets() {
    TabController imagesController = TabController(length: 4, vsync: this);
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: DefaultTabController(
            length: 4,
            child: Stack(
              children: <Widget>[
                TabBarView(
                  controller: imagesController,
                  children: <Widget>[
                    Image.network(record.photourl1),
                    Image.network(record.photourl2),
                    Image.network(record.photourl3),
                    Image.network(record.photourl4),
                  ],
                ),
                Container(
                  alignment: FractionalOffset(0.5, 0.95),
                  child: TabPageSelector(
                    controller: imagesController,
                    selectedColor: Colors.grey,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    @override
    Column buildButtonColumn(IconData icon, String label) {
      Color color = Colors.blueGrey;
      return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color,size: 35.0,),
          Container(
            margin: const EdgeInsets.only(top: 8.0),
            child: Text(
              label,
              style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.w400,
                color: color,
              ),
            ),
          ),
        ],
      );
    }

    return new Scaffold(
      body: SafeArea(
        child: new Container(
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Stack(
                alignment: const Alignment(1.0,-1.0),
                children: <Widget>[
                  new InkWell(
                    child:Container(
                      padding:  EdgeInsets.all(0.0),
                      height: MediaQuery.of(context).size.height /3 ,
                      child: _buildProductImagesWidgets(),
                    ),
                    onTap: (){print('abtab');},
                    onDoubleTap: (){
                      print('doubletap');
                    },
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      IconButton(
                          icon: Icon(Icons.arrow_back),
                          onPressed: (){
                            Navigator.pop(context);
                          }
                      ),
                      /*
                      IconButton(
                          icon: Icon(favoriteList.contains(record.houseID.toString())? Icons.favorite : Icons.favorite_border, color: Colors.red),
                          onPressed: (){
                            print('sss');
                            setState(() {
                              if (favoriteList.contains(record.houseID.toString())) {
                                String temp = "0";
                                int idx;
                                idx = favoriteList.indexOf(record.houseID.toString());
                                favoriteList.removeAt(idx);
                                print('remove ${record.houseID} and ' + favoriteList.toString());
                                favoriteList.forEach((t){
                                  if(t == '0') { }
                                  else {temp = temp + '/$t';}
                                });
                                Firestore.instance.document('USER/${userInfo.user.uid}').setData({'favorite':temp});
                                initFavoriteList();
                              } else { // 리스트에 추가
                                Firestore.instance.document('USER/${userInfo.user.uid}').setData({'favorite':favoriteString + '/${record.houseID}'});
                                initFavoriteList();
                              }
                            });
                          }
                      )*/
                      IconButton(
                          icon: Icon(favoriteList.contains(record.houseID.toString())? Icons.favorite : Icons.favorite_border,
                            color: Colors.red,),
                          onPressed: (){
                            print('sss');
                            setState(() {
                              //TODO
                              int length = favoriteList.length;
                              int idx;
                              if(length == 1)
                                idx = 0;
                              else
                                idx = favoriteList.indexOf(record.houseID.toString());
                              //리스트에서 삭제
                              if (favoriteList.contains(record.houseID.toString())) {
                                var ss = "";

                                print('idx $idx');
                                favoriteList.removeAt(idx);
                                print('remove ${record.houseID} and ' + favoriteList.toString() + 'length: ${favoriteList.length}');


                                if(length == 1) {
                                  favoriteList.forEach((t) {
                                    ss = ss + "${t}";
                                    print('ss:${ss}');
                                  });
                                }
                                else{
                                  favoriteList.forEach((t) {
                                    ss = ss + "${t}";
                                    print('ss:${ss}');
                                  });
                                }

                                Firestore.instance.document('USER/${userInfo.user.uid}').setData({'favorite':'$ss'});
                                initFavoriteList();
                              } else { // 리스트에 추가
                                if(length == 0)
                                  Firestore.instance.document('USER/${userInfo.user.uid}').setData({'favorite':'${record.houseID}'});
                                else
                                  Firestore.instance.document('USER/${userInfo.user.uid}').setData({'favorite':favoriteString + '/${record.houseID}'});
                                initFavoriteList();
                              }
                            });
                          }
                      )
                    ],
                  )
                ],
              ),

              Expanded(
                  child: ListView(
                    children: <Widget>[
                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              child:Text(record.roomname, style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.w700),),
                              padding: EdgeInsets.fromLTRB(15.0, 0.0, 0.0, 0.0),
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(15.0, 0.0, 0.0, 0.0),child: Text(record.hashtag, style: TextStyle(color:shadowColor))
                            )
                          ],
                        ),
                      ),

                      ListTile(
                        title: Text('${record.price}/day',style: TextStyle(color: Colors.grey),),
                        subtitle: Text('${record.starttime}~${record.endtime}' +' is available', style: TextStyle(color: Colors.redAccent),),
                        trailing: RaisedButton(
                          onPressed: displayDialog, //TODO 연락받을 번호 추가.
                          color: Colors.redAccent,
                          child: Text('지금예약',style: TextStyle(color: Colors.white),),),
                      ),

                      ExpansionTile(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('이 집에 포함된 다양한 편의시설', style:TextStyle(fontSize: 15.0, fontWeight: FontWeight.w700,color: Colors.black)),
                          ],
                        ),
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children:[
                                  /*
                                  wifi,
                                  tv,
                                  kitchen,
                                  microWave,
                                  airConditioner,
                                  freeParking,
                                  */
                                  record.wifi == true ? buildButtonColumn(Icons.wifi, 'WIFI') : SizedBox(width: 0.0),
                                  record.tv == true ? buildButtonColumn(Icons.tv, 'TV') : SizedBox(width: 0.0),
                                  record.kitchen == true ? buildButtonColumn(Icons.kitchen, '부엌') : SizedBox(width: 0.0),
                                  record.microwave == true ? buildButtonColumn(Icons.picture_in_picture, '전자레인지') : SizedBox(width: 0.0),
                                  record.airconditioner == true ? buildButtonColumn(Icons.ac_unit, '에어컨') : SizedBox(width: 0.0),
                                  record.freeparking == true ? buildButtonColumn(Icons.directions_car, '주차') : SizedBox(width: 0.0),
                                  /*
                                  buildButtonColumn(Icons.people, 'For 1 people'),
                                  buildButtonColumn(Icons.hotel, '1 bed'),
                                  buildButtonColumn(Icons.not_interested, 'No bath room'),
                                  buildButtonColumn(Icons.home, 'Mini 2 room'),
                                  */
                                ],
                              ),
                            ],
                          )
                        ],
                      ),

                      ExpansionTile(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text("방에 대한 더 자세한 정보", style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w700,color: Colors.black)),
                          ],
                        ),
                        children: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Text('주소: ${record.province} ${record.city} ${record.dong} ${record.detailaddress}',
                                  style: TextStyle(fontSize: 13.0,color: Colors.black)),
                              Text('상세설명: ${record.decription}'
                              ,style: TextStyle(fontSize: 13.0, color: Colors.black))
                            ],
                          )
                        ],
                      ),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }


/*
  Future<void> _neverSatisfied() async {
    SizedBox buildButtonColumn(IconData icon, String label) {
      //Color color = Theme.of(context).primaryColor;
      Color color = Colors.blueGrey[700];

      return SizedBox(


        width: 90,

        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Icon(icon, color: color,size: 35.0,),
            Container(
              margin: const EdgeInsets.only(top: 8.0),
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.w400,
                  color: color,
                ),
              ),
            ),
          ],
        ),

      );
    }
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('More Detail'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    buildButtonColumn(Icons.desktop_mac, 'No bath room'),
                    buildButtonColumn(Icons.home, 'Mini 2 room'),
                  ],
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    buildButtonColumn(Icons.not_interested, 'No bath room'),
                    buildButtonColumn(Icons.airline_seat_legroom_reduced, 'Mini 2 room'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    buildButtonColumn(Icons.not_interested, 'No bath room'),
                    buildButtonColumn(Icons.home, 'Mini 2 room'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    buildButtonColumn(Icons.people, 'For 1 people'),
                    buildButtonColumn(Icons.home, 'Mini 2 room'),
                  ],
                )   ,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    buildButtonColumn(Icons.home, 'Mini 2 room'),
                    buildButtonColumn(Icons.hotel, '1 bed'),
                  ],
                )   ,
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  */
}