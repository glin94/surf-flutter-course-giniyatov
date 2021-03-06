import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/common/widgets/empty_places_screen.dart';
import 'package:places/ui/res/assets.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/res/strings/common_strings.dart';
import 'package:places/ui/res/text_styles.dart';
import 'package:places/ui/common/widgets/sight_card.dart';

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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          favoriteScreenTitle,
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(52),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 6,
            ),
            child: _TabBarWidget(
              selectedIndex: _selectedIndex,
            ),
          ),
        ),
      ),
      body: TabBarView(controller: _controller, children: <Widget>[
        _TabItem(
          sightList: mocks.where((sight) => !sight.isAchieved).toList(),
          emptyPlaceScreen: const EmptyPlaceScreen(
            iconsAssetText: icCamera,
            text: wantToVisitPlacesEmptyText,
            header: "Пусто",
          ),
        ),
        _TabItem(
          sightList: mocks.where((sight) => sight.isAchieved).toList(),
          emptyPlaceScreen: const EmptyPlaceScreen(
            iconsAssetText: icGO,
            header: "Пусто",
            text: visitedPlacesEmptyText,
          ),
        ),
      ]),
    );
  }
}

///Заголовок для экранов "Хочу посетить/Посещенные места"
class _TabBarWidget extends StatelessWidget {
  const _TabBarWidget({
    Key key,
    @required int selectedIndex,
  })  : _selectedIndex = selectedIndex,
        super(key: key);

  final int _selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColorDark,
        borderRadius: BorderRadius.circular(40),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              child: Center(
                child: Text(
                  wantToVisitTitle,
                  style: textBody1.copyWith(
                    color: _selectedIndex == 0
                        ? Theme.of(context).backgroundColor
                        : colorInnactiveBlack,
                  ),
                ),
              ),
              decoration: _selectedIndex == 0
                  ? BoxDecoration(
                      color: Theme.of(context).secondaryHeaderColor,
                      borderRadius: BorderRadius.circular(40),
                    )
                  : const BoxDecoration(),
            ),
          ),
          Expanded(
            child: Container(
              decoration: _selectedIndex == 1
                  ? BoxDecoration(
                      color: Theme.of(context).secondaryHeaderColor,
                      borderRadius: BorderRadius.circular(40),
                    )
                  : const BoxDecoration(),
              child: Center(
                child: Text(
                  visitedTitle,
                  style: textBody1.copyWith(
                    color: _selectedIndex == 1
                        ? Theme.of(context).backgroundColor
                        : colorInnactiveBlack,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

///Таб для экранов "Хочу посетить/Посещенные места"
class _TabItem extends StatefulWidget {
  const _TabItem({
    Key key,
    this.sightList,
    this.emptyPlaceScreen,
  }) : super(key: key);

  final List<Sight> sightList;

  final EmptyPlaceScreen emptyPlaceScreen;

  @override
  _TabItemState createState() => _TabItemState();
}

class _TabItemState extends State<_TabItem> {
  void _onReorder(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) {
        newIndex -= 1;
      }
      final Sight item = widget.sightList.removeAt(oldIndex);
      widget.sightList.insert(newIndex, item);
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.sightList.isNotEmpty
        ? ListView.builder(
            itemCount: widget.sightList.length,
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 24,
            ),
            itemBuilder: (context, index) {
              final Sight sight = widget.sightList[index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: DragTarget<Sight>(
                  onWillAccept: (data) => data != sight,
                  onAccept: (data) =>
                      _onReorder(widget.sightList.indexOf(data), index),
                  builder: (BuildContext context, List<dynamic> acceptedData,
                      List<dynamic> rejectedData) {
                    return DraggableCard(
                      sight: sight,
                      child: FavoriteSightCard(
                        key: ValueKey(sight),
                        sight: sight,
                        onDelete: () => setState(
                          () => widget.sightList.removeAt(index),
                        ),
                      ),
                    );
                  },
                ),
              );
            })
        : widget.emptyPlaceScreen;
  }
}
