import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/domain/theme.dart';
import 'package:places/ui/common/widgets/separator.dart';
import 'package:places/ui/res/assets.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/res/strings/common_strings.dart';

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
        body: ListView(
          children: [
            ListTile(
              title: Text(
                darkModeSwitcherText,
                style: Theme.of(context).textTheme.subtitle1,
              ),
              trailing: CupertinoSwitch(
                value: themeModel.isDark,
                onChanged: (val) =>
                    setState(() => themeModel.changeTheme = val),
              ),
            ),
            const Separator(),
            ListTile(
              title: Text(
                tutorialViewText,
                style: Theme.of(context).textTheme.subtitle1,
              ),
              trailing: SvgPicture.asset(
                icInfo,
                color: themeModel.isDark ? colorDarkGreen : colorLightGreen,
              ),
              onTap: () {},
            ),
            const Separator()
          ],
        ));
  }
}
