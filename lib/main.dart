import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:places/data/model/theme.dart';
import 'package:places/ui/res/themes.dart';
import 'package:places/ui/screen/main_screen.dart';

void main() => runApp(App());

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
    themeModel.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: [
        const Locale('ru', "RU"),
        const Locale('en', "US"),
      ],
      theme: themeModel.isDark ? darkTheme : lightTheme,
      title: "SightApp",
      home: MainScreen(),
    );
  }
}
