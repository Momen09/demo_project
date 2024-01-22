import 'dart:convert';
import 'package:demo_project/services/Network.dart';
import 'package:demo_project/constants/enum.dart';
import 'package:demo_project/model/todo_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../constants/K_Network.dart';

class TodoViewModel extends ChangeNotifier {
  ViewState _viewState = ViewState.initial;

  ViewState get viewState => _viewState;
  Dio dio = Dio();

  List<Todo> _todo = [];

  List<Todo> get todo => _todo;

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  Future<Todo> postTodo() async {
    _viewState = ViewState.loading;
    final String title = titleController.text ?? '';
    final String description = descriptionController.text ?? '';

    final response = await dio.post(
      KNetwork.postUrl,
      data: jsonEncode({
        'title': title,
        'description': description,
      }),
      options: (Options(
        headers: {
          'Content-Type': 'application/json',
        },
      )),
    );
    print('Response status code: ${response.statusCode}');
    print('Response body: ${response.data}');

    if (response.statusCode == 201) {
      Todo createdTodo = Todo.fromJson(json.decode(response.data));
      _viewState = ViewState.loaded;
      notifyListeners();
      return createdTodo;
    } else {
      _viewState = ViewState.error;
      notifyListeners();
      throw Exception('Unexpected response format');
    }
  }

  // Future<void> postTodo() async {
  //   try {
  //     _viewState = ViewState.loading;
  //     notifyListeners();
  //
  //     NetworkRequests apiService = NetworkRequests();
  //     await apiService.postNetworkTodos();
  //     _viewState = ViewState.loaded;
  //     notifyListeners();
  //   } catch (e) {
  //     _viewState = ViewState.error;
  //     notifyListeners();
  //     rethrow;
  //   }
  // }

  Future<List<Todo>> getTodos() async {
    _viewState = ViewState.loading;
    notifyListeners();
    NetworkRequests apiService = NetworkRequests();
    _todo = await apiService.fetchTodos();
    _viewState = ViewState.loaded;
    notifyListeners();
    return _todo;
  }

/*  Future<void> deleteTodo(int todoId) async {
    _viewState = ViewState.loading;
    notifyListeners();

    NetworkRequests apiService = NetworkRequests();

      Future<http.Response> deleteResponse = await apiService.deleteNetworkTodos();
        _todo.removeWhere((todo) => todo.id == todoId);
    _viewState = ViewState.loaded;
    notifyListeners();
  }*/
}
