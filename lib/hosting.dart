import 'package:flutter/material.dart';

import 'hostingItem.dart';
import 'addHost.dart';

class HostingPage extends StatefulWidget {
  @override
  HostingPageState createState() => new HostingPageState();
}

class HostingPageState extends State<HostingPage> {

  List<HostingItem> hostingItems = [
    new HostingItem(
      name: "고양이가 있는 해맞이 공원 원룸",
      location: "환호동",
      type: "단기",
      cost: "30000원 /박",
      url: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRXtSFkG4W7-fKfR2Ti2DtLz4jzDr6Prjwyl7y91lKJgXwa_bnTgQ",
    ),
  ];

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: SafeArea(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height:30.0),
                Container(
                    padding: EdgeInsets.only(left:30.0),
                    child: new Text("호스팅 목록",
                        style: new TextStyle(
                            fontSize: 35.0,
                            color: Colors.black,
                            fontWeight: FontWeight.bold))
                ),
                SizedBox(height: 25.0),
                Expanded(
                    child: new ListView(
                        children: hostingItems
                            .map((item) => new HostingItem(
                            name: item.name,
                            location: item.location,
                            type: item.type,
                            cost: item.cost,
                            url: item.url))
                            .toList()))
              ])),
      floatingActionButton: new FloatingActionButton(
        child: new Icon(Icons.add),
        onPressed: (){
          print("go to add hosting page\n");
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => addHosting()));
        },
        backgroundColor: themecolor,
      ),
    );
  }
}