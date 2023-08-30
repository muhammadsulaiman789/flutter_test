import 'package:dio/dio.dart';

import 'logging_interceptor.dart';

abstract class BaseApiProvider {
  late Dio dio;

  BaseApiProvider() {
    dio = Dio();
    dio.options.baseUrl = baseUrl();
    dio.interceptors.add(LoggingInterceptors());
  }

  String baseUrl();

  Options dioOptions(String token, {String userSourceId = ''}) {
    return Options(
      sendTimeout: const Duration(milliseconds: 5000),
      receiveTimeout: const Duration(milliseconds: 5000),
      headers: userSourceId == ''
          ? {
              'content-Type': 'application/json',
              "Authorization": 'Bearer $token',
            }
          : {
              'content-Type': 'application/json',
              'User-Source-Id': userSourceId
            },
    );
  }
}
