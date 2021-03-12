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
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) =>
            <Widget>[
          innerBoxIsScrolled
              ? const SliverAppBar(
                  title: Text(sightListScreenTitle),
                  pinned: true,
                  elevation: 0,
                )
              : const _LargeAppBar(),
        ],
        body: StreamBuilder<List<Sight>>(
            initialData: mocks,
            stream: sightInteractor.sightListStream,
            builder: (context, snapshot) {
              final sightList = snapshot.data;
              return CustomScrollView(
                slivers: <Widget>[
                  SliverAppBar(
                    elevation: 0,
                    primary: false,
                    title: GestureDetector(
                      onTap: () =>
                          Navigator.of(context).push(CupertinoPageRoute(
                        builder: (context) => SightSearchScreen(),
                      )),
                      child: const SearchBar(
                        enable: false,
                      ),
                    ),
                  ),
                  CupertinoSliverRefreshControl(
                    onRefresh: () async {
                      await Future.delayed(Duration(seconds: 2));
                    },
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 24,
                    ),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12),
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
      ),
    );
  }
}

class _LargeAppBar extends StatelessWidget {
  const _LargeAppBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      elevation: 0,
      centerTitle: false,
      toolbarHeight: 120,
      title: Text(
        sightListScreenTitle.replaceFirst(" ", "\n"),
        maxLines: 2,
        textAlign: TextAlign.left,
        style: Theme.of(context).textTheme.headline4,
      ),
    );
  }
}
