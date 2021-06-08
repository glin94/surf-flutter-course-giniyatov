import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:places/ui/res/strings/common_strings.dart';
import 'package:places/ui/res/themes.dart';
import 'package:places/ui/screen/main_screen.dart';
import 'package:provider/provider.dart';
import 'data/interactor/settings_interactor.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('ru', "RU"),
      ],
      theme:
          context.watch<SettingsInteractor>().isDark ? darkTheme : lightTheme,
      title: appName,
      home: MainScreen(),
    );
  }
}
