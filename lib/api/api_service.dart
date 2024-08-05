import 'package:dio/dio.dart';
import 'package:webvinfast/api/base_api.dart';
import 'package:webvinfast/api/base_url.dart';

class ApiService extends BaseApi {
  ApiService(Dio dio) : super(dio, BaseUrl.baseUrl) {
    // Cấu hình các interceptor của Dio ở đây
    dio.interceptors.add(
        LogInterceptor(responseBody: true)); // Ví dụ: Bật log response body
  }

  Future<Response> login(Map<String, dynamic> dataUser) {
    return post('/api/login', data: dataUser);
  }

  Future<Response> newTestCar(Map<String, dynamic> dataUser) {
    return post('/api/create-new-test-car', data: dataUser);
  }

  Future<Response> getTestCarsByType(Map<String, dynamic> data) {
    return post('/api/get-test-car', data: data);
  }

  Future<Response> getProduct() {
    return get('/api/get-product');
  }

  Future<Response> getProductById(Map<String, dynamic> data) {
    return post('/api/get-product-by-id', data: data);
  }

  Future<Response> exportExcel(List<Map<String, dynamic>> data) {
    return post(
      '/api/export-excel',
      data: data,
      options: Options(responseType: ResponseType.bytes),
    );
  }
  // Add more specific API methods as needed for your application
}
