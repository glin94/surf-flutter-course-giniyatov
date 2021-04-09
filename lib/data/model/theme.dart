import 'package:flutter/foundation.dart';

///Класс для изменения темы приложения
class ThemeModel extends ChangeNotifier {
  bool isDark = false;

  ///изменение темы
  set changeTheme(bool val) {
    isDark = val;
    notifyListeners();
  }
}

final themeModel = ThemeModel();
