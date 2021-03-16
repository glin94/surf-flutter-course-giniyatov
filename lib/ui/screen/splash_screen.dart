import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/ui/res/assets.dart';
import 'package:places/ui/res/colors.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNext();
  }

  Future<bool> isInitialized() =>
      Future.delayed(Duration(seconds: 2), () => true);

  void _navigateToNext() async {
    if (await isInitialized()) print("Переход на следующий экран");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          Color(0xFFFCDD3D),
          Color(0xFF4CAF50),
        ]),
      ),
      child: Center(
        child: Container(
          height: 160,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: SvgPicture.asset(
              icMap,
              color: colorLightGreen,
              height: 80,
            ),
          ),
        ),
      ),
    );
  }
}
