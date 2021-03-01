import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/common/widgets/empty_places_screen.dart';
import 'package:places/ui/common/widgets/sight_card.dart';
import 'package:places/ui/res/assets.dart';
import 'package:places/ui/res/strings/common_strings.dart';

/// Экран "Посетил"
class VisitedTab extends StatefulWidget {
  @override
  _VisitedTabState createState() => _VisitedTabState();
}

class _VisitedTabState extends State<VisitedTab> {
  List<Sight> visitedList =
      mocks.where((element) => element.isAchieved).toList();

  @override
  Widget build(BuildContext context) {
    return visitedList.isNotEmpty
        ? ListView(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 24,
            ),
            children: visitedList
                .map<Widget>(
                  (sight) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: SightCardVisited(
                      key: ValueKey(sight.name),
                      sight: sight,
                      onDelete: () => setState(() => visitedList.remove(sight)),
                    ),
                  ),
                )
                .toList(),
          )
        : const EmptyPlacesScreen(
            iconsAssetText: icGO,
            header: "Пусто",
            text: visitedPlacesEmptyText,
          );
  }
}
