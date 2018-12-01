import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'favoriteItem.dart';

class FavoriteList extends StatefulWidget {
  @override
  FavoriteListState createState() => new FavoriteListState();
}

class FavoriteListState extends State<FavoriteList> {
  List<FavoriteItem> favoriteItems = [
    new FavoriteItem(
      name: "고양이가 있는 해맞이 공원 원룸",
      location: "환호동",
      type: "단기",
      cost: "30000원 /박",
      url:
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRXtSFkG4W7-fKfR2Ti2DtLz4jzDr6Prjwyl7y91lKJgXwa_bnTgQ",
    ),
    new FavoriteItem(
        name: "편세권 포세권 역세권 원룸",
        location: "서초구 반포동",
        type: "장기",
        cost: "600,000원 /월",
        url:
        "https://media.mnn.com/assets/images/2016/03/AIrbnb-Tokyo.jpg.653x0_q80_crop-smart.jpg")
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 30.0),
                Container(
                    padding: EdgeInsets.only(left: 30.0),
                    child: new Text("저장 목록",
                        style: new TextStyle(
                            fontSize: 35.0,
                            color: Colors.black,
                            fontWeight: FontWeight.bold))),
                SizedBox(height: 25.0),
                Expanded(
                    child: new ListView(
                        children: favoriteItems
                            .map((item) => new FavoriteItem(
                            name: item.name,
                            location: item.location,
                            type: item.type,
                            cost: item.cost,
                            url: item.url))
                            .toList())),
              ])),

    );
  }
}
