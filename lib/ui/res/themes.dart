import 'package:flutter/material.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/res/text_styles.dart';

final lightTheme = ThemeData(
  backgroundColor: Colors.white,
  secondaryHeaderColor: colorLightSecondary,
  iconTheme: IconThemeData(
    color: colorLightSecondary,
  ),
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
  buttonTheme: ButtonThemeData(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    buttonColor: colorLightGreen,
    textTheme: ButtonTextTheme.primary,
  ),
);

final darkTheme = ThemeData(
  backgroundColor: colorDarkSecondary,
  secondaryHeaderColor: Colors.white,
  iconTheme: IconThemeData(
    color: Colors.white,
  ),
  canvasColor: colorDarkMain,
  appBarTheme: AppBarTheme(
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
    textTheme: ButtonTextTheme.primary,
  ),
);
