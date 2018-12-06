import 'package:flutter/material.dart';


import 'favorite.dart';
import 'addHost.dart';
import 'hostingItem.dart';

import 'package:flutter_moapp_project/userInfo.dart' as userInfo;

import 'Detail.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'DB.dart';
import 'color.dart';
import 'userInfo.dart';


class HostingPage extends StatefulWidget {
  @override
  HostingPageState createState() => new HostingPageState();
}

List<HostingItem> hostingItems = [
  new HostingItem(
    name: "고양이가 있는 해맞이 공원 원룸",
    location: "환호동",
    type: "단기",
    cost: "30000원 /박",
    url:
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRXtSFkG4W7-fKfR2Ti2DtLz4jzDr6Prjwyl7y91lKJgXwa_bnTgQ",
  ),
];

class HostingPageState extends State<HostingPage> {





  Widget _buildGrid(BuildContext context) {


    return
      StreamBuilder<QuerySnapshot>(
        stream:Firestore.instance.collection('HOUSE').
        where('uid' ,isEqualTo: userInfo.user.uid ).snapshots(),
        builder: (context, snapshot){
          if(!snapshot.hasData) return LinearProgressIndicator();
          return _buildGridList(context, snapshot.data.documents);
        },
      );



  }

  Widget _buildGridList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return
      ListView(
        children: snapshot.map((data) => _buildGridListItem(context, data))
            .toList(),
      );

  }

  Widget _buildGridListItem(BuildContext context, DocumentSnapshot data) {



    final record = Record1.fromSnapshot(data);

    Widget _Image() {
      return Hero(
        tag: record.houseID,
        child: Container(
            width: 470.0,
            height: 200.0,
            child: Image.network(
              //"https://media.mnn.com/assets/images/2016/03/AIrbnb-Tokyo.jpg.653x0_q80_crop-smart.jpg",
              record.photourl1,
              fit: BoxFit.fill,
            )),
      );
    }
    return  new GestureDetector(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => DetailPage(record: record,)));
        },
        child :  Card(
          child:  Container(
            padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 30.0),
            decoration:
            editButtonFlag ?
            new BoxDecoration(color: Colors.grey[300])
                : new BoxDecoration(),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _Image(),
                  SizedBox(height: 15.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          /*       new Text(
                          widget.type,
                          style: new TextStyle(
                              fontSize: 15.0,
                              color: themecolor,
                              fontWeight: FontWeight.w600),
                        ),
                        */
                          //  SizedBox(width: 0.0),
                          new Text(record.dong,
                              style: new TextStyle(
                                  fontSize: 15.0,
                                  color: accpurple1,
                                  fontWeight: FontWeight.w600))

                        ],
                      ),
                      SizedBox(height: 2.0),

                      new Text(
                        record.roomname,
                        style: new TextStyle(
                            fontSize: 25.0,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),

                      SizedBox(height: 5.0),
                      new Text(
                        record.price.toString(),
                        style: new TextStyle(fontSize: 20.0, color: Colors.black),
                      ),
                    ],
                  ),


                ]),
          ),
        )
    );

  }






  void editButtonPress() {
    setState(() {
      if (editButtonFlag == false) {
        selected =false;
        editButtonFlag = true;
      } else {
        selected =false;
        editButtonFlag = false;
      }
    });
  }

  String editText() {
    if (editButtonFlag == false)
      return '편집';
    else
      return '취소';
  }

  void removeItem(HostingItem item){
    setState(() {
      if(hostingItems.contains(item)) {
        print('remove\n');
        hostingItems.remove(item);
      }
    });
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body:
      //_buildGrid(context)
      SafeArea(
          child: ListView(
            children: <Widget>[
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 4.0, vertical: 10.0),
                      child: new Row(
                        children: <Widget>[
                          IconButton(
                              icon: Icon(Icons.arrow_back,
                                  size: 32.0, color: Colors.grey),
                              onPressed: () {
                                Navigator.pop(context);
                                editButtonFlag = false;
                              }
                          ),
                          new Expanded(
                            child: new Padding(
                              padding: const EdgeInsets.only(left: 90.0),
                              child: new Text(
                                "호스팅 목록",
                                style: new TextStyle(
                                    fontSize: 30.0,
                                    color: purple5_1,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),

                        ],
                      ),
                    ),
                    Divider(height: 2.0, indent: 2.0),

                  ]),
              new Container(
                height: 700.0,
                child:_buildGrid(context),
              ),
            ],
          )

      ),











/*

        return new SafeArea(
    child: new Scaffold(
    //key: _scaffoldKey,
    body:
    // _buildGrid(context),
    new ListView(

    padding: EdgeInsets.all(10.0),
    children: <Widget>[
    Padding(
    padding:
    const EdgeInsets.symmetric(horizontal: 4.0, vertical: 10.0),
      child: new Row(
          children: <Widget>[
            IconButton(
                icon: Icon(Icons.arrow_back,
                    size: 32.0, color: Colors.grey),
                onPressed: () {
                  Navigator.pop(context);
                  editButtonFlag = false;
                }
            ),
            new Expanded(
              child: new Padding(
                padding: const EdgeInsets.only(left: 90.0),
                child: new Text(
                  "호스팅 목록",
                  style: new TextStyle(
                      fontSize: 30.0,
                      color: Colors.black54,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),

    /*
    Container(
    child:

    ),
    */
    new SizedBox(height: 20.0),
    new SizedBox(height: 10.0),

    new Container(
    height: 700.0,
    child:_buildGrid(context),
    ),

    //   _buildGrid(context),
    //  Expanded(child: _buildGrid(context),),
    ]
    ),

    )
    ]
    )

    ),










*/











      floatingActionButton: new FloatingActionButton(
          child: new Icon(Icons.add),
          onPressed: () =>  Navigator
              .of(context)
              .push(MaterialPageRoute(
              builder: (BuildContext context) => addHosting())),
          backgroundColor: purple4,
        ),


    );

  }
}