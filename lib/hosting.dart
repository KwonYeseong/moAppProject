import 'package:flutter/material.dart';

import 'favorite.dart';
import 'addHost.dart';
import 'hostingItem.dart';

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
      body: SafeArea(
          child: Column(
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
                                color: Colors.black54,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () => editButtonPress(),
                        child: Container(
                            padding: EdgeInsets.all(10.0),
                            child: new Text(editText(),
                                style: new TextStyle(
                                  fontSize: 20.0,
                                  color: themecolor,
                                  //fontWeight: FontWeight),)
                                ))),
                      )
                    ],
                  ),
                ),
                Divider(height: 2.0, indent: 2.0),
                Expanded(
                    child: new ListView(
                        children: hostingItems
                            .map((item) => new HostingItem(
                          name: item.name,
                          location: item.location,
                          type: item.type,
                          cost: item.cost,
                          url: item.url,
                          callback: () {
                            removeItem(item);
                          },
                        ))
                            .toList()))
              ])),
      floatingActionButton: new FloatingActionButton(
        child: new Icon(Icons.add),
        onPressed: () =>  Navigator
            .of(context)
            .push(MaterialPageRoute(
            builder: (BuildContext context) => addHosting())),
        backgroundColor: themecolor,
      ),
    );
  }
}