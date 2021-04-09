import 'package:dio/dio.dart';

PlaceRepository placeRepository = PlaceRepository();

class PlaceRepository {
  Dio dio = Dio(BaseOptions(
    baseUrl: "https://jsonplaceholder.typicode.com",
    connectTimeout: 5000,
    receiveTimeout: 5000,
    sendTimeout: 5000,
    responseType: ResponseType.json,
  ));

  void getTestUsers() async {
    initInterceptor();
    final response = await dio.get("/users");
    if (response.statusCode == 200)
      print(response.data.toString());
    else
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
