import 'package:flutter/material.dart';

Color themecolor = Colors.redAccent;

class HostingItem extends StatefulWidget {
  final String name;
  final String location;
  final String type;
  final String cost;
  final String url;

  HostingItem({this.name, this.location, this.type, this.cost, this.url});

  HostingItemState createState() => new HostingItemState();
}

class HostingItemState extends State<HostingItem> {
  Widget _Image() {
    return Container(
        width: 470.0,
        child: Image.network(
          "https://media.mnn.com/assets/images/2016/03/AIrbnb-Tokyo.jpg.653x0_q80_crop-smart.jpg",
          //widget.url,
          fit: BoxFit.fitWidth,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => print("go to detail page\n"),
        child:  Padding(
          padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 30.0),
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
                ),

              ]),

        )
    );
  }
}
