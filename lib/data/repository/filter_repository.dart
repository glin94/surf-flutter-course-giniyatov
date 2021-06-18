import 'dart:async';
import 'package:places/data/interactor/api_client.dart';
import 'package:places/data/model/place.dart';
import 'package:places/mocks.dart';
import 'package:places/util/const.dart';

///Фильтр
class FilterRepository {
  const FilterRepository(this._apiClient);

  final ApiClient _apiClient;

  Future<List<dynamic>> filteredPlaces(
    double radius,
    List<PlaceType> types,
    String textValue,
  ) async {
    final places = await _apiClient.post(filterePlaceEndpoint, {
      "lat": location["lat"],
      "lng": location["lon"],
      "radius": radius,
      "typeFilter": types.map((item) => Place.placeTypeToString(item)).toList(),
    });
    return places.map((json) => Place.fromJson(json)).toList();
  }
}
