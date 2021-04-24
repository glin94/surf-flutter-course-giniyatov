import 'package:dio/dio.dart';
import 'package:places/util/const.dart';

class ApiClient {
  final _timeOut = Duration(milliseconds: 5000);

  Dio _dio;
  ApiClient() {
    _dio = Dio(
      BaseOptions(
        responseType: ResponseType.json,
        baseUrl: baseURL,
        connectTimeout: _timeOut.inMilliseconds,
        receiveTimeout: _timeOut.inMilliseconds,
        sendTimeout: _timeOut.inMilliseconds,
      ),
    );
    _dio.interceptors.add(
      InterceptorsWrapper(
        onError: (e) => print("Error: $e"),
        onRequest: (options) => print("Запрос отправляется"),
        onResponse: (options) => print("Ответ получен"),
      ),
    );
  }
  Future<dynamic> get(String endpoint) async {
    final response = await _dio.get(endpoint);
    return (_checkStatus(response)).data;
  }

  void delete(String endpoint) async {
    final response = await _dio.delete(endpoint);
    print(_checkStatus(response).data);
  }

  void put(String endpoint, Map<String, dynamic> data) async {
    final response = await _dio.put(
      endpoint,
      data: data,
    );
    print(_checkStatus(response).data);
  }

  Future<dynamic> post(String endpoint, Map<String, dynamic> data) async {
    final response = await _dio.post(
      endpoint,
      data: data,
    );
    return (_checkStatus(response).data);
  }

  Response _checkStatus(Response response) {
    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception("Request error. Error code: ${response.statusCode}");
    }
  }
}
