import 'dart:convert';
import 'dart:io' as io;

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:webvinfast/api/api_service.dart';
import 'package:webvinfast/models/product_model.dart';
import 'package:flutter/foundation.dart' show Uint8List, kIsWeb;

import 'package:universal_html/html.dart' as html;

class MainViewModel extends ChangeNotifier {
  final ApiService _apiService;
  final List<TestCar> _testCars = [];
  // final List<Product> _product = [];

  final List<Product> _products = [];
  List<Product> get products => _products;
  MainViewModel(this._apiService);

  List<TestCar> get getTestCars => _testCars;

  Future<List<TestCar>> getTestCarsByType(int type) async {
    try {
      // Gọi API để lấy dữ liệu
      final response = await _apiService.getTestCarsByType({'type': type});
      final responseData = response.data;

      if (response.statusCode == 200 && responseData['errCode'] == 0) {
        print("Response Data: $responseData");

        // Phân tích dữ liệu thành danh sách TestCar
        final List<dynamic> dataList = responseData['data'];
        final List<TestCar> testCars =
            dataList.map((json) => TestCar.fromJson(json)).toList();

        return testCars;
      } else {
        throw Exception(
            responseData['message'] ?? 'Không thể lấy danh sách xe thử');
      }
    } catch (e) {
      throw Exception('Lỗi: $e');
    }
  }

  Future<Product> fetchProductById(int id) async {
    try {
      final response = await _apiService.getProductById({'id': id});
      final responseData = response.data;

      if (response.statusCode == 200) {
        print("Response Data: $responseData");

        if (responseData is Map<String, dynamic> &&
            responseData.containsKey('data')) {
          final productJson = responseData['data'];
          return Product.fromJson(productJson);
        } else {
          throw Exception(responseData['message'] ??
              'Dữ liệu sản phẩm không có trong phản hồi');
        }
      } else {
        throw Exception(
            responseData['message'] ?? 'Không thể lấy được sản phẩm');
      }
    } catch (e) {
      throw Exception('Lỗi: $e');
    }
  }

  Future<List<Product>> getAllProducts() async {
    try {
      // Gọi API để lấy dữ liệu sản phẩm
      final response = await _apiService.getProduct();
      final responseData = response.data;

      if (response.statusCode == 200 && responseData['errCode'] == 0) {
        print("Response Data: $responseData");

        // Phân tích dữ liệu thành danh sách Product
        final List<dynamic> dataList = responseData['data'];
        final List<Product> products =
            dataList.map((json) => Product.fromJson(json)).toList();

        return products;
      } else {
        throw Exception(
            responseData['message'] ?? 'Không thể lấy danh sách sản phẩm');
      }
    } catch (e) {
      throw Exception('Lỗi: $e');
    }
  }

  Future<void> exportExcel(List<Map<String, dynamic>> data) async {
    try {
      print('Sending data: $data'); // Log dữ liệu gửi đi
      var response = await _apiService.exportExcel(data);
      print('Response status: ${response.statusCode}'); // Log status code

      if (response.statusCode == 200) {
        if (kIsWeb) {
          // Xử lý cho nền tảng web
          downloadFileWeb(response.data);
        } else {
          // Xử lý cho nền tảng di động
          var status = await Permission.storage.request();
          if (status.isGranted) {
            // Sử dụng FilePicker để chọn tệp đích
            String? filePath = await FilePicker.platform.saveFile(
              dialogTitle: 'Chọn nơi lưu trữ tệp',
              fileName: 'data.xlsx',
              type: FileType.custom,
              allowedExtensions: ['xlsx'],
            );

            if (filePath != null) {
              var file = io.File(filePath);
              await file.writeAsBytes(response.data);
              print('File downloaded: ${file.path}');
            } else {
              print('No file selected');
            }
          } else {
            print('Permission denied');
          }
        }
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  void downloadFileWeb(Uint8List data) {
    final content = base64Encode(data);
    final anchor = html.AnchorElement(
      href: 'data:application/octet-stream;base64,$content',
    )
      ..setAttribute('download', 'data.xlsx')
      ..click();
  }

  Future<Response> login(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      throw Exception('Vui lòng điền đầy đủ thông tin');
    }

    try {
      final response = await _apiService.login({
        'email': email,
        'password': password,
      });

      final responseData = response.data;

      if (response.statusCode == 200 && responseData['errCode'] == 0) {
        return response;
      } else {
        throw Exception(
            responseData['message'] ?? 'Đăng nhập không thành công');
      }
    } catch (e) {
      throw Exception('Lỗi: $e');
    }
  }

  Future<Response> newTestCar(String name, String numberPhone, String Email,
      String nameCar, String note, String type) async {
    if (name.isEmpty || numberPhone.isEmpty) {
      throw Exception('Vui lòng điền đầy đủ thông tin');
    }

    try {
      final response = await _apiService.newTestCar({
        'name': name,
        'numberPhone': numberPhone,
        'Email': Email,
        'nameCar': nameCar,
        'note': note,
        'type': 0
      });

      final responseData = response.data;

      if (response.statusCode == 200 && responseData['errCode'] == 0) {
        return response;
      } else {
        throw Exception(responseData['message'] ?? 'Không thể tạo xe thử');
      }
    } catch (e) {
      throw Exception('Lỗi: $e');
    }
  }
}

class TestCar {
  final int id;
  final String? name;
  final String? numberPhone;
  final String? email;
  final String? nameCar;
  final String note;
  final int type;
  final DateTime createdAt;
  final DateTime updatedAt;

  TestCar({
    required this.id,
    this.name,
    this.numberPhone,
    this.email,
    this.nameCar,
    required this.note,
    required this.type,
    required this.createdAt,
    required this.updatedAt,
  });

  factory TestCar.fromJson(Map<String, dynamic> json) {
    return TestCar(
      id: json['id'],
      name: json['name'],
      numberPhone: json['number_phone'],
      email: json['email'],
      nameCar: json['name_car'],
      note: json['note'],
      type: json['type'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'number_phone': numberPhone,
      'email': email,
      'name_car': nameCar,
      'note': note,
      'type': type,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
