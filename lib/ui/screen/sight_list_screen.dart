import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/data/model/place.dart';
import 'package:places/ui/common/widgets/add_sight_button.dart';
import 'package:places/ui/common/widgets/search_bar.dart';
import 'package:places/ui/common/widgets/sight_card.dart';
import 'package:places/ui/common/widgets/waiting_indicator.dart';
import 'package:places/ui/res/strings/common_strings.dart';
import 'package:places/ui/screen/sight_search_screen.dart';
import 'package:places/util/const.dart';

/// Экран отображения списка интересных мест
class SightListScreen extends StatelessWidget {
  const SightListScreen({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: const AddSightButton(),
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
                    title: Text(sightListScreenTitle),
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
                      builder: (context) => SightSearchScreen(),
                    ),
                  ),
                  child: SearchBar(
                    enable: false,
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
              sliver: SliverToBoxAdapter(
                child: FutureBuilder<List<dynamic>>(
                  future: placeInteractor.getPlaces(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final sightList = snapshot.data;
                      if (sightList.isEmpty) {
                        return Container();
                      } else
                        return _PlacesGrid(
                          places: sightList.cast<Place>(),
                        );
                    } else if (snapshot.hasError) {
                      return const Center(
                        child: Icon(
                          Icons.error_outline,
                          color: Colors.red,
                          size: 60,
                        ),
                      );
                    } else
                      return const WaitingIndicator();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

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
      itemBuilder: (c, i) => SightCard(sight: places[i]),
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

///Делегат для AppBar
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
              sightListScreenTitle.replaceFirst(" ", "\n"),
              style: Theme.of(context).textTheme.headline4,
            )
          : Text(sightListScreenTitle),
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
