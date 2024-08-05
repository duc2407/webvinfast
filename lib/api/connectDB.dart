import 'package:dio/dio.dart';

class Api {
  final Dio dio = Dio();

  Api() {
    dio.interceptors
        .add(LogInterceptor(responseBody: true)); // Bật log response body
  }

  Future<Response> sendRequest(String method, String path,
      {Map<String, dynamic>? data}) async {
    try {
      Response response;

      switch (method.toUpperCase()) {
        case 'GET':
          response = await dio.get(path);
          break;
        case 'POST':
          response = await dio.post(path, data: data);
          break;
        case 'PUT':
          response = await dio.put(path, data: data);
          break;
        case 'DELETE':
          response = await dio.delete(path, data: data);
          break;
        // Thêm các phương thức khác nếu cần

        default:
          throw Exception('Unsupported HTTP method: $method');
      }

      return response;
    } catch (error) {
      throw Exception('Failed to send request: $error');
    }
  }
}
