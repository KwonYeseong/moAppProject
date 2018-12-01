import 'package:flutter_moapp_project/model/house.dart';

class HouseRepository{
  static List<House> loadHouse(){
    const allHouse = <House> [
      House(
          image: "https://image.ohou.se/image/resize/bucketplace-v2-development/uploads-cards-snapshots-1541078302_X.jpeg/1536/none",
      title : '장성동 감성남의 집',
          addr : '포항시 장성동 215',
          dates : '11/2~11/6',
          price : 23000,
          hashTag : '#갬성 #거뭇거뭇',
          id : 0
      ),
      House(
          image:
          "https://image.ohou.se/image/resize/bucketplace-v2-development/uploads-cards-snapshots-1531451092_3xVRO.jpeg/1536/none",
          title : '친환경 가구의 집',
          addr : '포항시 흥해읍 정류장 512',
          dates : '11/1~11/14',
          price : 62000,
          hashTag : '#나무 #친황경 #따끔따끔',
          id : 2
      ),
      House(
          image:
          "https://image.ohou.se/image/resize/bucketplace-v2-development/uploads-cards-snapshots1541220231_V4Aqd2vYS.jpeg/1536/none",
          title : '언덕위의 하얀 집',
          addr : '안알려줌~125',
          dates : '11/24~11/30',
          price : 71000,
          hashTag : '#화이트 #다락방 #밝은집',
          id : 3
      ),
      House(
          image: "https://image.ohou.se/image/resize/bucketplace-v2-development/uploads-cards-snapshots1541158649_j.jpeg/1536/none",
          title : '옆집',
          addr : '포항시 장성동 1621',
          dates : '12/23~12/25',
          price : 50000,
          hashTag : '#깔끔 #홈파티',
          id : 4
      ),
    ];

    return allHouse;
  }
}