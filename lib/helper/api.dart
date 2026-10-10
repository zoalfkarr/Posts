import 'dart:developer';

import 'package:dio/dio.dart';

class Api {
  final Dio _dio = Dio();

  /// Get
  Future<dynamic> get({required String url, String? token}) async {
    Map<String, dynamic> headers = {};

    if (token != null) {
      headers.addAll({"Connection": "keep-alive $token"});
    }

    try {
      Response response = await _dio.get(
        url,
        options: Options(headers: headers),
      );

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception(
          "there is a problem with status code ${response.statusCode}",
        );
      }
    } on DioException catch (e) {
      throw Exception(
        "there is a problem with status code ${e.response?.statusCode} with body ${e.response?.data}",
      );
    }
  }

  /// Post
  Future<dynamic> post({
    required String url,
    dynamic body,
    String? token,
  }) async {
    Map<String, dynamic> headers = {};

    if (token != null) {
      headers.addAll({"Connection": "keep-alive $token"});
    }

    try {
      Response response = await _dio.post(
        url,
        data: body,
        options: Options(headers: headers),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      } else {
        throw Exception(
          "there is a problem with status code ${response.statusCode} with body ${response.data}",
        );
      }
    } on DioException catch (e) {
      throw Exception(
        "there is a problem with status code ${e.response?.statusCode} with body ${e.response?.data}",
      );
    }
  }

  /// Put
  Future<dynamic> put({
    required String url,
    dynamic body,
    String? token,
  }) async {
    Map<String, dynamic> headers = {};
    headers.addAll({"Content-Type": "application/x-www-form-urlencoded"});
    if (token != null) {
      headers.addAll({"Connection": "keep-alive $token"});
    }
    log("url = $url body = $body token= $token");

    try {
      Response response = await _dio.put(
        url,
        data: body,
        options: Options(headers: headers),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      } else {
        throw Exception(
          "there is a problem with status code ${response.statusCode} with body ${response.data}",
        );
      }
    } on DioException catch (e) {
      throw Exception(
        "there is a problem with status code ${e.response?.statusCode} with body ${e.response?.data}",
      );
    }
  }

  /// Delete
  Future<dynamic> delete({required String url, String? token}) async {
    Map<String, dynamic> headers = {};

    if (token != null) {
      headers.addAll({"Connection": "keep-alive $token"});
    }

    try {
      Response response = await _dio.delete(
        url,
        options: Options(headers: headers),
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        return response.data;
      } else {
        throw Exception(
          "there is a problem with status code ${response.statusCode}",
        );
      }
    } on DioException catch (e) {
      throw Exception(
        "there is a problem with status code ${e.response?.statusCode} with body ${e.response?.data}",
      );
    }
  }
}
