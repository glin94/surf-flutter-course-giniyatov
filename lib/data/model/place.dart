import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Place {
  final String id, name, description, type;

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
    this.visitingDate,
    this.isFavorite = false,
  });

  Place.fromJson(Map<String, dynamic> json)
      : id = json['id'].toString(),
        lat = json['lat'],
        lon = json['lon'],
        name = json['name'],
        urls = json['urls'],
        type = json['placeType'],
        description = json['description'];

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
