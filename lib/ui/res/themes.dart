import 'package:flutter/material.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/res/text_styles.dart';

final lightTheme = ThemeData(
  accentColor: colorLightMain,
  backgroundColor: Colors.white,
  secondaryHeaderColor: colorLightSecondary,
  iconTheme: IconThemeData(
    color: colorLightSecondary,
  ),
  disabledColor: colorLightSecondary2,
  canvasColor: Colors.white,
  appBarTheme: AppBarTheme(
    textTheme: TextTheme(
      headline6: textHeadLine6.copyWith(
        color: colorLightMain,
      ),
    ),
    elevation: 0,
    centerTitle: true,
    color: Colors.white,
  ),
  cardColor: colorLightGrey,
  primaryColor: Colors.white,
  scaffoldBackgroundColor: Colors.white,
  primaryColorDark: colorLightGrey,
  textTheme: TextTheme(
    headline6: textHeadLine6.copyWith(
      color: colorLightMain,
    ),
    headline4: textHeadLine4.copyWith(
      color: colorLightMain,
    ),
    headline5: textHeadLine5.copyWith(
      color: colorLightMain,
    ),
    subtitle1: textSubtitle1.copyWith(
      color: colorLightSecondary,
    ),
    bodyText1: textBody1.copyWith(
      color: colorLightSecondary,
    ),
    bodyText2: textBody2.copyWith(
      color: colorLightSecondary,
    ),
    caption: textCaption.copyWith(
      color: colorInnactiveBlack,
    ),
    button: textBody1,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    elevation: 0,
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      primary: colorLightSecondary,
      textStyle: textBody2,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      primary: colorLightGreen,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      textStyle: textButton,
      onPrimary: Colors.white,
    ),
  ),
  sliderTheme: SliderThemeData(
    trackHeight: 0.2,
    activeTrackColor: colorLightGreen,
    inactiveTrackColor: colorInnactiveBlack,
    thumbColor: Colors.white,
    overlayColor: Colors.transparent,
  ),
);

final darkTheme = ThemeData(
  accentColor: Colors.white,
  cardColor: colorDarkBlack,
  backgroundColor: colorDarkSecondary,
  secondaryHeaderColor: Colors.white,
  iconTheme: IconThemeData(
    color: Colors.white,
  ),
  disabledColor: colorDarkSecondary2,
  canvasColor: colorDarkMain,
  appBarTheme: AppBarTheme(
    textTheme: TextTheme(
      headline6: textHeadLine6.copyWith(
        color: Colors.white,
      ),
    ),
    elevation: 0,
    centerTitle: true,
    color: colorDarkMain,
  ),
  scaffoldBackgroundColor: colorDarkMain,
  primaryColorDark: colorDark,
  textTheme: TextTheme(
    headline6: textHeadLine6.copyWith(
      color: Colors.white,
    ),
    headline4: textHeadLine4.copyWith(
      color: Colors.white,
    ),
    headline5: textHeadLine5.copyWith(
      color: Colors.white,
    ),
    subtitle1: textSubtitle1.copyWith(
      color: Colors.white,
    ),
    bodyText1: textBody1.copyWith(
      color: Colors.white,
    ),
    bodyText2: textBody2.copyWith(
      color: Colors.white,
    ),
    caption: textCaption.copyWith(
      color: colorInnactiveBlack,
    ),
    button: textBody1,
  ),
  primaryColor: colorDarkSecondary,
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    elevation: 0,
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      primary: Colors.white,
      textStyle: textBody2,
    ),
  ),
  buttonTheme: ButtonThemeData(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    buttonColor: colorDarkGreen,
    textTheme: ButtonTextTheme.accent,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      primary: colorDarkGreen,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      textStyle: textButton,
      onPrimary: Colors.white,
    ),
  ),
  sliderTheme: SliderThemeData(
    trackHeight: 0.2,
    activeTrackColor: colorDarkGreen,
    inactiveTrackColor: colorInnactiveBlack,
    thumbColor: Colors.white,
    overlayColor: Colors.transparent,
  ),
);
