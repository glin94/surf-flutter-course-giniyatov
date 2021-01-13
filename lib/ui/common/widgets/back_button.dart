import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/ui/res/assets.dart';

///Кнопка назад
class CustomBackButton extends StatelessWidget {
  const CustomBackButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      iconSize: 32,
      icon: SvgPicture.asset(
        icArrow,
        color: Theme.of(context).accentColor,
      ),
      onPressed: () {},
    );
  }
}
