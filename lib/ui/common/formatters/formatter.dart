import 'package:places/domain/sight.dart';

///Функция форматирования дистанции в удобочитаемый вид
String distanceFormat(double value) => value > 1000
    ? "${(value / 1000).toStringAsFixed(1)} км"
    : "${value.ceil()} м";

///Функция форматирования режима работы
String openOrCloseText(Sight sight) => sight.isOpen
    ? "открыто"
    : "закрыто до ${sight.openingTime.hour.toString().padLeft(2, '0')}:00";
