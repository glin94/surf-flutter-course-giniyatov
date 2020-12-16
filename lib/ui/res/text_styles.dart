import 'package:flutter/painting.dart';

/// text styles
final TextStyle _text = TextStyle(
      fontFamily: "Roboto",
      fontStyle: FontStyle.normal,
    ),
    textLargeTitle = _text.copyWith(fontSize: 32, fontWeight: FontWeight.bold),
    textTitle = _text.copyWith(fontSize: 24, fontWeight: FontWeight.bold),
    textSubTitle = _text.copyWith(fontSize: 18),
    textRegular = _text.copyWith(fontSize: 16),
    textSmallBold = _text.copyWith(fontSize: 14, fontWeight: FontWeight.bold),
    textSmall = _text.copyWith(fontSize: 14),
    textSuperSmall = _text.copyWith(fontSize: 12),
    textButton = _text.copyWith(
        fontSize: 14, fontWeight: FontWeight.bold, letterSpacing: 0.3);
