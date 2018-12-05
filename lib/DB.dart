import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class HouseInfo{
  const HouseInfo({
    @required this.houseID,

    @required this.uid,

    @required this.roomType,
    @required this.peopleNum,

    @required this.roomName,
    @required this.hashTag,
    @required this.description,

    @required this.province,
    @required this.city,
    @required this.dong,
    @required this.street,
    @required this.detailAddress,

    @required this.rentType,
    @required this.startTime,
    @required this.endTime,

    @required this.price,

    @required this.wifi,
    @required this.tv,
    @required this.kitchen,
    @required this.microWave,
    @required this.airConditioner,
    @required this.freeParking,

    @required this.photoUrl1,
    @required this.photoUrl2,
    @required this.photoUrl3,
    @required this.photoUrl4
  }) :  assert(houseID != null),

        assert(uid != null),

        assert(roomType != null),
        assert(peopleNum != null),

        assert(roomName != null),
        assert(hashTag != null),
        assert(description != null),

        assert(province != null),
        assert(dong != null),
        assert(street != null),
        assert(city != null),
        assert(detailAddress != null),

        assert(rentType != null),
        assert(startTime != null),
        assert(endTime != null),

        assert(price != null),

        assert(wifi != null),
        assert(tv != null),
        assert(kitchen != null),
        assert(microWave != null),
        assert(airConditioner != null),
        assert(freeParking != null),

        assert(photoUrl1 != null),
        assert(photoUrl2 != null),
        assert(photoUrl3 != null),
        assert(photoUrl4 != null);

  final int houseID;

  //userInfo
  final String uid;

  //roomInfo
  final int roomType; //원룸, 미투, 정투, 기타
  final int peopleNum;

  //title
  final String roomName;
  final String hashTag;
  final String description;

  //address
  final String province ; // 경상북도
  final String city; // 시/군/구
  final String dong;
  final String street; //도로명주소
  final String detailAddress; //상세주소

  //장,단기 양도 및 기간
  final int rentType;
  final String startTime;
  final String endTime;

  //가격
  final int price;

  //편의시설
  final bool wifi;
  final bool tv;
  final bool kitchen;
  final bool microWave;
  final bool airConditioner;
  final bool freeParking;

  //사진들
  final String photoUrl1;
  final String photoUrl2;
  final String photoUrl3;
  final String photoUrl4;
}

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
  final String phoneNumber;
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
        microwave= map['microwave'],
        peoplenum= map['peoplenum'],
        photourl1= map['photourl1'],
        photourl2= map['photourl2'],
        photourl3= map['photourl3'],
        photourl4= map['photourl4'],
        price= map['price'],
        province= map['province'],
        renttype= map['renttype'],
        roomname= map['roomname'],
        roomtype= map['roomtype'],
        starttime= map['starttime'],
        street= map['street'],
        tv= map['tv'],
        uid= map['uid'],
        wifi= map['wifi'],
        phoneNumber = map['phonenumber'];



  Record1.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString() => "Record<$airconditioner:$city:$decription:$detailaddress:$dong:$endtime:$freeparking:$hashtag:$houseID:$kitchen:$microwave:$peoplenum:$photourl1:$photourl2:$photourl3:$photourl4:$price:$province:$renttype:$roomname:$roomtype:$starttime:$street:$tv:$uid:$wifi>";
}