import 'dart:async';
import 'package:places/data/interactor/common/exceptions.dart';
import 'package:places/data/model/place.dart';
import 'package:places/data/repository/place_repository.dart';

/// Интерактор взаимодействия с инересными местами
class PlaceInteractor {
  PlaceInteractor(this._placeRepository) {
    getPlaces().then((list) => placesController.sink.add(list), onError: (e) {
      if (e is NetworkException) {
        placesController.sink.addError(e);
      }
    });
  }
  PlaceRepository _placeRepository;

  List<Place> favoritesList = List<Place>();

  StreamController<List<Place>> _favoritesListController =
      StreamController.broadcast();

  StreamController<List<Place>> placesController = StreamController.broadcast();

  Stream<List<Place>> get placeStream => placesController.stream;

  Stream<List<Place>> get favoriteListStream => _favoritesListController.stream;

  Future<List<Place>> getPlaces() async {
    final list = await _placeRepository.fetchPlaces();
    return list.cast<Place>();
  }

  Future<Place> getPlaceDetails(int id) async {
    return await _placeRepository.fetchPlaceById(id.toString());
  }

  Stream<List<Place>> getFavoritesPlaces() {
    favoritesList.sort((a, b) => a.distance.compareTo(b.distance));
    _favoritesListController.add(favoritesList);
    return favoriteListStream;
  }

  void addToFavoriteList(Place place) {
    favoritesList.add(place);
    _favoritesListController.add(favoritesList);
  }

  void removeFromFavoritesList(Place place) {
    favoritesList.removeWhere((item) => place.id == item.id);
    _favoritesListController.add(favoritesList);
  }

  List<Place> getVisitPlaces() {
    return favoritesList.where((place) => place.isAchieved == true).toList();
  }

  void addToVisitingPlaces(Place place) {}

  void addNew(Place place) => _placeRepository.putPlace(place);

  void dispose() {
    placesController.close();
    _favoritesListController.close();
  }
}
