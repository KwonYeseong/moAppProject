import 'package:flutter/foundation.dart';

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