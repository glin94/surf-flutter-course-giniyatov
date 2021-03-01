///Функция форматирования дистанции в удобочитаемый вид
String distanceFormat(double value) => value > 1000
    ? "${(value / 1000).toStringAsFixed(1)} км"
    : "${value.ceil()} м";

///Функция форматирования режима работы
String openOrCloseText(bool isOpen, DateTime openingTime) => isOpen
    ? "открыто"
    : "закрыто до ${openingTime.hour.toString().padLeft(2, '0')}:00";
