import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_project/model/todo_model.dart';

const String TODO_COLLECTION1_REF = 'todos';
const String TODO_COLLECTION2_REF = 'todos2';
const String TODO_COLLECTION3_REF = 'todos3';

class DataBaseService {
  final _firestore = FirebaseFirestore.instance;

  get firestore => _firestore;
  late final CollectionReference _todosRef;

  DataBaseService(collection) {
    _todosRef = _firestore.collection(collection).withConverter<Todo>(
        fromFirestore: (snapshot, _) => Todo.fromJson(snapshot.data()!),
        toFirestore: (todo, _) => todo.toJson());
    print(_todosRef);
  }

  Stream<List<Todo>> getTodoss() {
    return _todosRef.snapshots().map((querySnapshot) {
      return querySnapshot.docs.map((doc) {
        return doc.data() as Todo;
      }).toList();
    });
  }

  void addTodo(Todo todo) async {
    _todosRef.add(todo);
  }

  CollectionReference get todosRef => _todosRef;
}

class Firebasee {
  Stream<List<Todo>> getTodos1() {
    return DataBaseService(TODO_COLLECTION1_REF).getTodoss();
  }

  void addTodo1(Todo todo) async {
    DataBaseService(TODO_COLLECTION1_REF).addTodo(todo);
  }

  Stream<List<Todo>> getTodoss2() {
    return DataBaseService(TODO_COLLECTION2_REF).getTodoss();
  }

  void addTodo2(Todo todo) async {
    return DataBaseService(TODO_COLLECTION2_REF).addTodo(todo);
  }

  Stream<List<Todo>> getTodoss3() {
    return DataBaseService(TODO_COLLECTION3_REF).getTodoss();
  }

  void addTodo3(Todo todo) async {
    return DataBaseService(TODO_COLLECTION3_REF).addTodo(todo);
  }
}
