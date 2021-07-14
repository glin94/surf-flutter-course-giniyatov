import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mobx/mobx.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/data/model/place.dart';
import 'package:places/ui/common/widgets/add_new_place_button.dart';
import 'package:places/ui/common/widgets/place_card.dart';
import 'package:places/ui/common/widgets/search_bar.dart';
import 'package:places/ui/common/widgets/waiting_indicator.dart';
import 'package:places/ui/res/strings/common_strings.dart';
import 'package:places/ui/screen/filters_screen.dart';
import 'package:places/ui/screen/search_place_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:places/store/places_store/places_store.dart';

/// Экран отображения списка интересных мест
class PlaceListScreen extends StatefulWidget {
  const PlaceListScreen({Key key}) : super(key: key);

  @override
  _PlaceListScreenState createState() => _PlaceListScreenState();
}

class _PlaceListScreenState extends State<PlaceListScreen> {
  PlacesStore _store;

  @override
  void initState() {
    super.initState();
    _store = context.read<PlacesStore>();
    _store.getPlaces();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: const AddNewPlaceButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          slivers: <Widget>[
            MediaQuery.of(context).orientation == Orientation.portrait
                ? SliverPadding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    sliver: SliverPersistentHeader(
                      pinned: true,
                      delegate: _AppBarPersistentHeaderDelegate(
                        MediaQuery.of(context).size.height / 8.5,
                        MediaQuery.of(context).size.height / kToolbarHeight * 2,
                      ),
                    ),
                  )
                : SliverAppBar(
                    centerTitle: false,
                    automaticallyImplyLeading: false,
                    title: Text(placeListScreenTitleText),
                  ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 18,
              ),
              sliver: SliverToBoxAdapter(
                child: GestureDetector(
                  onTap: () => Navigator.of(context).push(
                    CupertinoPageRoute(
                      builder: (context) => SearchPlacesScreen(),
                    ),
                  ),
                  child: SearchBar(
                    enable: false,
                    onFilterTap: () async {
                      final filterPlaces =
                          await Navigator.of(context).push<List<Place>>(
                        CupertinoPageRoute(
                          builder: (context) => FiltersScreen(),
                        ),
                      );
                      context
                          .read<PlaceInteractor>()
                          .placesController
                          .add(filterPlaces);
                    },
                  ),
                ),
              ),
            ),
            SliverPadding(
                padding: const EdgeInsets.all(16),
                sliver: SliverToBoxAdapter(
                  child: Observer(
                    builder: (BuildContext context) {
                      return _store.getPlacesFuture.status ==
                              FutureStatus.pending
                          ? const WaitingIndicator()
                          : _PlacesGrid(places: _store.getPlacesFuture.value);
                    },
                  ),
                )

                // StreamBuilder<List<dynamic>>(
                //   stream: context.read<PlaceInteractor>().placeStream,
                //   builder: (context, snapshot) {
                //     if (snapshot.hasData) {
                //       final placeList = snapshot.data.cast<Place>();
                //       if (placeList.isEmpty) {
                //         return Container();
                //       } else
                //         return _PlacesGrid(places: placeList);
                //     } else if (snapshot.hasError) {
                //       return const ErrorScreen();
                //     } else
                //       return const WaitingIndicator();
                //   },
                // ),
                // ),
                ),
          ],
        ),
      ),
    );
  }
}

/// Сетка для интресных мест
class _PlacesGrid extends StatelessWidget {
  const _PlacesGrid({
    Key key,
    this.places,
  }) : super(key: key);

  final List<Place> places;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (c, i) => PlaceCard(place: places[i]),
      itemCount: places.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisSpacing: 24,
        childAspectRatio: 1.5,
        mainAxisSpacing: 16,
        crossAxisCount:
            MediaQuery.of(context).orientation == Orientation.portrait ? 1 : 2,
      ),
    );
  }
}

/// Делегат для AppBar
class _AppBarPersistentHeaderDelegate extends SliverPersistentHeaderDelegate {
  _AppBarPersistentHeaderDelegate(
    this.expandedHeight,
    this.titlePaddingTop,
  );

  final double expandedHeight;

  final double titlePaddingTop;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return AppBar(
      toolbarHeight: expandedHeight,
      titleSpacing: 0,
      centerTitle: !(expandedHeight - minExtent > shrinkOffset),
      title: expandedHeight - minExtent > shrinkOffset
          ? Text(
              placeListScreenTitleText.replaceFirst(" ", "\n"),
              style: Theme.of(context).textTheme.headline4,
            )
          : Text(placeListScreenTitleText),
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => expandedHeight - titlePaddingTop;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
