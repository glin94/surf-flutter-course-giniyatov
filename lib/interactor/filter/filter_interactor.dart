import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/mocks.dart';
import 'package:places/util/const.dart';
import 'package:places/util/location_functions.dart';

final filterInteractor = FilterInteractor();

///Интерактор для фильтра
class FilterInteractor extends ChangeNotifier {
  List<Sight> filterSights = List();

  RangeValues rangeValues = RangeValues(
    minDistanceM,
    maxDistanceM,
  );

  ///Функция фильтрации по дистанции и категории места
  void filter(List<Map> filterValues) {
    filterSights = mocks
        .where(
          (item) => arePointsNear(
            item,
            location,
            rangeValues.start / 1000,
            rangeValues.end / 1000,
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

    notifyListeners();
  }

  set rangeValuesChange(RangeValues values) {
    rangeValues = values;
    notifyListeners();
  }
}
