// core/services/dio_provider.dart
import 'package:dio/dio.dart';
import 'package:islami/core/services/dio_endpoints.dart';

class DioProvider {
  static late Dio _dio;

  static init() {
    _dio = Dio(BaseOptions(
      baseUrl: DioEndPoints.baseUrl,
    ));
  }

  static Future<Response> get(
      {String? endpoint, Map<String, dynamic>? data}) async {
    return await _dio.get(endpoint!, data: data);
  }
}
