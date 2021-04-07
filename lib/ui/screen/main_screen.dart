import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/ui/res/assets.dart';
import 'package:places/ui/res/strings/common_strings.dart';
import 'package:places/ui/screen/filters_screen.dart';
import 'package:places/ui/screen/settings_screens.dart';
import 'package:places/ui/screen/sight_list_screen.dart';
import 'package:places/ui/screen/visiting_screen.dart';

/// Главный экран
class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  static List<Widget> _screens = <Widget>[
    const SightListScreen(),
    Container(),
    VisitingScreen(),
    SettingsScreen(),
  ];

  void _onItemTapped(int index) => setState(() => _selectedIndex = index);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              icList,
              color: Theme.of(context).iconTheme.color,
            ),
            activeIcon: SvgPicture.asset(
              icListFilled,
              color: Theme.of(context).iconTheme.color,
            ),
            label: sightListScreenTitle,
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              icMap,
              color: Theme.of(context).iconTheme.color,
            ),
            activeIcon: SvgPicture.asset(
              icMapFilled,
              color: Theme.of(context).iconTheme.color,
            ),
            label: mapScreeenTitle,
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              icHeart,
              color: Theme.of(context).iconTheme.color,
            ),
            activeIcon: SvgPicture.asset(
              icHeartFilled,
              color: Theme.of(context).iconTheme.color,
            ),
            label: favoriteScreenTitle,
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              icSettings,
              color: Theme.of(context).iconTheme.color,
            ),
            activeIcon: SvgPicture.asset(
              icSettingsFilled,
              color: Theme.of(context).iconTheme.color,
            ),
            label: settingsScreenTitle,
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
