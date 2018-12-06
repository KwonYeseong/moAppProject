import 'package:flutter/material.dart';

import 'userInfo.dart' as userInfo;
import 'Detail.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'DB.dart';
import 'color.dart';

class Grey extends StatefulWidget {
  @override
  _GreyState createState() => new  _GreyState();
}

class _GreyState extends State<Grey> {
  int home_price = 0;
  int slider_price = 0;
  int totalhouse =  0;
  int _adult_peo = 0;
  int _child_peo = 0;

  bool _enabled = false;
  bool isExpanded = false;

  String message;
  String usr = "${userInfo.user.displayName}";
  String home_location = '';
  String _value = null;
  String _datevalue1 = '';
  String _datevalue2 = '';

  final color = Colors.grey;

  Key collapsedKey = PageStorageKey<String>('collapsed');
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  final myController = TextEditingController();

  List<String> _values = new List<String>();


  Future _selectDate() async {
    DateTime picked = await showDatePicker(
      context: context,
      initialDate: new DateTime.now(),
      firstDate: new DateTime(2016),
      lastDate: new DateTime(2019),
    );
    if(picked != null) setState(() => _datevalue1 = picked.toString());
  }

  Future _selectDate1() async {
    DateTime picked = await showDatePicker(
      context: context,
      initialDate: new DateTime.now(),
      firstDate: new DateTime(2016),
      lastDate: new DateTime(2019),
    );
    if(picked != null) setState(() => _datevalue2 = picked.toString());
  }

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  void add_adult() {
    setState(() {_adult_peo ++;});
  }
  void add_child() {
    setState(() {_child_peo ++;});
  }

  void minus_adult() {
    setState(() {
      if (_adult_peo  != 0)
        _adult_peo --;
    });
  }
  void minus_child() {
    setState(() {
      if (_child_peo  != 0)
        _child_peo --;
    });
  }


  Widget _buildGrid(BuildContext context) {
    if(userInfo.renttype == 3  && home_price ==0 && home_location.length == 0 ){
      return
        StreamBuilder<QuerySnapshot>(
          stream:Firestore.instance.collection('HOUSE').snapshots(),
          builder: (context, snapshot){
            if(!snapshot.hasData) return LinearProgressIndicator();
            return _buildGridList(context, snapshot.data.documents);
          },
        );
    }

    else if(userInfo.renttype == 3 && home_price ==0 && home_location.length != 0 ){
      return
        StreamBuilder<QuerySnapshot>(
          stream:Firestore.instance.collection('HOUSE')
              .where('dong', isEqualTo: home_location)
              .snapshots(),
          builder: (context, snapshot){
            if(!snapshot.hasData) return LinearProgressIndicator();
            return _buildGridList(context, snapshot.data.documents);
          },
        );
    }
    else if(userInfo.renttype == 3 && home_price !=0 && home_location.length == 0 ){
      return
        StreamBuilder<QuerySnapshot>(
          stream:Firestore.instance.collection('HOUSE')
              .where('price', isLessThan: home_price)
              .snapshots(),
          builder: (context, snapshot){
            if(!snapshot.hasData) return LinearProgressIndicator();
            return _buildGridList(context, snapshot.data.documents);
          },
        );
    }
    else if(userInfo.renttype == 3 && home_price !=0 && home_location.length != 0 ){
      return
        StreamBuilder<QuerySnapshot>(
          stream:Firestore.instance.collection('HOUSE')
              .where('dong', isEqualTo: home_location)
              .where('price', isLessThanOrEqualTo: home_price)
              .snapshots(),
          builder: (context, snapshot){
            if(!snapshot.hasData) return LinearProgressIndicator();
            return _buildGridList(context, snapshot.data.documents);
          },
        );
    }
    else if(userInfo.renttype != 3&&home_price == 0 && home_location.length == 0 ){
      return
        StreamBuilder<QuerySnapshot>(
          stream:Firestore.instance.collection('HOUSE').where('renttype', isEqualTo: userInfo.renttype).snapshots(),
          builder: (context, snapshot){
            if(!snapshot.hasData) return LinearProgressIndicator();
            return _buildGridList(context, snapshot.data.documents);
          },
        );
    }
    else if(userInfo.renttype != 3 && home_price != 0 && home_location.length == 0){
      return
        StreamBuilder<QuerySnapshot>(
          stream:Firestore.instance.collection('HOUSE')
              .where('price', isLessThanOrEqualTo: home_price)
              .where('renttype', isEqualTo: userInfo.renttype).snapshots(),
          builder: (context, snapshot){
            if(!snapshot.hasData) return LinearProgressIndicator();
            return _buildGridList(context, snapshot.data.documents);
          },
        );
    }
    else if(userInfo.renttype != 3 &&home_price == 0 && home_location.length != 0){
      return
        StreamBuilder<QuerySnapshot>(
          stream:Firestore.instance.collection('HOUSE')
              .where('dong', isEqualTo: home_location)
              .where('renttype', isEqualTo: userInfo.renttype).snapshots(),
          builder: (context, snapshot){
            if(!snapshot.hasData) return LinearProgressIndicator();
            return _buildGridList(context, snapshot.data.documents);
          },
        );
    }
    else if(userInfo.renttype != 3 &&home_price != 0 && home_location.length != 0){
      return
        StreamBuilder<QuerySnapshot>(
          stream:Firestore.instance.collection('HOUSE')
              .where('dong', isEqualTo: home_location)
              .where('price', isLessThanOrEqualTo: home_price)
              .where('renttype', isEqualTo: userInfo.renttype).snapshots(),
          builder: (context, snapshot){
            if(!snapshot.hasData) return LinearProgressIndicator();
            return _buildGridList(context, snapshot.data.documents);
          },
        );
    }
  }

