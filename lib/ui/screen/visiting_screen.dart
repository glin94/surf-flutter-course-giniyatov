import 'package:flutter/material.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/data/model/place.dart';
import 'package:places/ui/common/widgets/empty_places_screen.dart';
import 'package:places/ui/common/widgets/place_card.dart';
import 'package:places/ui/res/assets.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/res/strings/common_strings.dart';
import 'package:places/ui/res/text_styles.dart';
import 'package:provider/provider.dart';

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
          favoriteScreenTitleText,
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
      body: Consumer<PlaceInteractor>(
        builder: (context, placeInteractor, child) =>
            StreamBuilder<List<Place>>(
          initialData: placeInteractor.favoritesList,
          stream: placeInteractor.getFavoritesPlaces(),
          builder: (context, snapshot) =>
              TabBarView(controller: _controller, children: <Widget>[
            _TabItem(
              placeList:
                  snapshot.data.where((place) => !place.isAchieved).toList(),
              emptyPlaceScreen: const EmptyPlaceScreen(
                iconsAssetText: icCamera,
                text: wantToVisitPlacesEmptyText,
                header: "Пусто",
              ),
            ),
            _TabItem(
              placeList:
                  snapshot.data.where((place) => place.isAchieved).toList(),
              emptyPlaceScreen: const EmptyPlaceScreen(
                iconsAssetText: icGO,
                header: "Пусто",
                text: visitedPlacesEmptyText,
              ),
            ),
          ]),
        ),
      ),
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
    this.placeList,
    this.emptyPlaceScreen,
  }) : super(key: key);

  final List<Place> placeList;

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
      final Place item = widget.placeList.removeAt(oldIndex);
      widget.placeList.insert(newIndex, item);
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.placeList.isNotEmpty
        ? ListView.builder(
            itemCount: widget.placeList.length,
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 24,
            ),
            itemBuilder: (context, index) {
              final Place place = widget.placeList[index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: DragTarget<Place>(
                  onWillAccept: (data) => data != place,
                  onAccept: (data) =>
                      _onReorder(widget.placeList.indexOf(data), index),
                  builder: (BuildContext context, List<dynamic> acceptedData,
                      List<dynamic> rejectedData) {
                    return DraggableCard(
                      place: place,
                      child: FavoritePlaceCard(
                        key: ValueKey(place),
                        place: place,
                        onDelete: () => context
                            .read<PlaceInteractor>()
                            .removeFromFavoritesList(place),
                      ),
                    );
                  },
                ),
              );
            })
        : widget.emptyPlaceScreen;
  }
}
