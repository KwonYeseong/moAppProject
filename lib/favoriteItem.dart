
import 'package:flutter/material.dart';
import 'favorite.dart';
import 'Detail.dart';

Color themecolor = Colors.redAccent;

class FavoriteItem extends StatefulWidget {
  final int id;
  final String name;
  final String location;
  final String type;
  final String cost;
  final String photoURL1;
  final String photoURL2;
  final String photoURL3;
  final String photoURL4;
  final VoidCallback callback;

  FavoriteItem({this.id, this.name, this.location, this.type, this.cost,
    this.photoURL1,this.photoURL2,this.photoURL3,this.photoURL4 ,this.callback});

  FavoriteItemState createState() => new FavoriteItemState();
}

class FavoriteItemState extends State<FavoriteItem>   with TickerProviderStateMixin{
  FavoriteListState favoriteList = new FavoriteListState();

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


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          if(editButtonFlag == false){
            Navigator
                .of(context)
                .push(MaterialPageRoute(
                builder: (BuildContext context) => DetailPage()));
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
                              widget.type,
                              style: new TextStyle(
                                  fontSize: 18.0,
                                  color: themecolor,
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(width: 10.0),
                            new Text(widget.location,
                                style: new TextStyle(
                                    fontSize: 18.0,
                                    color: themecolor,
                                    fontWeight: FontWeight.w600))
                          ],
                        ),
                        SizedBox(height: 5.0),
                        new Text(
                          widget.name,
                          style: new TextStyle(
                              fontSize: 25.0,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 5.0),
                        new Text(
                          widget.cost,
                          style: new TextStyle(fontSize: 20.0, color: Colors.black),
                        ),
                      ],
                    )
                  ]),
            ))

    );
  }

}