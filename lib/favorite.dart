import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'favoriteItem.dart';
bool editButtonFlag = false;
bool selected = false;

List<FavoriteItem> removeItem = [];
List<FavoriteItem> favoriteItems = [
  new FavoriteItem(
    id: 0,
    name: "고양이가 있는 해맞이 공원 원룸",
    location: "환호동",
    type: "단기",
    cost: "30000원 /박",
    photoURL1:
    "https://static1.squarespace.com/static/53403192e4b008f8c6d7fa3b/5b09d7fd575d1fdde96905cb/5b09d898352f53c0a5043ad5/1527372349483/Screen+Shot+2018-05-24+at+8.35.34+AM.jpg?format=2500w",
    photoURL2:
    "https://static1.squarespace.com/static/53403192e4b008f8c6d7fa3b/5b09d7fd575d1fdde96905cb/5b09d7fe70a6addca9a91468/1527371785262/IMG_2452-HDR-154.jpg?format=2500w",
    photoURL3:
    "https://static1.squarespace.com/static/53403192e4b008f8c6d7fa3b/5b09d7fd575d1fdde96905cb/5b09d89803ce64b89506964d/1527372349499/Screen+Shot+2018-05-24+at+8.35.22+AM.jpg?format=2500w",
    photoURL4:
    "https://static1.squarespace.com/static/53403192e4b008f8c6d7fa3b/5b09d7fd575d1fdde96905cb/5b09d89aaa4a990332e16ff4/1527372349498/Screen+Shot+2018-05-19+at+8.29.49+PM.jpg?format=2500w",
  ),
  new FavoriteItem(
    id: 1,
    name: "편세권 포세권 역세권 원룸",
    location: "서초구 반포동",
    type: "장기",
    cost: "600,000원 /월",
    photoURL1:
    "https://www.rent.com/blog/wp-content/uploads/2015/05/How-Much-Would-You-Pay-For-Your-Dream-Apartment-Rental-672x378.jpg",
    photoURL2:
    "https://assets3.thrillist.com/v1/image/1647776/size/tmg-article_default_mobile.jpg",
    photoURL3:
    "http://www.inzagreb.com/galerija/1443711655_main_img0.jpg",
    photoURL4:
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSdz3NzUZ3cZFsFvgJ0XW-JKVmz3gDJTgEz-xtEfkjwQKkAEKmg",
  )
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width /1.5,
                        padding: EdgeInsets.fromLTRB(150.0, 0.0, 0.0, 0.0),
                        child:new Text(
                          "저장 목록",
                          style: new TextStyle(
                              fontSize: 30.0,
                              color: Colors.black54,
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
                                      color: themecolor,
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
                        children: favoriteItems
                            .map((item) => new FavoriteItem(
                          name: item.name,
                          location: item.location,
                          type: item.type,
                          cost: item.cost,
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