import 'package:dio/dio.dart';
import 'package:places/data/model/place.dart';

PlaceRepository placeRepository = PlaceRepository();

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
