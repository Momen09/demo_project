import 'package:demo_project/services/errors/dio_exceptions.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../constants/K_Network.dart';
import '../../constants/enum.dart';

class Api {
  final dio = createDio();

  Api._internal();

  static final _singleton = Api._internal();

  factory Api() => _singleton;

  static Dio createDio() {
    var dio = Dio(BaseOptions(
      receiveTimeout: 20000, // 20 seconds
      connectTimeout: 20000,
      sendTimeout: 20000,
    ));

    return dio;
  }

  Options options = Options(headers: header);

  Future<Response> apiCall(String url, Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? body, RequestType requestType) async {
    try {
      switch (requestType) {
        case RequestType.GET:
          {
            return await dio.get(url,
                queryParameters: queryParameters, options: options);
          }
        case RequestType.POST:
          return await dio.post(url, options: options, data: body);
        case RequestType.DELETE:
          return await dio.delete(url, options: options, data: body);
      }
    } on ApiException catch (error) {
      throw ApiException.fromDioError(DioError(
        error: error.toString(),
        requestOptions: RequestOptions(path: url),
      ));
    }
  }
}

final Map<String, String> header = {
  'Content-type': 'application/json',
  'Accept': 'application/json',
  // 'Authorization': "bearer ${KNetwork.token}"
};
