import 'package:flutter/foundation.dart';

class ThemeModel extends ChangeNotifier {
  bool isDark = false;

  set changeTheme(bool val) {
    isDark = val;
    notifyListeners();
  }
}

final themeModel = ThemeModel();
