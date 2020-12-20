import 'package:flutter/material.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/res/text_styles.dart';
import 'package:places/ui/screen/tabs/visited_tab.dart';
import 'package:places/ui/screen/tabs/want_to_visit_tab.dart';

/// Экран "Хочу посетить/Посещенные места"
class VisitingScreen extends StatefulWidget {
  @override
  _VisitingScreenState createState() => _VisitingScreenState();
}

class _VisitingScreenState extends State<VisitingScreen>
    with SingleTickerProviderStateMixin {
  TabController _controller;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 2, vsync: this);
    _controller
        .addListener(() => setState(() => _selectedIndex = _controller.index));
    ;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        centerTitle: true,
        title: Text(
          "Избранное",
          style: textSubTitle.copyWith(
            color: colorLightMain,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(52),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 6,
            ),
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                color: Color(0xFFF5F5F5),
                borderRadius: BorderRadius.circular(40),
              ),
              child: _buildTabs(_selectedIndex),
            ),
          ),
        ),
      ),
      body: TabBarView(controller: _controller, children: <Widget>[
        const WantToVisitTab(),
        VisitedTab(),
      ]),
    );
  }

  Widget _buildTabs(int selectedIndex) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              child: Center(
                child: Text(
                  "Хочу посетить",
                  style: textSmallBold.copyWith(
                    color: _selectedIndex == 0
                        ? Colors.white
                        : colorInnactiveBlack,
                  ),
                ),
              ),
              decoration: _selectedIndex == 0
                  ? BoxDecoration(
                      color: colorLightSecondary,
                      borderRadius: BorderRadius.circular(40),
                    )
                  : const BoxDecoration(),
            ),
          ),
          Expanded(
            child: Container(
              decoration: _selectedIndex == 1
                  ? BoxDecoration(
                      color: colorLightSecondary,
                      borderRadius: BorderRadius.circular(40),
                    )
                  : const BoxDecoration(),
              child: Center(
                child: Text(
                  "Посетил",
                  style: textSmallBold.copyWith(
                    color: _selectedIndex == 1
                        ? Colors.white
                        : colorInnactiveBlack,
                  ),
                ),
              ),
            ),
          ),
        ],
      );
}
