import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/data/model/onboard.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/res/strings/common_strings.dart';
import 'package:places/ui/res/text_styles.dart';
import 'package:places/ui/screen/main_screen.dart';

/// Экран онбординга
class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  PageController _pageController = PageController(initialPage: 0);

  bool _isLast = false;

  @override
  void initState() {
    super.initState();
    _initSlider();
  }

  /// Таймер перелистывания
  void _initSlider() {
    Timer.periodic(
        Duration(seconds: 3),
        (timer) => {
              if (_pageController.page != 2)
                _pageController.nextPage(
                  curve: Curves.fastLinearToSlowEaseIn,
                  duration: Duration(milliseconds: 500),
                )
              else
                timer.cancel()
            });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [_isLast ? const SizedBox.shrink() : const _SkipButton()],
      ),
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 300,
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (i) {
                    if (i == 2)
                      setState(() => _isLast = true);
                    else
                      setState(() => _isLast = false);
                  },
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: onboardList.length,
                  itemBuilder: (context, index) {
                    final item = onboardList[index];
                    return _OnBoardWidget(
                      title: item.title,
                      description: item.description,
                      icPath: item.iconPath,
                    );
                  },
                ),
              ),
              const SizedBox(height: 117),
              const _SlideIndicator(),
            ],
          ),
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: _isLast ? const _StartButton() : const SizedBox.shrink(),
          ),
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: _isLast ? const _StartButton() : const SizedBox.shrink(),
          )
        ],
      ),
    );
  }
}

/// Кнопка пропустить
class _SkipButton extends StatelessWidget {
  const _SkipButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      child: Text(
        skipText,
        style: textSubtitle1.copyWith(
          color: colorLightGreen,
        ),
      ),
      onPressed: () => Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => MainScreen()),
          (route) => false),
    );
  }
}

/// Элемент слайдера
class _OnBoardWidget extends StatelessWidget {
  const _OnBoardWidget({
    Key key,
    this.title,
    this.description,
    this.icPath,
  }) : super(key: key);

  final String title, description, icPath;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 250,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              icPath,
              color: Theme.of(context).accentColor,
            ),
            const SizedBox(height: 42),
            Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .headline5
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              description,
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .bodyText2
                  .copyWith(color: colorDarkSecondary2),
            ),
          ],
        ),
      ),
    );
  }
}

/// Индикатор перелистывания
class _SlideIndicator extends StatelessWidget {
  const _SlideIndicator({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 56,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            height: 8,
            width: 8,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: colorLightGreen,
            ),
          ),
          Container(
            height: 8,
            width: 8,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: colorLightGreen,
            ),
          ),
          Container(
            height: 8,
            width: 8,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: colorLightGreen,
            ),
          )
        ],
      ),
    );
  }
}

/// Кнопка "НА СТАРТ"
class _StartButton extends StatelessWidget {
  const _StartButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      width: double.infinity,
      child: ElevatedButton(
        child: Text(
          startText,
        ),
        onPressed: () => Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (BuildContext context) => MainScreen()),
            (route) => false),
      ),
    );
  }
}
