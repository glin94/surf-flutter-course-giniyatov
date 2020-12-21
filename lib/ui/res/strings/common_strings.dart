import 'package:places/domain/sight.dart';

String openOrCloseText(Sight sight) => sight.isOpen
    ? "открыто"
    : "закрыто до ${sight.openingTime.hour.toString().padLeft(2, '0')}:00";
const String wantToVisitPlacesEmptyText =
    "Отмечайте понравившиеся\n места и они появиятся здесь.";
const String visitedPlacesEmptyText =
    "Завершите маршрут,\n чтобы место попало сюда.";
