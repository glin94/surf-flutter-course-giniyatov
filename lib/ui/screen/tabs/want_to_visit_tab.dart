import 'package:flutter/material.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/common/widgets/empty_places_screen.dart';
import 'package:places/ui/common/widgets/sight_card.dart';
import 'package:places/ui/res/assets.dart';
import 'package:places/ui/res/strings/common_strings.dart';

/// Экран ""Хочу посетить"
class WantToVisitTab extends StatelessWidget {
  const WantToVisitTab({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return mocks.where((element) => !element.isAchieved).toList().isNotEmpty
        ? SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
            child: Column(
              children: mocks
                  .where((element) => !element.isAchieved)
                  .toList()
                  .map<Widget>(
                    (item) => Padding(
                      padding: const EdgeInsets.only(
                        bottom: 11,
                      ),
                      child: SightCardWantToVisit(item),
                    ),
                  )
                  .toList(),
            ),
          )
        : const EmptyPlacesScreen(
            iconsAssetText: icCamera,
            text: wantToVisitPlacesEmptyText,
          );
  }
}
