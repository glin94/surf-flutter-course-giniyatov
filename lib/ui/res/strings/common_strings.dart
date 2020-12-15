import 'package:places/domain/sight.dart';

String openOrCloseText(Sight sight) => sight.isOpen
    ? "открыто"
    : "закрыто до ${sight.openingTime.hour.toString().padLeft(2, '0')}:00";
