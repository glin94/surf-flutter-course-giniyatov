import 'package:flutter/painting.dart';

/// text styles
final TextStyle _text = TextStyle(
      fontFamily: "Roboto",
      fontStyle: FontStyle.normal,
    ),
    textHeadLine4 = _text.copyWith(fontSize: 32, fontWeight: FontWeight.bold),
    textHeadLine5 = _text.copyWith(fontSize: 24, fontWeight: FontWeight.bold),
    textHeadLine6 = _text.copyWith(fontSize: 18),
    textSubtitle1 = _text.copyWith(fontSize: 16),
    textBody1 = _text.copyWith(fontSize: 14, fontWeight: FontWeight.bold),
    textBody2 = _text.copyWith(fontSize: 14),
    textCaption = _text.copyWith(fontSize: 12),
    textButton = _text.copyWith(
        fontSize: 14, fontWeight: FontWeight.bold, letterSpacing: 0.3);
