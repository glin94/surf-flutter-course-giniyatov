import 'package:places/data/interactor/api_client.dart';
import 'package:places/data/model/place.dart';
import 'package:places/util/const.dart';

class PlaceRepository {
  ApiClient _apiClient = ApiClient();

  Future<List<dynamic>> fetchPlaces() async {
    final places = await _apiClient.get(placeEndpoint);
    return places.map((json) => Place.fromJson(json)).toList();
  }

  Future<dynamic> fetchPlaceById(String id) async {
    print(Uri.parse(placeEndpoint + id).path);
    final place = await _apiClient.get(Uri.parse(placeEndpoint + id).path);
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
