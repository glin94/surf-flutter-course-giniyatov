import 'package:flutter/material.dart';
import 'package:places/ui/res/colors.dart';

///Разделитель
class Separator extends StatelessWidget {
  const Separator({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Divider(
        height: 0.2,
        color: colorInnactiveBlack,
      ),
    );
  }
}
