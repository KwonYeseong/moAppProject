import 'package:flutter/material.dart';

import 'package:flutter_moapp_project/model/house.dart';
import 'package:flutter_moapp_project/model/house_repository.dart';
import 'search.dart';

class AccentColorOverride extends StatelessWidget {
  const AccentColorOverride({Key key, this.color, this.child})
      : super(key: key);

  final Color color;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Theme(
      child: child,
      data: Theme.of(context).copyWith(accentColor: color),
    );
  }
}

class Backup extends StatelessWidget {
  final color = Colors.grey;
  final tagColor = Colors.pink[300];
  String usr = "Yeseong";

  List<Card> _buildGridCard(BuildContext context) {
    List<House> houses = HouseRepository.loadHouse();

    if(houses == null || houses.isEmpty){
      return const <Card>[];
    }
    return  houses.map((house) {
      return Card(
        child: Container(
          width: 200.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              AspectRatio(
                aspectRatio: 18 / 13,
                child: Image.network(
                  house.image,
                  fit: BoxFit.fitWidth,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(house.hashTag, style: TextStyle(fontSize:12.0, color: tagColor)),
                      Text(house.title, style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
                      //Text(house.addr, style: TextStyle(fontSize: 13.5, fontStyle: FontStyle.italic)),
                      Text(house.dates + " is available", style: TextStyle(fontSize: 13.5, color: color[500])),
                      Text(house.price.toString() + "원/박", style: TextStyle(fontSize: 13.5,color: color[500])),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return new SafeArea(
        child: new Scaffold(
          body: new ListView(
              padding: EdgeInsets.all(16.0),
              children: <Widget>[
                /*AccentColorOverride(
                  color: color,
                  child: new TextField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      filled: false,
                      labelText: '집에 가서 자는 건 어떠세요?',
                    ),
                  ),
                ),*/

                new OutlineButton.icon(
                    icon: Icon(Icons.search),
                    label: Text("집에 가서 자는 건 어떠세요?", style: TextStyle(color: color[600]),),
                    borderSide: BorderSide(color: color, width: 2.0),
                    onPressed: () {
                      Navigator.push(
                        context, MaterialPageRoute(builder: (context) => Search()),
                      );
                    }

                ),
                new Row(
                  children: <Widget>[
                    new OutlineButton(
                      child: Text("날짜"),
                      borderSide: BorderSide(color: color[700]),
                      splashColor: color[600],
                      onPressed: () {},
                    ),
                    SizedBox(width: 10.0),
                    new OutlineButton(
                      child: Text("인원"),
                      borderSide: BorderSide(color: color[700]),
                      splashColor: color[600],
                      onPressed: () {},
                    ),
                    SizedBox(width: 10.0),
                    new OutlineButton(
                      child: Text("푸헹"),
                      borderSide: BorderSide(color: color[700]),
                      splashColor: color[600],
                      onPressed: () {},
                    ),
                  ],
                ),
                new SizedBox(height: 24.0),
                new Text(" $usr님, 어떤 방을 찾고 계신가요?",style: TextStyle(fontSize: 20.0, color: Colors.grey[700])),
                new SizedBox(height: 8.0),
                //new SizedBox(
                new Container(
                  height: 500.0,
                  child: new GridView.count(
                    crossAxisCount: 2,
                    //padding: EdgeInsets.all(20.0),
                    childAspectRatio: 8.0 / 10.0,
                    children: _buildGridCard(context),
                  ),
                ),
              ]
          ),
        )
    );
  }
}
