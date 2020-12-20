import 'package:intl/intl.dart';

class Sight {
  Sight({
    this.name,
    this.url,
    this.details,
    this.type,
    this.openingHours,
    this.lat,
    this.lon,
    this.visitingDate,
    this.isFavorite = false,
  });

  final String name, url, details, type;

  /// Часы работы, например [9,18] c 9:00 до 18:00
  final List<int> openingHours;

  final double lat, lon;

  /// Дата посещения места
  final DateTime visitingDate;

  bool isFavorite;

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
