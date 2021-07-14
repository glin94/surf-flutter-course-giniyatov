import 'package:places/data/model/place.dart';
import 'package:places/data/repository/api_client.dart';
import 'package:places/util/const.dart';

class PlaceRepository {
  PlaceRepository(this._apiClient);

  final ApiClient _apiClient;

  Future<List<Place>> fetchPlaces() async {
    final places = await _apiClient.get(placeEndpoint);
    return List<Place>.from(
        places.map((json) => Place.fromJson(json)).toList());
  }

  Future<Place> fetchPlaceById(String id) async {
    final place = await _apiClient.get("$placeEndpoint/$id");
    return Place.fromJson(place);
  }

  void deletePlaceById(String id) {
    _apiClient.delete(Uri.parse(placeEndpoint + id).path);
  }

  void putPlace(Place place) async {
    _apiClient.put(
      "$placeEndpoint/${place.id}",
      place.toJson(),
    );
  }
}
