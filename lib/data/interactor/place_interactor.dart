import 'package:places/data/model/place.dart';
import 'package:places/data/repository/filter_repository.dart';
import 'package:places/data/repository/place_repository.dart';
import 'package:places/util/const.dart';

PlaceInteractor placeInteractor = PlaceInteractor();

class PlaceInteractor {
  PlaceRepository _placeRepository = PlaceRepository();

  Future<List<Place>> getPlaces() async {
    final list = await _placeRepository.fetchPlacesByRadiusAndCategory(
        maxDistanceM, PlaceType.values.toList());
    return list.cast<Place>();
  }

  Future<Place> getPlace(String id) async {
    final place = await _placeRepository.fetchPlaceById(id);
    return place;
  }
}
