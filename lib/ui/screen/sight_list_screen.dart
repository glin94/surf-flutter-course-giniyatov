import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:places/data/interactor/new_sight_interactor.dart';
import 'package:places/data/model/sight.dart';
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
            return SafeArea(
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
                              MediaQuery.of(context).size.height /
                                  kToolbarHeight *
                                  2,
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
                    sliver: SliverGrid(
                      delegate: SliverChildBuilderDelegate(
                        (c, i) => SightCard(sight: sightList[i]),
                        childCount: sightList.length,
                      ),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisSpacing: 24,
                        childAspectRatio: 1.5,
                        mainAxisSpacing: 16,
                        crossAxisCount: MediaQuery.of(context).orientation ==
                                Orientation.portrait
                            ? 1
                            : 2,
                      ),
                    ),
                  ),
                ],
              ),
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
