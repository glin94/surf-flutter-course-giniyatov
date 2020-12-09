import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:places/colors.dart';
import 'package:places/mocks.dart';
import 'package:places/text_styles.dart';
import 'package:places/ui/screen/sight_card.dart';

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
            style: textLargeTitle.copyWith(color: colorLightSecondary)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: mocks.map((item) => SightCard(sight: item)).toList(),
        ),
      ),
    );
  }
}
