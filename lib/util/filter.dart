import 'package:places/mocks.dart';

import 'location_functions.dart';

///Функция фильтрации по дистанции и категории места
List filter(
        double minDistanceKm, double maxDistanceKm, List<Map> filterValues) =>
    mocks
        .where(
          (item) => arePointsNear(
            item,
            location,
            minDistanceKm,
            maxDistanceKm,
          ),
        )
        .toList()
        .where(
          (sight) => filterValues
              .where((category) => category["isTicked"])
              .toList()
              .any(
                (item) => sight.type == item['name'].toLowerCase(),
              ),
        )
        .toList();
