import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'favorite.dart';
import 'Detail.dart';
import 'DB.dart';

Color themecolor = Colors.redAccent;


class FavoriteItem extends StatefulWidget {
  int houseID;
  String roomname;
  String dong;
  int roomtype;
  int price;
  String photoURL1;
  String photoURL2;
  String photoURL3;
  String photoURL4;
  VoidCallback callback;

  FavoriteItem({this.houseID, this.roomname, this.dong, this.roomtype, this.price,
    this.photoURL1,this.photoURL2,this.photoURL3,this.photoURL4 ,this.callback});

  FavoriteItemState createState() => new FavoriteItemState();
}

class FavoriteItemState extends State<FavoriteItem>   with TickerProviderStateMixin{
  FavoriteListState favoriteList = new FavoriteListState();
  Record1 record;


  void initState(){
    super.initState();
    _buildRecord();
  }

  Future<void> _buildRecord() async{
    print('_buildRecord');
    print('houseID: ${widget.houseID}');
    List a = ['1','2'];
    await Firestore.instance.collection('HOUSE')
        .where("houseID", isEqualTo: widget.houseID)
        .snapshots()
        .listen((data){
      data.documents.forEach((ddata){
        print("foreach ${ddata.toString()}");
        record = Record1.fromSnapshot(ddata);
      });

    });
  }


  Widget _Image() {
    TabController imagesController = TabController(length: 4, vsync: this);
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 200.0,
      child:Center(
        child: DefaultTabController(
          length: 4,
          child: Stack(
            children: <Widget>[
              TabBarView(
                controller: imagesController,
                children: <Widget>[
                  Image.network(widget.photoURL1, fit:BoxFit.fill),
                  Image.network(widget.photoURL2, fit:BoxFit.fill),
                  Image.network(widget.photoURL3, fit:BoxFit.fill),
                  Image.network(widget.photoURL4, fit:BoxFit.fill),
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
    );

  }

  String RoomText(int value) {
    switch(value){
      case 0: return '원룸';break;
      case 1: return '미투';break;
      case 2: return '정투';break;
      case 3: return '기타';break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          if(editButtonFlag == false){
            Navigator
                .of(context)
                .push(MaterialPageRoute(
                builder: (BuildContext context) => DetailPage(record: record)));
          }
          else{
            setState(() {
              //selected[widget.id] = !selected[widget.id];
              print('click on edit??\n');
              selected = !selected;
            });
            widget.callback();
            //favoriteList.hello(this.widget);
          }
        },
        child: Card(
            child: Container(
              decoration:
              editButtonFlag
                  ? new BoxDecoration(color: Colors.grey[300])
                  : new BoxDecoration(),
              padding: EdgeInsets.fromLTRB(10.0, 10.0,10.0, 10.0),
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
                            new Text(
                              RoomText(widget.roomtype),
                              style: new TextStyle(
                                  fontSize: 18.0,
                                  color: themecolor,
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(width: 10.0),
                            new Text(widget.dong,
                                style: new TextStyle(
                                    fontSize: 18.0,
                                    color: themecolor,
                                    fontWeight: FontWeight.w600))
                          ],
                        ),
                        SizedBox(height: 5.0),
                        new Text(
                          widget.roomname,
                          style: new TextStyle(
                              fontSize: 25.0,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 5.0),
                        new Text(
                          widget.price.toString(),
                          style: new TextStyle(fontSize: 20.0, color: Colors.black),
                        ),
                      ],
                    )
                  ]),
            ))

    );
  }

}