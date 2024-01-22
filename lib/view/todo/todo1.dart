import 'package:flutter/material.dart';

import '../../model/todo_model.dart';
import '../../services/database_service.dart';
import '../loading_screen.dart';

class Todo1 extends StatefulWidget {
  const Todo1({super.key});

  @override
  State<Todo1> createState() => _Todo1State();
}

class _Todo1State extends State<Todo1> {
  @override
  final Firebasee _firebase = Firebasee();
  final TextEditingController _titleTextEditingController =
  TextEditingController();
  final TextEditingController _descriptionTextEditingController =
  TextEditingController();

  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _addTodo(context),
      appBar: AppBar(
        backgroundColor: Colors.grey,
        centerTitle: true,
        title: const Text('Todo 1'),
      ),
      body: SizedBox(
          height: MediaQuery.of(context).size.height * 0.80,
          width: MediaQuery.of(context).size.width,
          child: _getTodo()),
    );
  }

  Widget _getTodo() {
    return StreamBuilder<List<Todo>>(
      stream: _firebase.getTodos1(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: LoadingScreen());
        } else if (snapshot.hasError) {
          return const Center(child: Text('Error loading data.'));
        } else if (snapshot.data == null || snapshot.data!.isEmpty) {
          return const Center(child: Text('Add todo'));
        } else {
          List<Todo> todos = snapshot.data!;
          return ListView.builder(
            itemCount: todos.length,
            itemBuilder: (context, index) {
              Todo todo = todos[index];
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.grey),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.grey.shade600,
                      child: Text(
                        '${index + 1}',
                      ),
                    ),
                    title: Text(todo.title),
                    subtitle: Text(todo.description),
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }

  Widget _addTodo(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Add a todo'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: _titleTextEditingController,
                    decoration: const InputDecoration(labelText: 'Title'),
                  ),
                  TextField(
                    controller: _descriptionTextEditingController,
                    decoration: const InputDecoration(labelText: 'Description'),
                  ),
                ],
              ),
              actions: [
                MaterialButton(
                  onPressed: () {
                    String title = _titleTextEditingController.text;
                    String description = _descriptionTextEditingController.text;

                    if (title.isNotEmpty && description.isNotEmpty) {
                      _firebase.addTodo1(Todo(
                        title: title,
                        description: description,
                        isCompleted: false,
                      ));

                      Navigator.pop(context);
                      _titleTextEditingController.clear();
                      _descriptionTextEditingController.clear();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            backgroundColor: Colors.green,
                            content: Text('Todo added successfully!')),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          backgroundColor: Colors.red,
                          content:
                          Text('Please enter both title and description.'),
                        ),
                      );
                    }
                  },
                  color: Theme.of(context).colorScheme.primary,
                  child: const Text('Add'),
                ),
              ],
            );
          },
        );
      },
      child: const Icon(Icons.plus_one_outlined),
    );
  }
}
