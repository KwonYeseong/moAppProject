import 'package:flutter/material.dart';

import 'package:flutter_moapp_project/model/house.dart';
import 'package:flutter_moapp_project/model/house_repository.dart';
import 'search.dart';
import 'Detail.dart';
import 'package:numberpicker/numberpicker.dart';


class AccentColorOverride extends StatelessWidget {
  const AccentColorOverride({Key key, this.color, this.child})
      : super(key: key);

  final Color color;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Theme(
      child: child,
      data: Theme.of(context).copyWith(accentColor: color),
    );
  }
}


class Grey extends StatefulWidget {
  @override
  _GreyState createState() => new  _GreyState();
}





class _GreyState extends State<Grey> {

  final myController = TextEditingController();
  int val = 0;
  // double e=4.00;
  String message;

//dropdownbutton
  String _value = null;
  String _datevalue1 = '';
  String _datevalue2 = '';
  bool _enabled = false;
  List<String> _values = new List<String>();

  final _scaffoldKey = new GlobalKey<ScaffoldState>();





  Future _selectDate() async {
    DateTime picked = await showDatePicker(
      context: context,
      initialDate: new DateTime.now(),
      firstDate: new DateTime(2016),
      lastDate: new DateTime(2019),
    );
    if(picked != null) setState(() => _datevalue1 = picked.toString());
  }
  Future _selectDate1() async {
    DateTime picked = await showDatePicker(
      context: context,
      initialDate: new DateTime.now(),
      firstDate: new DateTime(2016),
      lastDate: new DateTime(2019),
    );
    if(picked != null) setState(() => _datevalue2 = picked.toString());
  }


  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    myController.dispose();
    super.dispose();
  }





  /*
  VoidCallback _showPersBottomSheetCallBack;
  int _currentIntValue = 10;
  // double _currentDoubleValue = 3.0;
  NumberPicker integerNumberPicker;
  // NumberPicker decimalNumberPicker;
  _handleValueChanged(num value) {
    if (value != null) {
      //`setState` will notify the framework that the internal state of this object has changed.
      if (value is int) {
        setState(() => _currentIntValue = value);
      } else {
        //  setState(() => _currentDoubleValue = value);
      }
    }
  }
  _handleValueChangedExternally(num value) {
    if (value != null) {
      if (value is int) {
        setState(() => _currentIntValue = value);
        integerNumberPicker.animateInt(value);
      } else {
        //    setState(() => _currentDoubleValue = value);
        //    decimalNumberPicker.animateDecimalAndInteger(value);
      }
    }
  }
*/
  final color = Colors.grey;
  final tagColor = Colors.redAccent;
  String usr = "Yeseong";
  bool isExpanded = false;
