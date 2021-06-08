import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/data/interactor/settings_interactor.dart';
import 'package:places/ui/common/widgets/separator.dart';
import 'package:places/ui/res/assets.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/res/strings/common_strings.dart';
import 'package:places/ui/screen/onboarding_screen.dart';
import 'package:provider/provider.dart';

/// Экран настроек
class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(settingsScreenTitle),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Consumer<SettingsInteractor>(
          builder: (context, settingsInteractor, child) => Column(
            children: [
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  darkModeSwitcherText,
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                trailing: CupertinoSwitch(
                  value: settingsInteractor.isDark,
                  onChanged: (val) =>
                      setState(() => settingsInteractor.changeTheme = val),
                ),
              ),
              const Separator(),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  tutorialViewText,
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                trailing: SvgPicture.asset(
                  icInfo,
                  color: settingsInteractor.isDark
                      ? colorDarkGreen
                      : colorLightGreen,
                ),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OnBoardingScreen(),
                  ),
                ),
              ),
              const Separator(),
            ],
          ),
        ),
      ),
    );
  }
}
