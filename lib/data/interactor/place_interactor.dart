import 'dart:async';
import 'package:places/data/model/place.dart';
import 'package:places/data/repository/place_repository.dart';

PlaceInteractor placeInteractor = PlaceInteractor();

class PlaceInteractor {
  PlaceInteractor() {
    getPlaces().then((list) => placesController.add(list));
  }
  List<Place> favoritesList = List<Place>();

  StreamController<List<Place>> _favoritesListController =
      StreamController.broadcast();

  StreamController<List<Place>> placesController = StreamController.broadcast();

  Stream<List<Place>> get placeStream => placesController.stream;

  Stream<List<Place>> get favoriteListStream => _favoritesListController.stream;

  PlaceRepository _placeRepository = PlaceRepository();

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

  void addToFavoritesList(Place place) {
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
}
