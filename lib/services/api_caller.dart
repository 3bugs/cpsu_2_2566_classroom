import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ApiCaller {
  /**
   * อย่าลืมเปลี่ยน baseUrl ให้ตรงกับที่เราใช้งานจริง
   */
  static const baseUrl = 'http://localhost:3001';
  // static const baseUrl = 'http://192.168.1.39:3000';
  static final _dio = Dio(BaseOptions(responseType: ResponseType.plain));

  Future<String> get(String endpoint, {Map<String, dynamic>? params}) async {
    try {
      final response =
          await _dio.get('$baseUrl/$endpoint', queryParameters: params);
      debugPrint('Status code: ${response.statusCode}');
      debugPrint(response.data.toString());
      return response.data.toString();
    } catch (e) {
      if (e is DioException) {
        debugPrint(e.response?.data.toString());
        throw Exception(e.response?.data.toString());
      } else {
        rethrow;
      }
    }
  }

  Future<String> post(String endpoint,
      {required Map<String, dynamic>? params}) async {
    try {
      final response = await _dio.post('$baseUrl/$endpoint', data: params);
      debugPrint(response.data.toString());
      return response.data.toString();
    } catch (e) {
      if (e is DioException) {
        debugPrint(e.response?.data.toString());
        throw Exception(e.response?.data.toString());
      } else {
        rethrow;
      }
    }
  }
}
