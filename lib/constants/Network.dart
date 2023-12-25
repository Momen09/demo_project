import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'K_Network.dart';
class NetworkRequests{
 static Future<Response> DioNetwork() async {
  final Dio dio = Dio();
  const url = ApiUrl.apiUrl;
      ///Cache_Manager
  DioCacheManager dioCacheManager = DioCacheManager(CacheConfig());
  Options myOptions = buildCacheOptions(const Duration(days: 2),forceRefresh: true,);
  dio.interceptors.add(dioCacheManager.interceptor);
  try {
    final response = await dio.get(
      url,
      options:
      myOptions.copyWith(
        headers: {
          'content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${KNetwork.token}',
        },
      ),
    );
    log('API Response: $response');
    if (response.statusCode == 200) {
      log('API Response: ${response.data}');
    } else if (response.statusCode == 401) {
      log('API Error: Unauthorized (401)');
    } else {

      log('API Error: Status Code ${response.statusCode}');
    }
    return response;
  }
  catch (e){

    log('Error making API request: $e');
    throw e;
  }
}
}