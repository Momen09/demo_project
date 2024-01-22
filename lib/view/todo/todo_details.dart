import 'package:demo_project/services/Network.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../viewmodel/TodoViewModel.dart';

class TodoDetails extends StatefulWidget {
  const TodoDetails({Key? key}) : super(key: key);
  static const routeName = 'TodoDetails';

  @override
  State<TodoDetails> createState() => _TodoDetailsState();
}

class _TodoDetailsState extends State<TodoDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<TodoViewModel>(
          builder: (context, todoViewModel, child) {
            return ListView(
              padding: const EdgeInsets.all(10),
              children: [
                TextField(
                  controller: todoViewModel.titleController,
                  decoration: const InputDecoration(hintText: 'title'),
                ),
                TextField(
                  controller: todoViewModel.descriptionController,
                  decoration: const InputDecoration(hintText: 'description'),
                  keyboardType: TextInputType.multiline,
                  minLines: 5,
                  maxLines: 8,
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    todoViewModel.postTodo();
                    Navigator.pop(context);
                  },
                  child: const Text('Submit'),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
