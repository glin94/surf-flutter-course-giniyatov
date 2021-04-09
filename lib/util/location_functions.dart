import 'dart:math';

import 'package:places/data/model/sight.dart';

///Функция проверки нахождения места в промежутке дистанции
arePointsNear(Sight checkPoint, Map<String, double> centerPoint,
    double minDistanceKm, double maxDistanceKm) {
  var ky = 40000 / 360;
  var kx = cos(pi * centerPoint['lat'] / 180.0) * ky;
  var dx = ((centerPoint['lon'] - checkPoint.lon) * kx).abs();
  var dy = ((centerPoint['lat'] - checkPoint.lat) * ky).abs();
  return sqrt(dx * dx + dy * dy) >= minDistanceKm &&
      sqrt(dx * dx + dy * dy) <= maxDistanceKm;
}
