import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/domain/theme.dart';
import 'package:places/ui/res/assets.dart';
import 'package:places/ui/res/colors.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Настройки"),
        ),
        body: ListView(
          children: [
            ListTile(
              title: Text(
                "Темная тема",
                style: Theme.of(context).textTheme.subtitle1,
              ),
              trailing: CupertinoSwitch(
                value: themeModel.isDark,
                onChanged: (val) =>
                    setState(() => themeModel.changeTheme = val),
              ),
            ),
            separator(),
            ListTile(
              title: Text(
                "Смотреть туториал",
                style: Theme.of(context).textTheme.subtitle1,
              ),
              trailing: SvgPicture.asset(
                icInfo,
                color: themeModel.isDark ? colorDarkGreen : colorLightGreen,
              ),
              onTap: () {},
            ),
            separator(),
          ],
        ));
  }

  Widget separator() => Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Divider(
          height: 0.2,
          color: colorInnactiveBlack,
        ),
      );
}
