import 'dart:ui';

import 'package:flutter/material.dart';

const Color colorBackground = Color(0xFFF5F5F5),
    colorInnactiveBlack = Color.fromRGBO(124, 126, 146, 0.56),
    colorError = Color(0xFFEF4343),

//light
    colorLightMain = Color(0xFF252849),
    colorLightSecondary = Color(0xFF3B3E5B),
    colorLightSecondary2 = Color(0xFF7C7E92),
    colorLightGreen = Color(0xFF4CAF50),
    colorLightYellow = Color(0xFFFCDD3D),

//dark
    colorDark = Color(0xFF1A1A20),
    colorDarkMain = Color(0xFF21222C),
    colorDarkSecondary = Color(0xFF3B3E5B),
    colorDarkSecondary2 = Color(0xFF7C7E92),
    colorDarkGreen = Color(0xFF6ADA6F),
    colorDarkYellow = Color(0xFFFFE769),
    colorDarkRed = Color(0xFFCF2A2A);

const LinearGradient gradient = LinearGradient(
    begin: FractionalOffset.topCenter,
    end: FractionalOffset.bottomCenter,
    colors: [
      Color(0xFF252849),
      Color(0xFF143B3E5B),
    ],
    stops: [
      0.0,
      1.0,
    ]);
