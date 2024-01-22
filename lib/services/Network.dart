import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import '../model/todo_model.dart';
import '../constants/K_Network.dart';
import 'errors/dio_exceptions.dart';

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
      try {
        await Api().apiCall('your_api_endpoint', null, null, RequestType.GET);
      } on DioExceptions catch (e) {
        print('DioException: ${e.toString()}');
      } catch (e) {
        print('Unhandled Exception: $e');
      }

      final response = await dio.get(
        ApiUrl.EndPoint,
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

  Future<List<Todo>> fetchTodos() async {
    final Dio dio = Dio();

    final response = await dio.get(
      KNetwork.getUrl,
    );
    if (response.statusCode == 200) {
      List<dynamic> todoList = response.data['items'];
      print(todoList);
      return todoList.map((json) => Todo.fromJson(json)).toList();
    } else {
      throw Exception(
          'Failed to fetch todos. Server responded with status code ${response.statusCode}');
    }
  }

// TextEditingController titleController = TextEditingController();
// TextEditingController descriptionController = TextEditingController();
// Future<Todo> postNetworkTodos()async{
//   final String title= titleController.text??'';
//   final String description= descriptionController.text??'';
//
//   final response = await http.post(
//     Uri.parse(KNetwork.postUrl),
//     headers: {
//       'Content-Type': 'application/json',
//     },
//     body: jsonEncode({
//       'title': title,
//       'description': description,
//     }),
//   );
//   print('Response body: ${response.body}');
//
//     Todo createdTodo = Todo.fromJson(json.decode(response.body));
//     return createdTodo;
// }
}

enum RequestType { GET, POST, DELETE }

class Api {
  final dio = createDio();

  Api._internal();

  static final _singleton = Api._internal();

  factory Api() => _singleton;

  static Dio createDio() {
    var dio = Dio(BaseOptions(
      baseUrl: ApiUrl.apiUrl,
      receiveTimeout: 20000, // 20 seconds
      connectTimeout: 20000,
      sendTimeout: 20000,
    ));

    return dio;
  }

  Future<void> apiCall(String url, Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? body, RequestType requestType) async {
    late Response result;
    try {
      switch (requestType) {
        case RequestType.GET:
          {
            DioCacheManager dioCacheManager = DioCacheManager(CacheConfig());
            Options myOptions = buildCacheOptions(
              const Duration(days: 2),
              forceRefresh: true,
            );
            dio.interceptors.add(dioCacheManager.interceptor);
            Options options = Options(headers: header);
            result = await dio.get(url,
                queryParameters: queryParameters, options: options);
            break;
          }
        case RequestType.POST:
          Options options = Options(headers: header);
          result = await dio.post(url,options: options,data: body);
        case RequestType.DELETE:
        // TODO: Handle this case.
      }
    } catch (error) {}
  }
}

final Map<String, String> header = {
  'Content-type': 'application/json',
  'Accept': 'application/json',
  'Authorization': "bearer ${KNetwork.token}"
};
