import 'package:flutter/material.dart';

import 'ui/screen/sight_details.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "SightApp",
      home: SightDetails(),
    );
  }
}
