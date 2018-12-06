import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
        freeparking= map['freeparking'],
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