  Widget _buildGridList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
      children: snapshot.map((data) => _buildGridListItem(context, data)).toList(),
    );
  }

  Widget _buildGridListItem(BuildContext context, DocumentSnapshot data) {
    final record = Record1.fromSnapshot(data);
    return  new GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPage(record: record)));
      },
      child : Card(
        child: Container(
          height: 150.0,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Hero(
                tag:record.houseID,
                child: Container(
                  height: 160.0,
                  width: 160.0,
                  child: Image.network(record.photourl1, fit: BoxFit.fill),
                ),
              ),

              Container(
                width: 220.0,
                padding: EdgeInsets.fromLTRB(16.0, 16.0, 12.0, 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(record.hashtag, style: TextStyle(fontSize: 14.0, color: accpurple1)),
                    Text(record.roomname, style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold)),
                    Text(record.starttime + " is available", style: TextStyle(fontSize: 13.5, color: color[500])),
                    Text(record.price.toString() + "원/박", style: TextStyle(fontSize: 13.5, color: color[500])),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  @override
  void initState(){
    _values.addAll(["Short","Long","Transfer","Total"]);
    _value = _values.elementAt(userInfo.renttype);
  }

  void _onChaged(String value){
    setState(() {
      _value = value;

      if(value == "Short"){
        userInfo.renttype = 0;
      }else if(value == "Long"){
        userInfo.renttype = 1;
      }else if(value == "Transfer"){
        userInfo.renttype = 2;
      }else if(value == "Total") {
        userInfo.renttype = 3;

      }
    });
  }

  Widget build(BuildContext context) {
    return new SafeArea(
        child: new Scaffold(
          key: _scaffoldKey,
          body: new ListView(
              padding: EdgeInsets.all(10.0),
              children: <Widget>[
                Container(
                  child: ExpansionTile(
                    title: Row(
                      children: <Widget>[
                        DropdownButton(
                            value: _value,
                            items: _values.map((String value){
                              return DropdownMenuItem(
                                value: value,
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      child:   Icon(Icons.home,color: purple5),
                                      width: MediaQuery.of(context).size.width/17,
                                    ),
                                    Text('${value}'),
                                  ],
                                ),
                              );
                            }).toList(),
                            onChanged: (String value){
                              _onChaged(value);
                            }
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                          child: Text("집에 가서 자는 건 어떠세요?", style: TextStyle(color: color[600]),),
                        ),
                      ],
                    ),
                    trailing: Icon(Icons.search) ,
                    children: <Widget>[
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween ,
                          children: <Widget>[
                            Container(
                              width: MediaQuery.of(context).size.width/4.5,
                              child:  Column(
                                children: <Widget>[
                                  Icon(Icons.location_on),
                                ],
                              ) ,
                            ),

                            Container(
                              padding: EdgeInsets.fromLTRB(10.0, 20, 10.0, 15.0),
                              width:MediaQuery.of(context).size.width/1.4,
                              child: TextField(
                                controller: myController,
                                decoration: new InputDecoration.collapsed(hintText: '지역을 찾아보세요'),
                                onChanged: (String text) {
                                  setState(() {
                                    home_location = text;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),

                      Divider(color: accpurple, height: 15.0,),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Container(
                              padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
                              width: MediaQuery.of(context).size.width/4.5,
                              child:  Column(
                                children: <Widget>[
                                  Icon(Icons.attach_money),
                                  Text('1박 가격')
                                ],
                              )
                          ),

                          Container(
                            width: MediaQuery.of(context).size.width/1.8,
                            child: Slider(
                                activeColor: accpurple1,
                                inactiveColor: color,
                                value: slider_price.toDouble(),
                                max: 150000, min: 0.0, divisions: 150,
                                onChanged: (double value) {
                                  setState(() {
                                    slider_price = value.toInt();
                                    home_price = slider_price;
                                  });
                                }),
                          ),

                          Text('₩$slider_price',style :TextStyle(fontSize: 15.0)),
                        ],
                      ),

                      Divider(color: accpurple, height: 15.0,),

                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          InkWell(
                            child: Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween ,
                                children: <Widget>[
                                  Container(
                                    width: MediaQuery.of(context).size.width/4.5,
                                    child:  Column(
                                      children: <Widget>[
                                        Icon(Icons.date_range),
                                        Text('Check-In',
                                        ),
                                      ],
                                    ) ,
                                  ),
                                  Container(
                                    padding: EdgeInsets.fromLTRB(0.0, 20, 0.0, 0.0),
                                    width:MediaQuery.of(context).size.width/2.5,
                                    child: Text(_datevalue1.split(' ')[0] +'\n', style: TextStyle(fontSize: 20.0)),
                                  ),
                                ],
                              ),
                            ),
                            onTap: (){
                              !_enabled ? _selectDate() : null ;
                            },
                          ),
                          InkWell(
                            child:  Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    width: MediaQuery.of(context).size.width/4.5,
                                    child: Column(
                                      children: <Widget>[
                                        Icon(Icons.date_range),
                                        Text('Check-Out')
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.fromLTRB(0.0, 20, 0.0, 0.0),
                                    width:MediaQuery.of(context).size.width/2.5,
                                    child: Text(_datevalue2.split(' ')[0] +'\n', style: TextStyle(fontSize: 20.0)),
                                  ),
                                ],
                              ),
                            ),
                            onTap: (){
                              !_enabled ? _selectDate1() : null ;
                            },
                          ),
                        ],
                      ),

                      Divider(color: accpurple, height: 15.0),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width/2.2,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    Icon(Icons.person),
                                    Text('성인')
                                  ],
                                ),

                                IconButton(
                                    icon: new Icon(const IconData(0xe15b, fontFamily: 'MaterialIcons'),
                                        color: Colors.black), onPressed: minus_adult
                                ),

                                Text('$_adult_peo', style: new TextStyle(fontSize: 20.0)),

                                IconButton(icon: Icon(Icons.add), onPressed: add_adult),
                              ],
                            ),
                          ),

                          Container(
                            width: MediaQuery.of(context).size.width/2.2,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    Icon(Icons.child_care),
                                    Text('아동')
                                  ],
                                ),
                                IconButton(icon: new Icon(
                                    const IconData(0xe15b, fontFamily: 'MaterialIcons'),
                                    color: Colors.black), onPressed: minus_child),
                                Text('$_child_peo',
                                    style: new TextStyle(fontSize: 20.0)),
                                IconButton(icon: Icon(Icons.add), onPressed: add_child),
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                new SizedBox(height: 20.0),

                new Text(" $usr님, 어떤 방을 찾고 계신가요?", style: TextStyle(fontSize: 20.0, color: Colors.grey[700])),

                new SizedBox(height: 10.0),

                new Container(
                  height: 700.0,
                  child:_buildGrid(context),
                ),
              ]
          ),
        )
    );
  }

  void changed(e) {
    setState(() {
      slider_price= e;
      message = "price \$:  " + "${e.toStringAsFixed(1)}   ";
    });
  }
}