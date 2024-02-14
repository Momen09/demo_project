import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import '../constants/K_Network.dart';

class NetworkRequests {
  static Future<Response> DioNetwork() async {
    final Dio dio = Dio();
    const url = ApiUrl.apiUrl;

    ///Cache_Manager
    DioCacheManager dioCacheManager = DioCacheManager(CacheConfig());
    Options myOptions = buildCacheOptions(
      const Duration(days: 2),
      forceRefresh: true,
    );
    dio.interceptors.add(dioCacheManager.interceptor);
    try {
      final response = await dio.get(
        url,
        options: myOptions.copyWith(
          headers: {
            'content-type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${KNetwork.token}',
          },
        ),
      );
      if (response.statusCode == 200) {
      } else if (response.statusCode == 401) {
      } else {}
      return response;
    } catch (e) {
      throw e;
    }
  }
}
