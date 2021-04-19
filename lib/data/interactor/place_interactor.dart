import 'dart:async';
import 'package:places/data/model/place.dart';
import 'package:places/data/repository/place_repository.dart';

PlaceInteractor placeInteractor = PlaceInteractor();

class PlaceInteractor {
  List<Place> favoritesList = List<Place>();

  StreamController<List<Place>> favoritesListController =
      StreamController.broadcast();

  Stream<List<Place>> get favoriteListStream => favoritesListController.stream;

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
    favoritesListController.add(favoritesList);
    return favoriteListStream;
  }

  void addToFavorites(Place place) {
    favoritesList.add(place);
    favoritesListController.add(favoritesList);
  }

  void removeFromFavorites(Place place) {
    favoritesList.removeWhere((item) => place.id == item.id);
    favoritesListController.add(favoritesList);
  }

  List<Place> getVisitPlaces() {
    return favoritesList.where((place) => place.isAchieved == true).toList();
  }

  void addToVisitingPlaces(Place place) {}

  void addNew(Place place) => _placeRepository.putPlace(place);
}
