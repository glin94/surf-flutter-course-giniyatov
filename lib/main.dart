import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/res/assets.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/res/themes.dart';
import 'package:places/ui/screen/sight_details.dart';
import 'package:places/ui/screen/sight_list_screen.dart';
import 'package:places/ui/screen/visiting_screen.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: lightTheme,
      title: "SightApp",
      home: NavigationScreen(),
    );
  }
}

class NavigationScreen extends StatefulWidget {
  @override
  _NavigationScreenState createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int _selectedIndex = 0;

  static List<Widget> _screens = <Widget>[
    SightListScreen(),
    Container(
      child: Center(
        child: SvgPicture.asset(icMap),
      ),
    ),
    VisitingScreen(),
    Container(
      child: Center(
        child: SvgPicture.asset(icSettings),
      ),
    ),
  ];

  void _onItemTapped(int index) => setState(
        () => _selectedIndex = index,
      );

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
            label: "Cписок интересных мест",
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
            label: "Карта",
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
            label: "Избранное",
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
            label: "Настройки",
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