//사람수 number
  int _adult_peo = 0;
  int _child_peo = 0;

  void add_adult() {
    setState(() {
      _adult_peo ++;
    });
  }
  void add_child() {
    setState(() {
      _child_peo ++;
    });
  }


  void minus_adult() {
    setState(() {
      if (_adult_peo  != 0)
        _adult_peo --;
    });
  }
  void minus_child() {
    setState(() {
      if (_child_peo  != 0)
        _child_peo --;
    });
  }




  List<GestureDetector> _buildCard(BuildContext context) {
    List<House> houses = HouseRepository.loadHouse();

    if(houses == null || houses.isEmpty){
      return const <GestureDetector>[];
    }
    return  houses.map((house) {

      return new GestureDetector(
        onTap: (){
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => DetailPage()));


        },
        child: Card(
          //  Card하나 전체
          child: Container(
            //width: 200.0,
            height: 150.0,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 160.0,
                  child: Image.network(
                    house.image,
                    fit: BoxFit.fitWidth,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(16.0, 16.0, 12.0, 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(house.hashTag, style: TextStyle(fontSize:14.0, color: tagColor)),
                        Text(house.title, style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold)),
                        //Text(house.addr, style: TextStyle(fontSize: 13.5, fontStyle: FontStyle.italic)),
                        Text(house.dates + " is available", style: TextStyle(fontSize: 13.5, color: color[500])),
                        Text(house.price.toString() + "원/박", style: TextStyle(fontSize: 13.5,color: color[500])),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }).toList();
  }

  @override

  //dropdownbutton
  void initState(){
    _values.addAll(["Long","Short","Roomate"]);
    _value = _values.elementAt(0);
  }

  void _onChaged(String value){
    setState(() {
      _value = value;

    });
  }


  Widget build(BuildContext context) {

    return new SafeArea(
        child: new Scaffold(
          key: _scaffoldKey,
          body: new ListView(
              padding: EdgeInsets.all(10.0),
              children: <Widget>[

                Container(
/*
  decoration: BoxDecoration(
    border: Border.all(

            color: tagColor,
            width: 1.0
    )
  ),

  */
                  /*
  decoration: ShapeDecoration(
    color: Colors.white,
    shape: Border.all(
      color: Colors.red,
      width: 8.0,
    ) + Border.all(
      color: Colors.green,
      width: 8.0,
    )
  ),
  */
                  child: ExpansionTile(

                    title: Row(
                      children: <Widget>[
                        DropdownButton(
                            value: _value,
                            items: _values.map((String value){
                              return DropdownMenuItem(

                                value: value,

                                child: Row(
                                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Container(

                                      child:   Icon(Icons.home,color: tagColor,),
                                      width: MediaQuery.of(context).size.width/17,
                                    ),

                                    Text('${value}'),
                                  ],
                                ),
                              );
                            }).toList(),
                            onChanged: (String value){
                              _onChaged(value);
                            }
                        ),
                        Container(
                          // width: MediaQuery.of(context).size.width/3,

                          padding: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                          child: Text("집에 가서 자는 건 어떠세요?", style: TextStyle(color: color[600]),),

                        ),

/*
                      new OutlineButton(
                        //  icon: Icon(Icons.search),
                          child: Text("집에 가서 자는 건 어떠세요?", style: TextStyle(color: color[600]),),
                          borderSide: BorderSide(color: color, width: 2.0),
                          onPressed:(){}

                      ),
                      */
                      ],

                    ),

                    //   backgroundColor: Colors.yellow,

                    trailing: Icon(Icons.search),

                    children: <Widget>[


                      Container(
                        //  width: MediaQuery.of(context).size.width ,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween ,
                          children: <Widget>[
                            Container(
                              width: MediaQuery.of(context).size.width/4.5,
                              child:  Column(
                                children: <Widget>[
                                  Icon(Icons.location_on),
                                  //   Text('Check-In',
                                  //   style: TextStyle(fontSize: 20.0),
                                  // ),
                                  //FlatButton.icon(onPressed: (){}, icon: Icon(Icons.date_range), label: Text('Check-In'))
                                ],
                              ) ,
                            ),
                            Container(
                                padding: EdgeInsets.fromLTRB(10.0, 20, 10.0, 15.0),
                                width:MediaQuery.of(context).size.width/1.4,
                                child: TextFormField(
                                  controller: myController,
                                  decoration: new InputDecoration.collapsed(

                                      hintText: '지역을 찾아보세요'
                                  ),


                                )
                            ),
                          ],
                        ),
                      ),





                      /*
      Container(
        padding: EdgeInsets.all(10.0),
        child:   new Container(

          //   padding: const EdgeInsets.fromLTRB(50.0,0.0,10,0),
          alignment: Alignment.centerLeft,
          height: 60.0,
          decoration: new BoxDecoration(
            //     color: Colors.blueGrey,
              border: new Border.all(
                  color: Colors.black,
                  width: 1.0
              ),
              borderRadius: new BorderRadius.circular(20.0)
          ),
          child: Row(
            children: <Widget>[
              Icon(Icons.date_range),
              //    Icon(Icons.child_care),
              FlatButton(onPressed: (){}, child: Text(''))

            ],
          ),
        ),
      ),
      */
/*
      InkWell(
        child: Container(
          padding: EdgeInsets.all(10.0),
          child:   new Container(

            //   padding: const EdgeInsets.fromLTRB(50.0,0.0,10,0),
            alignment: Alignment.centerLeft,
            height: 60.0,
            decoration: new BoxDecoration(
              //     color: Colors.blueGrey,
                border: new Border.all(
                    color: Colors.black,
                    width: 1.0
                ),
                borderRadius: new BorderRadius.circular(20.0)
            ),
            child: Row(
              children: <Widget>[
                Icon(Icons.person),
                Text('  성인  2 , 아동  0')
              ],
            ),

          ),
        ),
        onTap: (){
          //  _showIntegerDialog();
        },
      ),



*/


                      Divider(color: tagColor, height: 15.0,),

                      //   Icon(Icons.monetization_on),


                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Container(
                              padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
                              width: MediaQuery.of(context).size.width/4.5,
                              child:  Column(
                                children: <Widget>[
                                  Icon(Icons.attach_money),
                                  Text('1박 가격')
                                ],
                              )
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width/1.8,
                            child:     Slider(
                                activeColor: tagColor,
                                inactiveColor: color,
                                value: val.toDouble(),
                                max: 150000, min: 0.0, divisions: 150,
                                onChanged: (double value) {
                                  setState(() {
                                    val = value.toInt();

                                  });
                                }),

                          ),
                          Text('₩$val',style :TextStyle(fontSize: 15.0),),
                        ],
                      ),




                      Divider(color: tagColor, height: 15.0,),

                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[

                          InkWell(
                            child:  Container(
                              //  width: MediaQuery.of(context).size.width ,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween ,
                                children: <Widget>[
                                  Container(
                                    width: MediaQuery.of(context).size.width/4.5,
                                    child:  Column(
                                      children: <Widget>[
                                        Icon(Icons.date_range),
                                        Text('Check-In',
                                          //   style: TextStyle(fontSize: 20.0),
                                        ),
                                        //FlatButton.icon(onPressed: (){}, icon: Icon(Icons.date_range), label: Text('Check-In'))
                                      ],
                                    ) ,
                                  ),
                                  Container(
                                    padding: EdgeInsets.fromLTRB(0.0, 20, 0.0, 0.0),
                                    width:MediaQuery.of(context).size.width/2.5,
                                    child: Text(_datevalue1.split(' ')[0] +'\n', style: TextStyle(fontSize: 20.0),),

                                  ),
                                ],
                              ),
                            ),

                            onTap: (){
                              !_enabled ? _selectDate() : null ;
                            },
                          ),
                          InkWell(
                            child:  Container(
                              //width: MediaQuery.of(context).size.width /2.2 ,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    width: MediaQuery.of(context).size.width/4.5,
                                    child: Column(
                                      children: <Widget>[
                                        Icon(Icons.date_range),
                                        Text('Check-Out')
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.fromLTRB(0.0, 20, 0.0, 0.0),
                                    width:MediaQuery.of(context).size.width/2.5,
                                    child: Text(_datevalue2.split(' ')[0] +'\n', style: TextStyle(fontSize: 20.0),),

                                  ),
                                ],
                              ),
                            ),
                            onTap: (){
                              !_enabled ? _selectDate1() : null ;
                            },
                          ),

                        ],
                      ),


                      Divider(color: tagColor, height: 15.0,),


                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width/2.2,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    Icon(Icons.person),
                                    Text('성인')
                                  ],
                                ),

                                IconButton(icon: new Icon(
                                    const IconData(0xe15b, fontFamily: 'MaterialIcons'),
                                    color: Colors.black), onPressed: minus_adult),
                                Text('$_adult_peo',
                                    style: new TextStyle(fontSize: 20.0)),
                                IconButton(icon: Icon(Icons.add), onPressed: add_adult),

                              ],
                            ),
                          ),

                          Container(
                            width: MediaQuery.of(context).size.width/2.2,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    Icon(Icons.child_care),
                                    Text('아동')
                                  ],
                                ),
                                IconButton(icon: new Icon(
                                    const IconData(0xe15b, fontFamily: 'MaterialIcons'),
                                    color: Colors.black), onPressed: minus_child),
                                Text('$_child_peo',
                                    style: new TextStyle(fontSize: 20.0)),
                                IconButton(icon: Icon(Icons.add), onPressed: add_child),

                              ],
                            ),
                          )

                        ],
                      ),

                      InkWell(
                        splashColor: Colors.redAccent,
                        highlightColor: Colors.yellow,
                        child: Container(
                          width: MediaQuery.of(context).size.width/2,
                          padding: EdgeInsets.all(20.0),
                          child:   new Container(

                            //   padding: const EdgeInsets.fromLTRB(50.0,0.0,10,0),
                              alignment: Alignment.center,
                              height: 60.0,
                              decoration: new BoxDecoration(

                                // color: Colors.blueGrey,
                                  color: tagColor,
                                  border: new Border.all(
                                      color: tagColor,
                                      width: 0.5
                                  ),
                                  borderRadius: new BorderRadius.circular(20.0)
                              ),
                              child: Text('Search',style: new TextStyle(color: Colors.white, fontSize: 22.0),)
                          ),
                        ),
                        onTap: (){
                          print('장소 :' + myController.text);
                          print('성인 : $_adult_peo');
                          print('아동 : $_child_peo');
                          print('check in : $_datevalue1');
                          print('check out : $_datevalue2');
                          print('check out : $val');

                        },

                      ),

                    ],

                  ),
                ),

                new SizedBox(height: 20.0),
                new Text(" $usr님, 어떤 방을 찾고 계신가요?",style: TextStyle(fontSize: 20.0, color: Colors.grey[700])),
                new SizedBox(height: 10.0),
                new Container(
                    height: 700.0,
                    child: new ListView(
                      children: _buildCard(context),
                    )
                ),
              ]
          ),
        )
    );
  }

  void changed(e) {
    setState(() {
      val = e;
      message ="price \$:  " +"${e.toStringAsFixed(1)}   ";

    });
  }


}