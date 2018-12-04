import 'dart:io';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';

import 'userInfo.dart' as userInfo;

class addHosting extends StatefulWidget {
  @override
  addHostingState createState() => addHostingState();
}

class addHostingState extends State<addHosting> with TickerProviderStateMixin {
  int houseIndex = -1;

  //Format
  TextStyle titleStyle = new TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.black);

  //ImagePicker
  File _livingroomImage;
  var _livingroomTemp;
  File _bedroomImage_1;
  var _bedroomTemp_1;
  File _bedroomImage_2;
  var _bedroomTemp_2;
  File _bathroomImage;
  var _bathroomTemp;

  String photoUrl1;
  String photoUrl2;
  String photoUrl3;
  String photoUrl4;

  //RoomInfo
  int _roomType = 0; // 0:원룸, 1:미투, 2:정투, 3:기타
  int _peopleNum = 0;

  void _handleRoomType(int value){
    setState((){
      _roomType = value;
    });
  }

  void _plusPeople(){
    setState(() {
      _peopleNum++;
    });
  }
  void _minusPeople(){
    setState(() {
      if(_peopleNum == 0) {}
      else{ _peopleNum--; }
    });
  }
  //Title
  TextEditingController roomNameController;
  TextEditingController hashTagController;
  TextEditingController descriptionController;

  String roomName = "";
  String hashTag = "";
  String description = "";

  //TimePicker
  int _rentType = 0; // 0:단기, 1:장기, 2:양도

  String _startTime;
  String _endTime;

  int _startYear;
  int _startMonth;
  int _startDate;
  int _endYear;
  int _endMonth;
  int _endDate;

  String _format = 'yyyy-mm-dd';
  bool _showTitleActions = true;
  TextEditingController _formatCtrl = TextEditingController();

  void _handleRentType(int value) {
    setState(() {
      _rentType = value;
    });
  }

  //Price
  TextEditingController priceController;
  int price = 0;

  //Location
  TextEditingController provinceController;
  TextEditingController cityController;
  TextEditingController dongController;
  TextEditingController streetController;
  TextEditingController detailAddressController;

  String province = "";
  String city = "";
  String dong = "";
  String street = "";
  String detailAddress = "";

  //Facility
  bool wifi = false;
  bool tv = false;
  bool kitchen = false;
  bool microWave = false;
  bool airConditioner = false;
  bool freeParking = false;

  @override
  void initState() {
    super.initState();
    _formatCtrl.text = 'yyyy-mm-dd';

    DateTime now = DateTime.now();
    _startYear = now.year;
    _startMonth = now.month;
    _startDate = now.day;
    _startTime = '$_startYear-$_startMonth-$_startDate';

    _endYear = now.year;
    _endMonth = now.month;
    _endDate = now.day;
    _endTime = '$_endYear-$_endMonth-$_endDate';
  }

  void _startDatePicker() {
    final bool showTitleActions = false;
    print("start date picker");
    DatePicker.showDatePicker(
      context,
      showTitleActions: _showTitleActions,
      minYear: 1970,
      maxYear: 2030,
      locale: 'en',
      initialYear: _startYear,
      initialMonth: _startMonth,
      initialDate: _startDate,
      dateFormat: _format,
      onChanged: (year, month, date) {
        debugPrint('onChanged date: $year-$month-$date');

        if (!showTitleActions) {
          _changeStartTime(year, month, date);
        }
      },
      onConfirm: (year, month, date) {
        _changeStartTime(year, month, date);
      },
    );
  }

  void _endDatePicker() {
    final bool showTitleActions = false;
    DatePicker.showDatePicker(
      context,
      showTitleActions: _showTitleActions,
      minYear: 1970,
      maxYear: 2030,
      locale: 'en',
      initialYear: _endYear,
      initialMonth: _endMonth,
      initialDate: _endDate,
      dateFormat: _format,
      onChanged: (year, month, date) {
        debugPrint('onChanged date: $year-$month-$date');

        if (!showTitleActions) {
          _changeEndTime(year, month, date);
        }
      },
      onConfirm: (year, month, date) {
        _changeEndTime(year, month, date);
      },
    );
  }

  void _changeStartTime(int year, int month, int date) {
    setState(() {
      _startYear = year;
      _startMonth = month;
      _startDate = date;
      _startTime = '$year-$month-$date';
    });
  }

  void _changeEndTime(int year, int month, int date) {
    setState(() {
      _endYear = year;
      _endMonth = month;
      _endDate = date;
      _endTime = '$year-$month-$date';
    });
  }

  Future getLvingroomImage() async {
    _livingroomTemp = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _livingroomImage = _livingroomTemp;
    });
  }
  Future getBedroom1Image() async {
    _bedroomTemp_1 = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _bedroomImage_1 = _bedroomTemp_1;
    });
  }
  Future getBedroom2Image() async {
    _bedroomTemp_2 = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _bedroomImage_2 = _bedroomTemp_2;
    });
  }
  Future getBathroomImage() async {
    _bathroomTemp = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _bathroomImage= _bathroomTemp;
    });
  }

  Future<void> getIndex() async{
    CollectionReference ref = Firestore.instance.collection('INDEX');
    QuerySnapshot events = await ref.getDocuments();
    events.documents.forEach((document){
      houseIndex = document['index'];
    });
  }

  //add image to firestore
  Future<void> addData2firestore() async{
    int t = 0;

    //add livingroom image
    StorageReference ref = FirebaseStorage.instance.ref().child('$houseIndex-${t++}.jpg');
    StorageUploadTask uploadTask = ref.putFile(_livingroomImage);
    photoUrl1 = await (await uploadTask.onComplete).ref.getDownloadURL();

    //add bedroom image
    ref = FirebaseStorage.instance.ref().child('$houseIndex-${t++}.jpg');
    uploadTask = ref.putFile(_bedroomImage_1);
    photoUrl2 = await (await uploadTask.onComplete).ref.getDownloadURL();

    //add bedroom image2
    ref = FirebaseStorage.instance.ref().child('$houseIndex-${t++}.jpg');
    uploadTask = ref.putFile(_bedroomImage_2);
    photoUrl3 = await (await uploadTask.onComplete).ref.getDownloadURL();

    //add bathroom image
    ref = FirebaseStorage.instance.ref().child('$houseIndex-$t.jpg');
    uploadTask = ref.putFile(_bathroomImage);
    photoUrl4 = await (await uploadTask.onComplete).ref.getDownloadURL();

    //add data to firebase
    addData2Firebase({
      'houseID':houseIndex,
      'uid':userInfo.user.uid,
      'roomtype':_roomType,
      'peoplenum':_peopleNum,
      'roomname':roomName,
      'hashtag':hashTag,
      'decription':description,
      'province':province,
      'city':city,
      'dong':dong,
      'street':street,
      'detailaddress':detailAddress,
      'renttype':_rentType,
      'starttime':_startTime,
      'endtime':_endTime,
      'price':price,
      'wifi':wifi,
      'tv':tv,
      'kitchen':kitchen,
      'microwave':microWave,
      'airconditioner':airConditioner,
      'freeparking':freeParking,
      'photourl1':photoUrl1,
      'photourl2':photoUrl2,
      'photourl3':photoUrl3,
      'photourl4':photoUrl4,
    });

  }
  //add data to firebase
  Future<void> addData2Firebase(data){
    Firestore.instance.document('HOUSE/$houseIndex').setData(data);
    Firestore.instance.document('INDEX/Index').setData({'index':(houseIndex+1)});
  }

  _previewImage() {
    getIndex();
    return Container(
      height: 250.0,
      color: Colors.grey[200],
      child: Row(
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width/2,
                height: 125.0,
                child: _livingroomImage == null ? IconButton(icon: Icon(Icons.camera_alt), onPressed: getLvingroomImage, iconSize: 54.0) : Image.file(_livingroomImage, fit: BoxFit.fill),
              ),
              Container(
                width: MediaQuery.of(context).size.width/2,
                height: 125.0,
                child: _bedroomImage_1 == null ? IconButton(icon: Icon(Icons.camera_alt), onPressed: getBedroom1Image, iconSize: 54.0) : Image.file(_bedroomTemp_1, fit: BoxFit.fill),
              ),
            ],
          ),
          Column(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width/2,
                height: 125.0,
                child: _bedroomImage_2 == null ? IconButton(icon: Icon(Icons.camera_alt), onPressed: getBedroom2Image, iconSize: 54.0) : Image.file(_bedroomTemp_2, fit: BoxFit.fill),
              ),
              Container(
                width: MediaQuery.of(context).size.width/2,
                height: 125.0,
                child: _bathroomImage == null ? IconButton(icon: Icon(Icons.camera_alt), onPressed: getBathroomImage, iconSize: 54.0) : Image.file(_bathroomTemp, fit: BoxFit.fill),
              ),
            ],
          )
        ],
      ),

    );
  }


  ExpansionTile _roomInfo(){
    double interval = 18.0;
    TextStyle directionStyle = new TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold);
    TextStyle infoSize = new TextStyle(fontSize: 18.0);

    return ExpansionTile(
      title: Text("방 정보", style: titleStyle),
      children: <Widget>[
        Container(
          padding: EdgeInsets.fromLTRB(30.0, 0.0, 40.0, 0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("방 종류", style: directionStyle),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(

                    width: MediaQuery.of(context).size.width/5,
                    child: Row(
                      children: <Widget>[
                        Text("원룸", style: infoSize),
                        Radio(value: 0, groupValue: _roomType, onChanged: _handleRoomType),
                      ],
                    ),
                  ),

                  Container(
                    width: MediaQuery.of(context).size.width/5,
                    child: Row(
                      children: <Widget>[
                        Text("미투", style: infoSize),
                        Radio(value: 1, groupValue: _roomType, onChanged: _handleRoomType),
                      ],
                    ),
                  ),


                  Container(
                    width: MediaQuery.of(context).size.width/5,
                    child: Row(
                      children: <Widget>[
                        Text("정투", style: infoSize),
                        Radio(value: 2, groupValue: _roomType, onChanged: _handleRoomType),
                      ],
                    ),
                  ),


                  Container(
                    width: MediaQuery.of(context).size.width/5,
                    child: Row(
                      children: <Widget>[
                        Text("기타", style: infoSize),
                        Radio(value: 3, groupValue: _roomType, onChanged: _handleRoomType),
                      ],
                    ),
                  ),

                ],
              ),

              SizedBox(height: interval),

              Text("숙박 인원", style: directionStyle),
              Container(
                //width: MediaQuery.of(context).size.width/1.6,
                child: Row(
                  children: <Widget>[
                    Icon(Icons.person),
                    IconButton(icon: new Icon(Icons.remove), onPressed: _minusPeople),
                    Text('$_peopleNum',  style: new TextStyle(fontSize: 20.0)),
                    IconButton(icon: Icon(Icons.add), onPressed: _plusPeople),

                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }




  ExpansionTile _title(){
    double interval = 25.0;
    TextStyle directionStyle = new TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold);

    return new ExpansionTile(
      title: Text("제목", style: titleStyle),
      children: <Widget>[
        Container(
          padding: EdgeInsets.fromLTRB(30.0, 0.0, 40.0, 0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("숙소에 제목을 붙여주세요", style: directionStyle),
              TextField(
                controller: roomNameController,
                decoration: InputDecoration(
                    hintText: "니가 사는 그집"
                ),
                onChanged: (text) {
                  roomName = text;
                  setState(() {});
                },
              ),

              SizedBox(height: interval),

              Text("몇가지 단어로 당신의 집을 표현하세요", style: directionStyle),
              TextField(
                controller: hashTagController,
                decoration: InputDecoration(
                    hintText: "#반짝이는_도시 #GREY"
                ),
                onChanged: (text) {
                  hashTag = text;
                  setState(() {});
                },
              ),

              SizedBox(height: interval),

              Text("당신의 집을 자세히 소개해주세요", style: directionStyle),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(
                    hintText: "보온이 완벽해요"
                ),
                onChanged: (text) {
                  description = text;
                  setState(() {});
                },
              ),
              SizedBox(height: interval)
            ],
          ),
        )

      ],
    );
  }





  ExpansionTile _location() {
    double interval = 25.0;
    TextStyle directionStyle = new TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold);

    return ExpansionTile(
      title: Text("위치", style: titleStyle),
      children: <Widget>[
        Container(
          padding: EdgeInsets.fromLTRB(30.0, 0.0, 40.0, 0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("도 / 주", style: directionStyle),
              TextField(
                controller: provinceController,
                decoration: InputDecoration(
                    hintText: "ex)경상북도"
                ),
                onChanged: (text) {
                  setState(() {
                    province = text;
                  });
                },
              ),

              SizedBox(height: interval),

              Text("시/군/구", style: directionStyle),
              TextField(
                controller: cityController,
                decoration: InputDecoration(
                    hintText: "ex)포항시"
                ),
                onChanged: (text) {
                  setState(() {
                    city = text;
                  });
                },
              ),

              SizedBox(height: interval),

              Text("동/읍/리", style: directionStyle),
              TextField(
                controller: dongController,
                decoration: InputDecoration(
                    hintText: "ex)장성동"
                ),
                onChanged: (text) {
                  setState(() {
                    dong = text;
                  });
                },
              ),

              SizedBox(height: interval),

              Text("도로명주소", style: directionStyle),
              TextField(
                controller: streetController,
                decoration: InputDecoration(
                    hintText: "ex)장성로 1426-18"
                ),
                onChanged: (text) {
                  setState(() {
                    street = text;
                  });
                },
              ),

              SizedBox(height: interval),

              Text("상세주소", style: directionStyle),
              TextField(
                controller: detailAddressController,
                decoration: InputDecoration(
                    hintText: "ex)진성펠리스 201호"
                ),
                onChanged: (text) {
                  setState(() {
                    detailAddress = text;
                  });
                },
              ),
              SizedBox(height: interval)
            ],
          ),
        )

      ],
    );
  }

  ExpansionTile _availableTime() {
    double interval = 20.0;
    TextStyle directionStyle = new TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold);
    TextStyle infoSize = new TextStyle(fontSize: 18.0);

    return ExpansionTile(
      title: Text("대여기간", style: titleStyle),
      children: <Widget>[
        Container(
          padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width /5,
                    child: Row(
                      children: <Widget>[
                        Text("단기", style: infoSize),
                        Radio(value: 0, groupValue: _rentType, onChanged: _handleRentType),
                      ],
                    ),
                  ),

                  Container(
                    width: MediaQuery.of(context).size.width /5,
                    child: Row(
                      children: <Widget>[

                        Text("장기", style: infoSize),
                        Radio(value: 1, groupValue: _rentType, onChanged: _handleRentType),
                      ],
                    ),
                  ),

                  Container(
                    width: MediaQuery.of(context).size.width /5,
                    child: Row(
                      children: <Widget>[
                        Text("양도", style: infoSize),
                        Radio(value: 2, groupValue: _rentType, onChanged: _handleRentType),
                      ],
                    ),
                  ),
                ],
              ),

              Container(
                padding: EdgeInsets.fromLTRB(15.0, 7.0,10.0, 7.0),
                child:  InkWell(
                  onTap: _startDatePicker,
                  child: Row(
                    children: <Widget>[
                      Text("대여 시작", style: directionStyle),
                      SizedBox(width: MediaQuery.of(context).size.width /2.5),
                      Text("$_startTime", style: TextStyle(fontSize: 16.0)),
                    ],
                  ),
                ),
              ),

              Container(
                padding: EdgeInsets.fromLTRB(15.0, 7.0, 10.0, 7.0),
                child:    InkWell(
                  onTap: _endDatePicker,
                  child: Row(
                    children: <Widget>[
                      Text("대여 종료", style: directionStyle),
                      SizedBox(width: MediaQuery.of(context).size.width /2.5),
                      Text("$_endTime", style: TextStyle(fontSize: 16.0)),
                    ],
                  ),
                ),
              ),
              SizedBox(height: interval)
            ],
          ),
        )
      ],
    );
  }

  ExpansionTile _price() {
    double interval = 20.0;
    TextStyle directionStyle = new TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold);

    return ExpansionTile(
      title: Text("가격", style: titleStyle),
      children: <Widget>[
        Container(
          padding: EdgeInsets.fromLTRB(30.0, 0.0, 40.0, 0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("원하는 가격을 적어보세요", style: directionStyle),
              TextField(
                controller: priceController,
                decoration: InputDecoration(hintText: 'ex)43000원'),
                onChanged: (text) {
                  price = int.parse(text);
                  setState(() {});
                },
              ),
              SizedBox(height: interval)
            ],
          ),
        )
      ],
    );
  }


  ExpansionTile _facility() {
    double interval = 60.0;
    TextStyle directionStyle = new TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold);
    TextStyle facilitiesStyle = new TextStyle(fontSize: 16.0);

    return ExpansionTile(
      title: Text("편의시설", style: titleStyle),
      children: <Widget>[
        Container(
          padding: EdgeInsets.fromLTRB(30.0, 0.0, 40.0, 0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("제공하는 편의시설을 골라주세요", style: directionStyle),
              SizedBox(height: 20.0),

              Divider(height: 5.0, color: Colors.black),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width/2.5,
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width/5,
                          child:   Text("무선 인터넷", style: facilitiesStyle),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width/11,
                          child:   Checkbox(
                            value: wifi,
                            onChanged: (bool value) {
                              setState(() {
                                wifi = value;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width/2.5,
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width/5,
                          child:  Text("TV", style: facilitiesStyle),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width/11,
                          child:     Checkbox(
                            value: tv,
                            onChanged: (bool value) {
                              setState(() {
                                tv = value;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width/2.5,
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width/5,
                          child:   Text("부엌", style: facilitiesStyle),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width/11,
                          child:  Checkbox(
                            value: kitchen,
                            onChanged: (bool value) {
                              setState(() {
                                kitchen = value;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width/2.5,
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width/5,
                          child:  Text("전자레인지", style: facilitiesStyle),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width/11,
                          child:     Checkbox(
                            value: microWave,
                            onChanged: (bool value) {
                              setState(() {
                                microWave = value;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),


              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width/2.5,
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width/5,
                          child:   Text("에어컨", style: facilitiesStyle),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width/11,
                          child:  Checkbox(
                            value: airConditioner,
                            onChanged: (bool value) {
                              setState(() {
                                airConditioner = value;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width/2.5,
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width/5,
                          child:  Text("무료주차", style: facilitiesStyle),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width/11,
                          child:        Checkbox(
                            value: freeParking,
                            onChanged: (bool value) {
                              setState(() {
                                freeParking = value;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Divider(height: 5.0, color: Colors.black),
            ],
          ),
        )
      ],
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container( //화면 전체를 감싸는 Container
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: <Widget>[
              Container( //빨간부분
                  height: 135.0,
                  width: MediaQuery.of(context).size.width,
                  //color: Colors.redAccent,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(width: 30.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: 52.0),
                          InkWell(child: Icon(Icons.clear, size: 28.0), onTap: () {Navigator.pop(context);}),
                          SizedBox(height: 12.0),
                          Text("호스팅", style: TextStyle(fontSize: 35.0, fontWeight: FontWeight.bold, color: Colors.black)),
                        ],
                      ),
                    ],
                  )
              ),
              Container(
                height: MediaQuery.of(context).size.height - 135.0,
                child: ListView(
                  children: <Widget>[
                    _previewImage(),
                    _roomInfo(),
                    Divider(height: 2.0),
                    _title(),
                    Divider(height: 2.0),
                    _location(),
                    Divider(height: 2.0),
                    _availableTime(),
                    Divider(height: 2.0),
                    _price(),
                    Divider(height: 2.0),
                    _facility(),
                    SizedBox(height: 50.0), // for floatingActionButton
                  ],
                ),
              )
            ],
          ),
        ),
        floatingActionButton: new FloatingActionButton(
          child: new Icon(Icons.done),
          onPressed: (){
            addData2firestore();
            Navigator.pop(context);
          },
          backgroundColor: Colors.redAccent,
        )
    );
  }
}