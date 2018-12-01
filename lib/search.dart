import 'package:flutter/material.dart';

class Search extends StatelessWidget {
  final _searchController = TextEditingController();
  final color = Colors.grey;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.all(12.0),
        children: <Widget>[
          SizedBox(height: 24.0),
          new Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              IconButton(
                  icon: Icon(Icons.clear, size: 30.0,),
                  onPressed:() {
                    Navigator.pop(context);
                  }
              )
            ],
          ),
          TextField(
            controller: _searchController,
            cursorColor: Colors.blueGrey,
            textAlign: TextAlign.justify,
            style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.black),
            decoration: InputDecoration(
              hintText: '어디서 잘래요?',
              hintStyle: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
          ),

          new Row(
            children: <Widget>[
              new OutlineButton(
                child: Text("날짜"),
                borderSide: BorderSide(color: color[700]),
                splashColor: color[600],
                onPressed: () {},
              ),
              SizedBox(width: 10.0),
              new OutlineButton(
                child: Text("인원"),
                borderSide: BorderSide(color: color[700]),
                splashColor: color[600],
                onPressed: () {},
              ),
              SizedBox(width: 10.0),
              new OutlineButton(
                child: Text("푸헹"),
                borderSide: BorderSide(color: color[700]),
                splashColor: color[600],
                onPressed: () {},
              ),
            ],
          ),

        ],
      ),

    );
  }
}