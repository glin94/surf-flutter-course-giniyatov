import 'package:flutter/material.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/data/model/place.dart';
import 'package:places/ui/common/widgets/empty_places_screen.dart';
import 'package:places/ui/common/widgets/place_card.dart';
import 'package:places/ui/res/assets.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/res/strings/common_strings.dart';
import 'package:provider/provider.dart';

/// Экран "Хочу посетить/Посещенные места"
class FavoritePlacesScreen extends StatefulWidget {
  @override
  _FavoritePlacesScreenState createState() => _FavoritePlacesScreenState();
}

class _FavoritePlacesScreenState extends State<FavoritePlacesScreen>
    with SingleTickerProviderStateMixin {
  TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          favoriteScreenTitleText,
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: _CustomTabBar(
              controller: _controller,
              tabs: const [
                Tab(text: wantToVisitTitle),
                Tab(text: visitedTitle),
              ],
            ),
          ),
          Expanded(
            child: Consumer<PlaceInteractor>(
              builder: (context, placeInteractor, child) =>
                  StreamBuilder<List<Place>>(
                initialData: placeInteractor.favoritesList,
                stream: placeInteractor.getFavoritesPlaces(),
                builder: (context, snapshot) =>
                    TabBarView(controller: _controller, children: <Widget>[
                  _TabItem(
                    placeList: snapshot.data
                        .where((place) => !place.isAchieved)
                        .toList(),
                    emptyPlaceScreen: const EmptyPlaceScreen(
                      iconsAssetText: icCamera,
                      text: wantToVisitPlacesEmptyText,
                      header: "Пусто",
                    ),
                  ),
                  _TabItem(
                    placeList: snapshot.data
                        .where((place) => place.isAchieved)
                        .toList(),
                    emptyPlaceScreen: const EmptyPlaceScreen(
                      iconsAssetText: icGO,
                      header: "Пусто",
                      text: visitedPlacesEmptyText,
                    ),
                  ),
                ]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Таб бар для экранов "Хочу посетить/Посещенные места"
class _CustomTabBar extends StatelessWidget {
  const _CustomTabBar({
    Key key,
    @required TabController controller,
    this.tabs,
  })  : _controller = controller,
        super(key: key);

  final TabController _controller;

  final List<Tab> tabs;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColorDark,
        borderRadius: BorderRadius.circular(25.0),
      ),
      child: TabBar(
        controller: _controller,
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(
            45,
          ),
          color: Theme.of(context).secondaryHeaderColor,
        ),
        labelColor: Theme.of(context).backgroundColor,
        unselectedLabelColor: colorInnactiveBlack,
        tabs: tabs,
      ),
    );
  }
}

/// Таб для экранов "Хочу посетить/Посещенные места"
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
