import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/common/widgets/empty_places_screen.dart';
import 'package:places/ui/common/widgets/sight_card.dart';
import 'package:places/ui/res/assets.dart';
import 'package:places/ui/res/strings/common_strings.dart';

/// Экран "Хочу посетить"
class WantToVisitTab extends StatefulWidget {
  @override
  _WantToVisitTabState createState() => _WantToVisitTabState();
}

class _WantToVisitTabState extends State<WantToVisitTab> {
  List<Sight> wantToVisitList =
      mocks.where((sight) => !sight.isAchieved).toList();
  @override
  Widget build(BuildContext context) {
    return wantToVisitList.isNotEmpty
        ? ListView(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 24,
            ),
            children: wantToVisitList
                .map<Widget>(
                  (sight) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: SightCardWanted(
                      key: ValueKey(sight.name),
                      sight: sight,
                      onDelete: () =>
                          setState(() => wantToVisitList.remove(sight)),
                    ),
                  ),
                )
                .toList(),
          )
        : const EmptyPlacesScreen(
            iconsAssetText: icCamera,
            text: wantToVisitPlacesEmptyText,
            header: "Пусто",
          );
  }
}
