import 'package:places/ui/res/assets.dart';

class OnBoard {
  OnBoard({
    this.title,
    this.description,
    this.iconPath,
  });
  String title, description, iconPath;
}

final onboardList = [
  OnBoard(
    title: "Добро пожаловать в Путеводитель",
    description: "Ищи новые локации и сохраняй самые любимые.",
    iconPath: icArrows,
  ),
  OnBoard(
    title: "Построй маршрут и отправляйся в путь",
    description: "Достигай цели максимально быстро и комфортно.",
    iconPath: icBag,
  ),
  OnBoard(
    title: "Добавляй места, которые нашёл сам",
    description: "Делись самыми интересными и помоги нам стать лучше!",
    iconPath: icHand,
  )
];
