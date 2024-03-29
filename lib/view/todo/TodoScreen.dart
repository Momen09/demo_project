import 'package:demo_project/services/database_service.dart';
import 'package:demo_project/view/todo/todo1.dart';
import 'package:demo_project/view/todo/todo2.dart';
import 'package:demo_project/view/todo/todo3.dart';
import 'package:demo_project/view/todo/todo_details.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constants/enum.dart';
import '../../model/todo_model.dart';
import '../../viewmodel/TodoViewModel.dart';
import '../loading_screen.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({Key? key}) : super(key: key);
  static const routeName = 'TodoScreen';

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final List<Widget> _screens = [
    const Todo1(),
    const Todo2(),
    const Todo3(),
  ];
  int _currentIndex = 0;
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      Provider.of<TodoViewModel>(context, listen: false).getTodo(context);
      // Provider.of<TodoViewModel>(context, listen: false).postTodo();
      // Provider.of<TodoViewModel>(context, listen: false).deleteTodo();
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(context, TodoDetails.routeName);
        },
        label: const Text('Add Todo'),
      ),
      appBar: AppBar(
        title: const Text('Todo List'),
      ),
      body: Consumer<TodoViewModel>(
        builder: (context, todoList, child) {
          if (todoList.viewState == ViewState.loading ||
              todoList.viewState == ViewState.initial) {
            return const LoadingScreen();
          }
          if (todoList.viewState == ViewState.loaded) {
            return ListView.builder(
                itemCount: todoList.todo.length,
                itemBuilder: (context, index) {
                  print(todoList.todo[index].title);
                  final todoItem = todoList.todo[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.grey,
                      ),
                      child: ListTile(
                          leading: CircleAvatar(child: Text('${index + 1}')),
                          title: Text(todoItem.title),
                          subtitle: Text(todoItem.description),
                          trailing: PopupMenuButton(
                            itemBuilder: (context) {
                              return [
                                const PopupMenuItem(
                                  value: 'delete',
                                  child: Text('Delete'),
                                ),
                              ];
                            },
                            onSelected: (String value) {
                              if (value == 'delete') {
                                todoList.deleteTodo(todoItem.id);
                              }
                            },
                          )),
                    ),
                  );
                },
            );
          }
          return Container();
        },
      ),
    );
    //   return Scaffold(
    //     body: _screens[_currentIndex],
    //     bottomNavigationBar: BottomNavigationBar(
    //       currentIndex: _currentIndex,
    //       onTap: (index) {
    //         setState(() {
    //           _currentIndex = index;
    //         });
    //       },
    //       items:  [
    //         buildBottomNavigationBarItem(Icons.add,'Todo1'),
    //         buildBottomNavigationBarItem(Icons.account_circle_sharp,'Todo2'),
    //         buildBottomNavigationBarItem(Icons.ac_unit_rounded,'Todo3'),
    //       ],
    //     ),
    //   );
    // }

    BottomNavigationBarItem buildBottomNavigationBarItem(icon, title) {
      return BottomNavigationBarItem(
        icon: Icon(icon),
        label: title,
      );
    }
  }
}
