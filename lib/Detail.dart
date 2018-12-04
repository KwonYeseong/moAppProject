import 'package:flutter/material.dart';
import 'DB.dart';

class DetailPage extends StatefulWidget {
  final Record1 record;

  DetailPage({@required this.record});

  @override
  _DetailPageState createState() => new _DetailPageState(record: record);
}

class _DetailPageState extends State<DetailPage>  with TickerProviderStateMixin{
  final Record1 record;
  final tagColor = Colors.redAccent;
  final shadowColor = Colors.red[300];
  bool alreadySaved = false;

  _DetailPageState({@required this.record});

  _buildProductImagesWidgets() {
    TabController imagesController = TabController(length: 4, vsync: this);
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        //height: MediaQuery.of(context).size.height / 4,
        child: Center(
          child: DefaultTabController(
            length: 4,
            child: Stack(
              children: <Widget>[
                TabBarView(
                  controller: imagesController,
                  children: <Widget>[
                    Image.network(record.photourl1),
                    Image.network(record.photourl2),
                    Image.network(record.photourl3),
                    Image.network(record.photourl4),
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
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    @override
    Column buildButtonColumn(IconData icon, String label) {
      //Color color = Theme.of(context).primaryColor;
      Color color = Colors.blueGrey;

      return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color,size: 35.0,),
          Container(
            margin: const EdgeInsets.only(top: 8.0),
            child: Text(
              label,
              style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.w400,
                color: color,
              ),
            ),
          ),
        ],
      );
    }

    return new Scaffold(
      //     appBar: new AppBar(
      //       title: new Text(widget.title),
      //     ),
      body: SafeArea(
        child:

        new Container(

          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[

              Stack(
                alignment: const Alignment(1.0,-1.0),
                children: <Widget>[
                  new InkWell(

                    child:Container(
                      padding:  EdgeInsets.all(0.0),
                      // height: 200,
                      //  width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height /3 ,
                      child: _buildProductImagesWidgets(),



                      /*      child:
                      Carousel(
                        boxFit: BoxFit.cover,
                        images: [
                          Image.network('http://newsimg.hankookilbo.com/2017/12/06/201712060419390897_1.jpg')

                         // FadeInImage.assetNetwork(placeholder: null, image: 'http://newsimg.hankookilbo.com/2017/12/06/201712060419390897_1.jpg')
                        ],

                        animationCurve: Curves.fastOutSlowIn,
                        animationDuration: Duration(milliseconds: 2000),

                      ),
                      */

                    ),
                    onTap: (){print('abtab');},
                    onDoubleTap: (){
                      print('doubletap');
                    },
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      IconButton(
                          icon: Icon(Icons.arrow_back),
                          onPressed: (){
                            Navigator.pop(context);
                          }
                      ),

                      IconButton(
                          icon: Icon(alreadySaved ? Icons.favorite : Icons.favorite_border,
                            color: alreadySaved ? Colors.red : Colors.red,),
                          onPressed: (){
                            print('sss');
                            setState(() {
                              if (alreadySaved) {
                                alreadySaved = false;
                              } else {
                                alreadySaved = true;
                              }
                            });

                          })
                    ],
                  )
                ],
              ),

              Expanded(
                  child: ListView(

                    children: <Widget>[
                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[

                            Container(

                              child:Text(record.roomname, style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.w700),),
                              padding: EdgeInsets.fromLTRB(15.0, 0.0, 0.0, 0.0),
                            ),
                            ExpansionTile(title:
                            Container(
                                padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 5.0),
                                child: Text(record.hashtag, style: TextStyle(color:shadowColor ),))

                            )

                          ],
                        ),

                      ),

                      ListTile(
                        title: Text('${record.price}/day',style: TextStyle(color: Colors.grey),),
                        subtitle: Text('${record.starttime}~${record.endtime}' +' is available', style: TextStyle(color: Colors.redAccent),),
                        trailing: RaisedButton(onPressed: (){}, //TODO 연락받을 번호 추가.
                          color: Colors.redAccent,
                          child: Text('지금예약',style: TextStyle(color: Colors.white),),),
                      ),
                      Container(
                        //padding: EdgeInsets.fromLTRB(20.0,0.0,20.0,0.0),
                        //child:  Divider(height:20.0,color: Colors.black,),
                      ),


                      ExpansionTile(

                        title:   Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            //     buildButtonColumn(Icons.people, 'For 1 people'),
                            buildButtonColumn(Icons.hotel, '1 bed'),
                            buildButtonColumn(Icons.not_interested, 'No bath room'),
                            buildButtonColumn(Icons.people, 'For 1 people'),
                            //       buildButtonColumn(Icons.home, 'Mini 2 room'),
                          ],
                        ),
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  buildButtonColumn(Icons.people, 'For 1 people'),
                                  buildButtonColumn(Icons.hotel, '1 bed'),
                                  buildButtonColumn(Icons.not_interested, 'No bath room'),
                                  // buildButtonColumn(Icons.home, 'Mini 2 room'),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  buildButtonColumn(Icons.people, 'For 1 people'),
                                  buildButtonColumn(Icons.hotel, '1 bed'),
                                  buildButtonColumn(Icons.not_interested, 'No bath room'),
                                  buildButtonColumn(Icons.home, 'Mini 2 room'),
                                ],
                              ),


                            ],
                          )


                        ],
                        //trailing: Text(''),

                      ),


                      ExpansionTile(

                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              //   alignment: MainAxisAlignment.center,
                              padding: EdgeInsets.all(10.0),
                              child: Text("세계 최고의 건축물! 7대 불가사의에서 하루를!",style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w700,color: Colors.black),),
                            )
                          ],
                        ),
                        children: <Widget>[
                          Text('더긴긴긴긴긴긴 설며어어어어어어어엉')
                        ],

                      ),




                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: Image.network(
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRqPovjU8WzgHGKz1sRBeTyc6sJiGNdPlP92DZPx6Iuk8DjCMr8',

                          fit: BoxFit.fitWidth,
                        ),
                      ),


                    ],
                  ))





              /*별점매기기 + review
          Container(

            padding: EdgeInsets.fromLTRB(13.0, 0.0, 10.0, 0.0),
            child: Row(

              children: <Widget>[
                Text('⭐⭐⭐⭐⭐',style: TextStyle(fontSize: 20.0),),
                FlatButton(
                  onPressed: (){},
                  child: Text('Review',style: TextStyle(color: Colors.brown),) ,)
              ],
            ) ,
          ),
    */


            ],
          ),
        ),




      ),



    );
  }


  Future<void> _neverSatisfied() async {


    SizedBox buildButtonColumn(IconData icon, String label) {
      //Color color = Theme.of(context).primaryColor;
      Color color = Colors.blueGrey[700];

      return SizedBox(


        width: 90,

        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Icon(icon, color: color,size: 35.0,),
            Container(
              margin: const EdgeInsets.only(top: 8.0),
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.w400,
                  color: color,
                ),
              ),
            ),
          ],
        ),

      );
    }
    return showDialog<void>(


      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(



          title: Text('More Detail'),


          content: SingleChildScrollView(
            child: ListBody(

              children: <Widget>[

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                  children: <Widget>[

                    buildButtonColumn(Icons.desktop_mac, 'No bath room'),
                    buildButtonColumn(Icons.home, 'Mini 2 room'),

                  ],
                )   ,

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                  children: <Widget>[

                    buildButtonColumn(Icons.not_interested, 'No bath room'),
                    buildButtonColumn(Icons.airline_seat_legroom_reduced, 'Mini 2 room'),

                  ],
                )   ,



                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                  children: <Widget>[

                    buildButtonColumn(Icons.not_interested, 'No bath room'),
                    buildButtonColumn(Icons.home, 'Mini 2 room'),

                  ],
                )   ,



                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                  children: <Widget>[
                    buildButtonColumn(Icons.people, 'For 1 people'),

                    buildButtonColumn(Icons.home, 'Mini 2 room'),

                  ],
                )   ,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                  children: <Widget>[

                    buildButtonColumn(Icons.home, 'Mini 2 room'),

                    buildButtonColumn(Icons.hotel, '1 bed'),


                  ],
                )   ,


              ],
            ),
          ),

          /*
          content:  GridView.count(crossAxisCount: 2    ,
         children: <Widget>[
                     Text('adfdaf')
            ],),
                       */

          actions: <Widget>[
            FlatButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

/*
class Record1 {
  final bool airconditioner;
  final String city;
  final String decription;
  final String detailaddress;
  final String dong;
  final String endtime;
  final bool freeparking;
  final String hashtag;
  final int houseID;
  final bool kitchen;
  final bool microwave;
  final int peoplenum;
  final String photourl1;
  final String photourl2;
  final String photourl3;
  final String photourl4;
  final int price;
  final String province;
  final int renttype;
  final String roomname;
  final int roomtype;
  final String starttime;
  final String street;
  final bool tv;
  final String uid;
  final bool wifi;
  final DocumentReference reference;

  Record1.fromMap(Map<String, dynamic> map, {this.reference})
      :
        airconditioner = map['airconditioner'],
        city= map['city'],
        decription= map['decription'],
        detailaddress= map['detailaddress'],
        dong= map['dong'],
        endtime= map['endtime'],
        freeparking= map['freeparking='],
        hashtag= map['hashtag'],
        houseID= map['houseID'],
        kitchen= map['kitchen'],
        microwave= map[' microwave'],
        peoplenum= map['peoplenum'],
        photourl1= map['photourl1'],
        photourl2= map['photourl2'],
        photourl3= map['photourl3'],
        photourl4= map['photourl4'],
        price= map['price'],
        province= map['privince'],
        renttype= map['renttype'],
        roomname= map['roomname'],
        roomtype= map['roomtype'],
        starttime= map['starttime'],
        street= map['street='],
        tv= map['tv'],
        uid= map['uid'],
        wifi= map['wifi'];



  Record1.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString() => "Record<$airconditioner:$city:$decription:$detailaddress:$dong:$endtime:$freeparking:$hashtag:$houseID:$kitchen:$microwave:$peoplenum:$photourl1:$photourl2:$photourl3:$photourl4:$price:$province:$renttype:$roomname:$roomtype:$starttime:$street:$tv:$uid:$wifi>";
}
*/