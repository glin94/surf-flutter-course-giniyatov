import 'dart:async';
import 'package:flutter/material.dart';
import 'package:places/data/model/place.dart';
import 'package:places/data/repository/filter_repository.dart';
import 'package:places/mocks.dart';
import 'package:places/util/const.dart';

/// Поиск и фильтр
class SearchInteractor {
  SearchInteractor(this._filterRepository);

  final FilterRepository _filterRepository;

  List<Place> filterPlacesList = List<Place>();

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

  ///  Set для того, чтобы значения не повторялись
  final _wordsList = Set<String>();

  final _wordsListController = StreamController<List<String>>.broadcast();

  Stream<List<String>> get wordsListStream => _wordsListController.stream;

  List<PlaceType> get selectedTypes => filterValues
      .where((value) => value["isTicked"] == true)
      .map((category) => category["type"])
      .cast<PlaceType>()
      .toList();

  ///Фильтрованный список мест
  Future<List<Place>> get filterPlaces async {
    filterPlacesList = (await _filterRepository.filteredPlaces(
            _rangeValues.end, selectedTypes, ""))
        .cast<Place>();
    return filterPlacesList;
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

  void searchPlaces(String text) async {
    if (text.isNotEmpty) {
      final list = await _doSearch(text);
      _placesController.add(list);
      if (list.isNotEmpty) {
        saveSearchHistory(text);
      }
    }
  }

  ///  Поиск отфильтрованого места с задержкой 4 сек
  Future<List<Place>> _doSearch(String value) async {
    await Future.delayed(Duration(seconds: 3));
    final _list = await _filterRepository.filteredPlaces(
      rangeValues.end,
      selectedTypes,
      value,
    );
    return _list.cast<Place>();
  }

  void removeHistorySearchItem(String text) {
    _wordsList.remove(text);
    _wordsListController.add(_wordsList.toList());
  }

  void removeAllHistorySearchItem() {
    _wordsList.clear();
    _wordsListController.add(_wordsList.toList());
  }

  void saveSearchHistory(String text) {
    _wordsList.add(text.trim());
    _wordsListController.sink.add(_wordsList.toList());
  }
}
