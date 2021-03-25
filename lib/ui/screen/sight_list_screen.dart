import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:places/domain/sight.dart';
import 'package:places/interactor/filter/new_sight_interactor.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/common/widgets/add_sight_button.dart';
import 'package:places/ui/common/widgets/search_bar.dart';
import 'package:places/ui/common/widgets/sight_card.dart';
import 'package:places/ui/res/strings/common_strings.dart';
import 'package:places/ui/screen/sight_search_screen.dart';

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
      body: StreamBuilder<List<Sight>>(
          initialData: mocks,
          stream: sightInteractor.sightListStream,
          builder: (context, snapshot) {
            final sightList = snapshot.data;
            return CustomScrollView(
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              slivers: <Widget>[
                SliverPadding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  sliver: SliverPersistentHeader(
                    pinned: true,
                    delegate: _AppBarPersistentHeaderDelegate(
                      130,
                      MediaQuery.of(context).size.height / kToolbarHeight * 2,
                    ),
                  ),
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
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 24),
                          child: SightCard(sight: sightList[index]),
                        );
                      },
                      childCount: sightList.length,
                    ),
                  ),
                ),
              ],
            );
          }),
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
