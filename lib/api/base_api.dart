import 'package:dio/dio.dart';

class BaseApi {
  final Dio dio;
  final String baseUrl;

  BaseApi(this.dio, this.baseUrl);

  Future<Response> get(String path, {Map<String, dynamic>? params}) async {
    return await dio.get('$baseUrl$path', queryParameters: params);
  }

  Future<Response> post(String path, {dynamic data, options}) async {
    return await dio.post('$baseUrl$path', data: data, options: options);
  }

  Future<Response> put(String path, {Map<String, dynamic>? data}) async {
    return await dio.put('$baseUrl$path', data: data);
  }

  Future<Response> delete(String path, {Map<String, dynamic>? data}) async {
    return await dio.delete('$baseUrl$path', data: data);
  }
}
