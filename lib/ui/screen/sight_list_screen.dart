import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class SightListScreen extends StatefulWidget {
  @override
  _SightListScreenState createState() => _SightListScreenState();
}

class _SightListScreenState extends State<SightListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            elevation: 0,
            centerTitle: false,
            toolbarHeight: 150,
            title: Text("Список\nинтересных мест",
                maxLines: 2,
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: Color(0xFF3B3E5B),
                    fontFamily: "Roboto",
                    fontSize: 40,
                    fontWeight: FontWeight.bold))));
  }
}
