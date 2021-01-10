///Функция формата дистанции в удобочитаемый вид
String distanceFormat(double value) => value > 1000
    ? "${(value / 1000).toStringAsFixed(1)} км"
    : "${value.ceil()} м";
