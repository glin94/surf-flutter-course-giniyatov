import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/common/widgets/sight_card.dart';
import 'package:places/ui/res/strings/common_strings.dart';

/// Экран отображения списка интересных мест
class SightListScreen extends StatefulWidget {
  @override
  _SightListScreenState createState() => _SightListScreenState();
}

class _SightListScreenState extends State<SightListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: AppBar(
          elevation: 0,
          centerTitle: false,
          toolbarHeight: 100,
          title: Text(
            sightListScreenTitle.replaceFirst(" ", "\n"),
            maxLines: 2,
            textAlign: TextAlign.left,
            style: Theme.of(context).textTheme.headline4,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        child: Column(
          children: mocks
              .map(
                (item) => Padding(
                  padding: const EdgeInsets.only(
                    bottom: 24,
                  ),
                  child: SightCard(
                    sight: item,
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
