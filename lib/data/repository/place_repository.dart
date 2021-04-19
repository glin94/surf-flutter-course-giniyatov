import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:places/data/model/place.dart';
import 'package:places/mocks.dart';

class PlaceRepository {
  Dio dio = Dio(
    BaseOptions(
      baseUrl: "https://test-backend-flutter.surfstudio.ru",
      connectTimeout: 5000,
      receiveTimeout: 5000,
      sendTimeout: 5000,
      responseType: ResponseType.json,
    ),
  );

  Future<List<dynamic>> fetchPlaces() async {
    initInterceptor();
    final response = await dio.get("/place");
    if (response.statusCode == 200) {
      final places = await response.data;
      return places.map((json) => Place.fromJson(json)).toList();
    } else
      throw Exception("Request error. Error code: ${response.statusCode}");
  }

  Future<dynamic> fetchPlaceById(String id) async {
    initInterceptor();
    final response = await dio.get("/place/$id");
    if (response.statusCode == 200) {
      final place = await response.data;
      return Place.fromJson(place);
    } else
      throw Exception("Request error. Error code: ${response.statusCode}");
  }

  void deletePlaceById(String id) async {
    initInterceptor();
    final response = await dio.delete("/place/$id");
    if (response.statusCode == 200) {
      print("Object successfully deleted.");
    } else
      throw Exception("Request error. Error code: ${response.statusCode}");
  }

  Future<Place> putPlace(Place place) async {
    initInterceptor();
    final response =
        await dio.put("/place/${place.id}", data: json.encode(place.toJson()));
    if (response.statusCode == 200) {
      return Place.fromJson(response.data);
    } else if (response.statusCode == 409) {
      print("Object already exists");
      return place;
    } else
      throw Exception("Request error. Error code: ${response.statusCode}");
  }

  Future<List<dynamic>> fetchPlacesByRadiusAndCategory(
      double radius, List<PlaceType> types,
      {String textValue = ""}) async {
    initInterceptor();
    final response = await dio.post("/filtered_places", data: {
      "lat": location["lat"],
      "lng": location["lon"],
      "radius": radius,
      "typeFilter": types.map((item) => Place.placeTypeToString(item)).toList(),
      "nameFilter": textValue,
    });
    if (response.statusCode == 200) {
      final places = await response.data;
      return places.map((json) => Place.fromJson(json)).toList();
    } else
      throw Exception("Request error. Error code: ${response.statusCode}");
  }

  void initInterceptor() {
    dio.interceptors.add(
      InterceptorsWrapper(
        onError: (e) => print("Error: $e"),
        onRequest: (options) => print("Запрос отправляется"),
        onResponse: (options) => print("Ответ получен"),
      ),
    );
  }
}
