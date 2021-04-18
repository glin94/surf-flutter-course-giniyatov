import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum PlaceType {
  temple,
  monument,
  park,
  theatre,
  museum,
  hotel,
  restaurant,
  cafe,
  other
}

class Place {
  final int id;
  final String name, description, type;

  double distance;

  final List<dynamic> urls;

  ///широта и долгота
  final double lat, lon;

  /// Часы работы, например [9,18] c 9:00 до 18:00
  List<int> openingHours = const [9, 18];

  /// Дата посещения места
  DateTime visitingDate;

  bool isFavorite;

  Place({
    @required this.id,
    this.name,
    this.urls,
    this.description,
    this.type,
    this.openingHours,
    this.lat,
    this.lon,
    this.distance,
    this.visitingDate,
    this.isFavorite = false,
  });

  Place.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        lat = json['lat'],
        lon = json['lng'],
        name = json['name'],
        urls = json['urls'],
        type = json['placeType'],
        distance = json['distance'] ?? 0.0,
        description = json['description'];

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': this.id,
        'lat': this.lat,
        'lng': this.lon,
        'name': this.name,
        'placeType': placeTypeToString(this.placeType),
        'description': this.lat,
      };

  static String placeTypeToString(PlaceType type) {
    switch (type) {
      case PlaceType.temple:
        return "temple";
        break;
      case PlaceType.monument:
        return "monument";
        break;
      case PlaceType.park:
        return "park";
        break;
      case PlaceType.theatre:
        return "theatre";
        break;
      case PlaceType.museum:
        return "museum";
        break;
      case PlaceType.hotel:
        return "hotel";
        break;
      case PlaceType.restaurant:
        return "restaurant";
        break;
      case PlaceType.cafe:
        return "cafe";
        break;
      case PlaceType.other:
        return "other";
        break;
      default:
        return "other";
    }
  }

  PlaceType get placeType {
    switch (type) {
      case "temple":
        return PlaceType.temple;
        break;
      case "monument":
        return PlaceType.monument;
        break;
      case "park":
        return PlaceType.park;
        break;
      case "theatre":
        return PlaceType.theatre;
        break;
      case "museum":
        return PlaceType.museum;
        break;
      case "hotel":
        return PlaceType.hotel;
        break;
      case "restaurant":
        return PlaceType.restaurant;
        break;
      case "cafe":
        return PlaceType.cafe;
        break;
      case "other":
        return PlaceType.other;
        break;
      default:
        return PlaceType.other;
    }
  }

  DateTime get openingTime => DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
        openingHours.first,
      );

  DateTime get closingTime => DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
        openingHours.last,
      );

  bool get isOpen =>
      DateTime.now().isAfter(openingTime) &&
          DateTime.now().isBefore(closingTime) ||
      openingHours.first == 0 && openingHours.last == 0;

  ///  Заглушка для посещенных мест
  bool get isAchieved => DateTime.now().isAfter(visitingDate);

  String get plannedOrAchievedText => isAchieved
      ? DateFormat('Цель достигнута ${DateFormat.DAY} MMM. ${DateFormat.YEAR}')
          .format(visitingDate)
      : DateFormat('Запланировано на ${DateFormat.DAY} MMM. ${DateFormat.YEAR}')
          .format(visitingDate);
}
