import 'dart:async';
import 'package:places/data/model/place.dart';
import 'package:places/data/repository/filter_repository.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/screen/filters_screen.dart';

///  Поиск
class SearchInteractor {
  ///  Set для того, чтобы значения не повторялись
  final _wordsList = Set<String>();

  final _sightListController = StreamController<List<Place>>.broadcast();
  final _wordsListController = StreamController<List<String>>.broadcast();

  Stream<List<Place>> get sightListStream => _sightListController.stream;
  Stream<List<String>> get wordsListStream => _wordsListController.stream;

  void search(String text) async {
    if (text.isNotEmpty) {
      final list = await _doSearch(text);
      _sightListController.sink.add(list);
      if (list.isNotEmpty) {
        saveSearchHistory(text);
      }
    }
  }

  ///  Поиск отфильтрованого места с задержкой 4 сек
  Future<List<Place>> _doSearch(String value) async => Future.delayed(
      Duration(seconds: 4),
      () => mocks
          .where((sight) =>
              sight.name.toLowerCase().contains(value.toLowerCase().trim()))
          .toList());

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
