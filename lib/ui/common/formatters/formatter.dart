import 'package:places/data/model/place.dart';

///Функция форматирования дистанции в удобочитаемый вид
String distanceFormat(double value) => value > 1000
    ? "${(value / 1000).toStringAsFixed(1)} км"
    : "${value.ceil()} м";

///Функция форматирования режима работы
String openOrCloseText(bool isOpen, DateTime openingTime) => isOpen
    ? "открыто"
    : "закрыто до ${openingTime.hour.toString().padLeft(2, '0')}:00";

String placeTypeText(PlaceType type) {
  switch (type) {
    case PlaceType.temple:
      return "Храм";
      break;
    case PlaceType.temple:
      return "Храм";
      break;
    case PlaceType.monument:
      return "Памятник";
      break;
    case PlaceType.theatre:
      return "Театр";
      break;
    case PlaceType.restaurant:
      return "Ресторан";
      break;
    case PlaceType.cafe:
      return "Кафе";
      break;
    case PlaceType.hotel:
      return "Отель";
      break;
    case PlaceType.museum:
      return "Музей";
      break;
    case PlaceType.park:
      return "Парк";
      break;
    case PlaceType.other:
      return "Особое место";
      break;
    default:
      return "Особое место";
  }
}
