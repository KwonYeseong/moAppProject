import 'package:flutter/foundation.dart';

class House{
  const House({
    @required this.image,
    @required this.title,
    @required this.addr,
    @required this.dates,
    @required this.price,
    @required this.hashTag,
    @required this.id,
  }) :  assert(image !=null),
        assert(title != null),
        assert(addr != null),
        assert(dates != null),
        assert(price != null),
        assert(hashTag != null),
        assert(id != null);

  final String image;
  final String title;
  final String addr;
  final String dates;
  final int price;
  final String hashTag;
  final int id;
}