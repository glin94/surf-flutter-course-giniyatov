import 'dart:async';

import 'package:flutter/material.dart';
import 'package:places/data/model/place.dart';
import 'package:places/data/repository/place_repository.dart';
import 'package:places/ui/res/assets.dart';
import 'package:places/util/const.dart';

final filterRepository = FilterRepository();

///Фильтр
class FilterRepository {
  final List<Map<String, dynamic>> categoryValues = [
    {
      "name": "Отель",
      "type": PlaceType.hotel,
      "iconText": icBed,
      "isTicked": false,
    },
    {
      "name": "Ресторан",
      "type": PlaceType.restaurant,
      "iconText": icEda,
      "isTicked": false,
    },
    {
      "name": "Особое место",
      "type": PlaceType.other,
      "iconText": icStar,
      "isTicked": false,
    },
    {
      "name": "Парк",
      "type": PlaceType.park,
      "iconText": icTree,
      "isTicked": false,
    },
    {
      "name": "Музей",
      "type": PlaceType.museum,
      "iconText": icMuseum,
      "isTicked": false,
    },
    {
      "name": "Кафе",
      "type": PlaceType.cafe,
      "iconText": icCafes,
      "isTicked": false,
    },
  ];
  PlaceRepository _placeRepository = PlaceRepository();

  StreamController<List<Place>> _placesController =
      StreamController<List<Place>>.broadcast();

  StreamController<List<Map>> _filtersController =
      StreamController<List<Map>>.broadcast();

  StreamController<RangeValues> _rangeValuesController =
      StreamController<RangeValues>.broadcast();

  Stream<List<Place>> get placesStream => _placesController.stream;

  Stream<List<Map>> get filtersStream => _filtersController.stream;

  List<Map> get filterValues => categoryValues;

  Stream<RangeValues> get rangeValuesStream => _rangeValuesController.stream;

  RangeValues get rangeValues => _rangeValues;

  RangeValues _rangeValues = RangeValues(
    minDistanceM,
    maxDistanceM,
  );

  List<PlaceType> get selectedTypes => filterValues
      .where((value) => value["isTicked"] == true)
      .toList()
      .map((category) => category["type"])
      .toSet()
      .cast<PlaceType>()
      .toList();

  ///Фильтрованный список мест
  Future<List<Place>> get filterPlaces async {
    final list = await _placeRepository.fetchPlacesByRadiusAndCategory(
        _rangeValues.end, selectedTypes);
    return list.cast<Place>();
  }

  ///Выбор категории
  void choiceFilterItem(Map item) async {
    item["isTicked"] = !item["isTicked"];
    _filtersController.add(filterValues);
    _placesController.add(await filterPlaces);
  }

  ///Очистка фильтра
  void clear() async {
    filterValues.forEach(
      (item) => item["isTicked"] = false,
    );
    _filtersController.add(filterValues);
    _placesController.add(await filterPlaces);
  }

  ///Изменение значения слайдера
  void rangeValuesChange(RangeValues values) async {
    _rangeValues = values;
    _rangeValuesController.add(rangeValues);
    _placesController.add(await filterPlaces);
  }
}
