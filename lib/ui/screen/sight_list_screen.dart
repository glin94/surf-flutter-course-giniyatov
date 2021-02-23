import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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
      appBar: AppBar(
        elevation: 0,
        title: Text(
          sightListScreenTitle,
        ),
      ),
      // PreferredSize(
      //   preferredSize: Size.fromHeight(100),
      //   child:
      //    AppBar(
      //     elevation: 0,
      //     centerTitle: false,
      //     toolbarHeight: 100,
      //     title: Text(
      //       sightListScreenTitle.replaceFirst(" ", "\n"),
      //       maxLines: 2,
      //       textAlign: TextAlign.left,
      //       style: Theme.of(context).textTheme.headline4,
      //     ),
      //   ),
      // ),
      floatingActionButton: const AddSightButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        child: Column(
          children: [
            GestureDetector(
              onTap: () => Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (c) => SightSearchScreen(),
                ),
              ),
              child: const SearchBar(
                enable: false,
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            StreamBuilder<List>(
                initialData: mocks,
                stream: sightInteractor.sightListStream,
                builder: (context, snapshot) {
                  return Column(
                    children: snapshot.data
                        .map(
                          (item) => Padding(
                            padding: const EdgeInsets.only(
                              bottom: 24,
                            ),
                            child: SightCard(
                              sight: item,
                            ),
                          ),
                        )
                        .toList(),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
