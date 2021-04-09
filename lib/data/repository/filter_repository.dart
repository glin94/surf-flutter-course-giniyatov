import 'dart:async';
import 'package:places/data/model/place.dart';
import 'package:places/data/repository/place_repository.dart';
import 'package:places/mocks.dart';

///Фильтр
class FilterRepository {
  Future<List<dynamic>> filteredPlaces(
    double radius,
    List<PlaceType> types,
    String textValue,
  ) async {
    initInterceptor();
    final response = await dio.post("/filtered_places", data: {
      "lat": location["lat"],
      "lng": location["lon"],
      "radius": radius,
      "typeFilter": types.map((item) => Place.placeTypeToString(item)).toList(),
    });
    if (response.statusCode == 200) {
      final places = await response.data;
      print("$textValue: ${places.toString()}");
      return places.map((json) => Place.fromJson(json)).toList();
    } else
      throw Exception("Request error. Error code: ${response.statusCode}");
  }
}
