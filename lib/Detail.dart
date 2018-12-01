import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  @override
  _DetailPageState createState() => new _DetailPageState();
}

class _DetailPageState extends State<DetailPage>  with TickerProviderStateMixin{
  final tagColor = Colors.redAccent;
  final shadowColor = Colors.red[300];
  bool alreadySaved = false;


  _buildProductImagesWidgets() {
    TabController imagesController = TabController(length: 3, vsync: this);
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        //height: MediaQuery.of(context).size.height / 4,
        child: Center(
          child: DefaultTabController(
            length: 3,
            child: Stack(
              children: <Widget>[
                TabBarView(
                  controller: imagesController,
                  children: <Widget>[
                    Image.network('http://newsimg.hankookilbo.com/2017/12/06/201712060419390897_1.jpg'),
                    Image.network('http://junggun.co.kr/wp-content/uploads/2017/03/cropped-maxresdefault.jpg'),
                    Image.network('https://media1.s-nbcnews.com/j/newscms/2018_30/1355945/home-exterior-today-180726-tease_3f99937c609d875fece6a12af1594bd9.fit-560w.jpg')
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
                                alreadySaved = true;
                              } else {
                                alreadySaved = false;
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

                              child:Text('환호 해맞이공원 101호 사막뷰!',style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.w700),),
                              padding: EdgeInsets.fromLTRB(15.0, 0.0, 0.0, 0.0),
                            ),
                            ExpansionTile(title:
                            Container(
                                padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 5.0),
                                child: Text('#화이트 #다락방 #밝은집 #동해물과백두산이 마르고 닳도록 #뾰로로로로로로로롱 태그를 달아보자아아아아',style: TextStyle(color:shadowColor ),))

                            )

                          ],
                        ),

                      ),

                      ListTile(
                        title: Text('₩40000 /day',style: TextStyle(color: Colors.grey),),
                        subtitle: Text('9/3~10/21' +' is available',style: TextStyle(color: Colors.redAccent),),
                        trailing: RaisedButton(onPressed: (){},
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