import 'package:flutter/material.dart';
import 'favorite.dart';
import 'addHost.dart';

Color themecolor = Colors.redAccent;

class HostingItem extends StatefulWidget {
  final String name;
  final String location;
  final String type;
  final String cost;
  final String url;
  final VoidCallback callback;

  HostingItem({this.name, this.location, this.type, this.cost, this.url, this.callback});

  HostingItemState createState() => new HostingItemState();
}

class HostingItemState extends State<HostingItem> {
  Widget _Image() {
    return Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.4),
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: <BoxShadow>[
            BoxShadow(
              spreadRadius: 2.0,
              blurRadius: 10.0,
              color: Colors.black26,
            ),
          ],
        ),
        width: 470.0,
        height: 200.0,
        child: Image.network(
          //"https://media.mnn.com/assets/images/2016/03/AIrbnb-Tokyo.jpg.653x0_q80_crop-smart.jpg",
          widget.url,
          fit: BoxFit.fill,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          if(editButtonFlag == false){
            Navigator
                .of(context)
                .push(MaterialPageRoute(
                builder: (BuildContext context) => addHosting()));
          }
          else{
            setState(() {
              selected = !selected;
            });
            widget.callback();
          }
        },
        child: Card(
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
                          new Text(
                            widget.type,
                            style: new TextStyle(
                                fontSize: 15.0,
                                color: themecolor,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(width: 10.0),
                          new Text(widget.location,
                              style: new TextStyle(
                                  fontSize: 15.0,
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
                  ),


                ]),
          ),
        )
    );
  }
}