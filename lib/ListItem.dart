import 'package:flutter/material.dart';

class ListItem extends StatefulWidget {
  final String title;
  final IconData icon;
  final double dotSize = 12.0;

  ListItem({this.title, this.icon});

  ListItemState createState() => new ListItemState();
}

class ListItemState extends State<ListItem> {
  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
        onTap: () => print("onTap\n"),
        child: new Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 20.0),
            child: Column(
                children: <Widget>[
                  new Row(
                    children: <Widget>[
                      Expanded(
                        child: new Text(
                          widget.title,
                          style: new TextStyle(fontSize: 30.0, color: Colors.black54),
                        ),
                      ),
                      new Icon(
                        widget.icon,
                        //style: new TextStyle(fontSize: 12.0, color: Colors.grey),
                      ),
                    ],
                  ),
                  SizedBox(height:20.0),
                  Divider(height:4.0),
                ])
        )
    );
  }
}