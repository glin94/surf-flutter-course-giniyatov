import 'package:flutter/material.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: "App", home: MyFirstWidget());
  }
}

class MyFirstWidget extends StatelessWidget {
  //contextFunction() => context.runtimeType;

  @override
  Widget build(BuildContext context) {
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
  contextFunction() => context.runtimeType;

  @override
  Widget build(BuildContext context) {
    return Container(child: Center(child: Text("Hello!")));
  }
}
