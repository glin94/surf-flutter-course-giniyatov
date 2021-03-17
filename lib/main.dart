import 'package:flutter/material.dart';
import 'package:places/domain/theme.dart';
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
      theme: themeModel.isDark ? darkTheme : lightTheme,
      title: "SightApp",
      home: MainScreen(),
    );
  }
}
