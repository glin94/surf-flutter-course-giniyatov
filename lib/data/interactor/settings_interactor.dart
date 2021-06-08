import 'package:flutter/material.dart';

class SettingsInteractor extends ChangeNotifier {
  bool isDark = false;

  ///изменение темы
  set changeTheme(bool val) {
    isDark = val;
    notifyListeners();
  }
}
