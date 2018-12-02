import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'favoriteItem.dart';
bool editButtonFlag = false;
bool selected = false;

List<FavoriteItem> removeItem = [];
List<FavoriteItem> favoriteItems = [
  new FavoriteItem(
    name: "고양이가 있는 해맞이 공원 원룸",
    location: "환호동",
    type: "단기",
    cost: "30000원 /박",
    url:
    "https://www.gannett-cdn.com/-mm-/9bdf8ad7ce526c41341414b8ec0"
        "69705582a94b3/c=1-0-1040-781/local/-/media/2018/04/06/Louisville/Lo"
        "uisville/636586068692591942-Airbnb-1.jpg?width=534&height=401&fit=crop",
  ),
  new FavoriteItem(
      name: "편세권 포세권 역세권 원룸",
      location: "서초구 반포동",
      type: "장기",
      cost: "600,000원 /월",
      url:
      "https://static1.squarespace.com/static/53403192e4b008f8c6d7fa3b/59156343d2b857304e98"
          "44e7/59156343d2b857304e984508/1494355821536/6D3A4893-HDR.jpg?format=1500w")
];
//List<bool> selected = new List<bool>(favoriteItems.length);


class FavoriteList extends StatefulWidget {
  @override
  FavoriteListState createState() => new FavoriteListState();
}

class FavoriteListState extends State<FavoriteList> {
  bool longPressFlag = false;


  String editText() {
    if (editButtonFlag == false)
      return '편집';
    else
      return '취소';
  }

  void removeItem(FavoriteItem item){
    setState(() {
      if(favoriteItems.contains(item)) {
        print('remove\n');
        favoriteItems.remove(item);
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
                            "저장 목록",
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
                        children: favoriteItems
                            .map((item) => new FavoriteItem(
                          name: item.name,
                          location: item.location,
                          type: item.type,
                          cost: item.cost,
                          url: item.url,
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