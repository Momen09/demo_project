import 'package:demo_project/constants/enum.dart';
import 'package:demo_project/model/todo_model.dart';
import 'package:demo_project/services/errors/dio_exceptions.dart';
import 'package:demo_project/services/services/base_Network.dart';
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

  Future<Response> deleteTodo(String todoId) async {
    try {
      _viewState = ViewState.loading;
      final response = await Api().apiCall(
        '${KNetwork.deleteUrl}$todoId',
        null,
        null,
        RequestType.DELETE,
      );
      _viewState = ViewState.loaded;
      _todo.removeWhere((element) => element.id == todoId);

      // _todo.where((element) => )
      notifyListeners();
      return response;
    } on DioError catch (e) {
      var error = ApiException.fromDioError(e);
      _viewState = ViewState.error;
      notifyListeners();
      throw error.errorMessage;
    }
  }

  Future<Todo> postTodo() async {
    _viewState = ViewState.loading;
    try {
      final String title = titleController.text ?? '';
      final String description = descriptionController.text ?? '';
      final response = await Api().apiCall(
        KNetwork.postUrl,
        null,
        {
          'title': title,
          'description': description,
        },
        RequestType.POST,
      );
      Todo createdTodo = Todo.fromJson(response.data["data"]);
      _todo.add(createdTodo);
      _viewState = ViewState.loaded;
      notifyListeners();
      return createdTodo;
    } on DioError catch (e) {
      _viewState = ViewState.error;
      notifyListeners();
      var error = ApiException.fromDioError(e);
      throw error.errorMessage;
    }
  }

  Future<List<Todo>?> getTodo(BuildContext context) async {
    _viewState = ViewState.loading;
    try {
      final response = await Api().apiCall(
        KNetwork.getUrl,
        null,
        null,
        RequestType.GET,
      );
      List<dynamic> todoData = response.data['items'];
      _todo = todoData.map((data) => Todo.fromJson(data)).toList();
      _viewState = ViewState.loaded;
      notifyListeners();
      return _todo;
    } on DioError catch (e) {
      _viewState = ViewState.error;
      notifyListeners();

      var error = ApiException.fromDioError(e);
      print(error.errorMessage);
      _showErrorDialog(error.errorMessage, context);
    }
  }
  void _showErrorDialog(String errorMessage,BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Error'),
        content: Text(errorMessage),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context); // Close the dialog
            },
            child: Text('OK'),
          ),
        ],
      );
    },
    );
  }
}


