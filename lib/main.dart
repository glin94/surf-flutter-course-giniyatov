import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/ui/res/assets.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/screen/sight_list_screen.dart';
import 'package:places/ui/screen/visiting_screen.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "SightApp",
      home: BottomNavigation(),
    );
  }
}

class BottomNavigation extends StatefulWidget {
  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
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
        type: BottomNavigationBarType.fixed,
        fixedColor: colorLightSecondary,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: SvgPicture.asset(icList),
            label: "Список интересных мест",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(icMap),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(icHeart),
            label: "Хочу посетить/Посещенные места",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(icSettings),
            label: "",
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
