import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: MyFirstStflWidget());
  }
}

class MyFirstStlsWidget extends StatelessWidget {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    print("StatefulWidget: ${count++}");
    return Container(
      child: Center(child: Text("Hello!")),
    );
  }
}

class MyFirstStflWidget extends StatefulWidget {
  @override
  _MyFirstStflWidgetState createState() => _MyFirstStflWidgetState();
}

class _MyFirstStflWidgetState extends State<MyFirstStflWidget> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    print("StatefulWidget: ${count++}");
    return Container(child: Center(child: Text("Hello!")));
  }
}
