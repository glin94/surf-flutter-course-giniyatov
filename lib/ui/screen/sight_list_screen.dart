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
            title: RichText(
                text: TextSpan(
                    style: TextStyle(
                        fontFamily: "Roboto",
                        fontSize: 36,
                        fontWeight: FontWeight.bold),
                    children: [
                  TextSpan(
                      text: "С",
                      style: TextStyle(color: Color(0xFF4CAF50)),
                      children: [
                        TextSpan(
                          text: "писок\n",
                          style: TextStyle(color: Color(0xFF3B3E5B)),
                        )
                      ]),
                  TextSpan(
                      text: "и",
                      style: TextStyle(color: Color(0xFFFCDD3D)),
                      children: [
                        TextSpan(
                            text: "нтересных мест",
                            style: TextStyle(color: Color(0xFF3B3E5B)))
                      ])
                ]))));
  }
}
