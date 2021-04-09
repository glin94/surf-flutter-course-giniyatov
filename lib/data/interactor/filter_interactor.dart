import 'dart:async';

import 'package:flutter/material.dart';
import 'package:places/data/model/sight.dart';
import 'package:places/mocks.dart';
import 'package:places/util/const.dart';
import 'package:places/util/location_functions.dart';

///  Фильтр
class FilterInteractor {
  StreamController<List<Sight>> _sightsController =
      StreamController<List<Sight>>.broadcast();

  StreamController<List<Map>> _filtersController =
      StreamController<List<Map>>.broadcast();

  StreamController<RangeValues> _rangeValuesController =
      StreamController<RangeValues>.broadcast();

  Stream<List<Sight>> get sightsStream => _sightsController.stream;

  Stream<List<Map>> get filtersStream => _filtersController.stream;

  List<Map> get filterValues => categoryValues;

  Stream<RangeValues> get rangeValuesStream => _rangeValuesController.stream;

  RangeValues get rangeValues => _rangeValues;

  RangeValues _rangeValues = RangeValues(
    minDistanceM,
    maxDistanceM,
  );

  ///  Фильтрованный список мест
  List<Sight> get filterSights => mocks
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
        (sight) =>
            filterValues.where((category) => category["isTicked"]).toList().any(
                  (item) =>
                      sight.type.toLowerCase() == item['name'].toLowerCase(),
                ),
      )
      .toList();

  ///Выбор категории
  set choiceFilterItem(Map item) {
    item["isTicked"] = !item["isTicked"];
    _filtersController.add(filterValues);
    _sightsController.add(filterSights);
  }

  ///Очистка фильтра
  void clear() {
    filterValues.forEach(
      (item) => item["isTicked"] = false,
    );
    _filtersController.add(filterValues);
    _sightsController.add(filterSights);
  }

  ///Изменение значения слайдера
  set rangeValuesChange(RangeValues values) {
    _rangeValues = values;
    _rangeValuesController.add(rangeValues);
    _sightsController.add(filterSights);
  }
}
