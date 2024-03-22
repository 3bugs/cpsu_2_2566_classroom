import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../repositories/auth_repository.dart';

class ApiCaller {
  /**
   * อย่าลืมเปลี่ยน baseUrl ให้ตรงกับที่ใช้งานจริง
   */
  // static const baseUrl = 'http://localhost:3001';
  // static const baseUrl = 'http://192.168.1.39:3001';
  static const baseUrl = 'http://192.168.1.48:8000';
  static final _dio = Dio(BaseOptions(
    baseUrl: baseUrl,
    responseType: ResponseType.plain,
  ));

  Future<String> get(
    String endpoint, {
    Map<String, dynamic>? params,
    bool withToken = true,
  }) async {
    var token = await AuthRepository().token;

    try {
      final response = await _dio.get(
        endpoint,
        queryParameters: params,
        options: Options(
          headers: {
            if (withToken) "Authorization": "Bearer $token",
          },
        ),
      );
      debugPrint('Status code: ${response.statusCode}');
      debugPrint(response.data.toString());
      return response.data.toString();
    } on DioException catch (e) {
      debugPrint(e.toString());
      throw Exception(e.response?.data.toString());
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<String> post(
    String endpoint, {
    required Map<String, dynamic>? params,
    bool withToken = true,
  }) async {
    var token = await AuthRepository().token;

    try {
      final response = await _dio.post(
        endpoint,
        data: params,
        // options: Options(
        //   headers: {
        //     if (withToken) "Authorization": "Bearer $token",
        //   },
        // ),
      );
      debugPrint('Status code: ${response.statusCode}');
      debugPrint(response.data.toString());
      return response.data.toString();
    } on DioException catch (e) {
      debugPrint(e.toString());
      throw Exception(e.response?.data.toString());
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }
}
