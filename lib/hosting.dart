import 'package:flutter/material.dart';

import 'favorite.dart';
import 'addHost.dart';
import 'userInfo.dart' as userInfo;
import 'Detail.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'DB.dart';
import 'color.dart';

class HostingPage extends StatefulWidget {
  @override
  HostingPageState createState() => new HostingPageState();
}

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
    return ListView(
        children: snapshot.map((data) => _buildGridListItem(context, data)).toList(),
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
              record.photourl1,
              fit: BoxFit.fill,
            )
        ),
      );
    }

    return  new GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPage(record: record)));
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
                          new Text(record.dong, style: new TextStyle(fontSize: 15.0, color: accpurple1, fontWeight: FontWeight.w600))
                        ],
                      ),

                      SizedBox(height: 2.0),

                      new Text(record.roomname, style: new TextStyle(fontSize: 25.0, color: Colors.black, fontWeight: FontWeight.bold)),

                      SizedBox(height: 5.0),

                      new Text(record.price.toString(), style: new TextStyle(fontSize: 20.0, color: Colors.black)),
                    ],
                  ),
                ]
            ),
          ),
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
                              icon: Icon(Icons.arrow_back, size: 32.0, color: Colors.grey),
                              onPressed: () {
                                Navigator.pop(context);
                                editButtonFlag = false;
                              }
                          ),
                          new Expanded(
                            child: new Padding(
                              padding: const EdgeInsets.only(left: 90.0),
                              child: new Text("호스팅 목록", style: new TextStyle(fontSize: 30.0, color: purple5_1, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    Divider(height: 2.0, indent: 2.0),
                  ]
              ),
              new Container(
                height: 700.0,
                child:_buildGrid(context),
              ),
            ],
          )
      ),

      floatingActionButton: new FloatingActionButton(
        child: new Icon(Icons.add),
        onPressed: () =>  Navigator.of(context)
            .push(MaterialPageRoute(
            builder: (BuildContext context) => addHosting())),
        backgroundColor: purple4,
      ),
    );
  }
}