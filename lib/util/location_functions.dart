import 'dart:math';

import 'package:places/data/model/place.dart';

///Функция проверки нахождения места в промежутке дистанции
bool arePointsNear(Place checkPoint, Map<String, double> centerPoint,
    double minDistanceKm, double maxDistanceKm) {
  var ky = 40000 / 360;
  var kx = cos(pi * centerPoint['lat'] / 180.0) * ky;
  var dx = ((centerPoint['lon'] - checkPoint.lon) * kx).abs();
  var dy = ((centerPoint['lat'] - checkPoint.lat) * ky).abs();
  return sqrt(dx * dx + dy * dy) >= minDistanceKm &&
      sqrt(dx * dx + dy * dy) <= maxDistanceKm;
}

degreesToRadians(degrees) {
  return degrees * pi / 180;
}

distanceInKmBetweenEarthCoordinates(
    double lat1, double lon1, double lat2, double lon2) {
  var earthRadiusKm = 6371;

  var dLat = degreesToRadians(lat2 - lat1);
  var dLon = degreesToRadians(lon2 - lon1);

  lat1 = degreesToRadians(lat1);
  lat2 = degreesToRadians(lat2);

  var a = sin(dLat / 2) * sin(dLat / 2) +
      sin(dLon / 2) * sin(dLon / 2) * cos(lat1) * cos(lat2);
  var c = 2 * atan2(sqrt(a), sqrt(1 - a));
  return earthRadiusKm * c;
}
