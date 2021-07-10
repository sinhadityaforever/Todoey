import 'package:flutter/cupertino.dart';
import 'dart:collection';
import 'package:flutter/foundation.dart';
import 'package:todo/models/tasks.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TaskData extends ChangeNotifier {
  List<Task> _tasks = [];

  UnmodifiableListView<Task> get tasks {
    return UnmodifiableListView(_tasks);
  }

  void updateToDatabase(input) async {
    await http.patch(Uri.parse('http://192.168.56.1:5000/todos/$input'));
  }

  Future addToDatabase(input) async {
    await http.post(Uri.parse('http://192.168.56.1:5000/todos/'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({'description': '$input'}));
  }

  void deleteFromDatabase(input) async {
    await http.delete(Uri.parse('http://192.168.56.1:5000/todos/$input'));
  }

  Future fetchromDatabase() async {
    _tasks.clear();
    http.Response response =
        await http.get(Uri.parse('http://192.168.56.1:5000/todos/'));
    int numberOfTodo = jsonDecode(response.body).length;

    for (int i = 0; i < numberOfTodo; i++) {
      _tasks.add(Task(
          name: jsonDecode(response.body)[i]['description'],
          id: jsonDecode(response.body)[i]['todo_id'],
          isDone:
              jsonDecode(response.body)[i]['isdone'] == false ? false : true));
    }
    notifyListeners();
  }

  int get taskCount {
    return _tasks.length;
  }

  void addTask(input) async {
    final task = Task(name: input);
    _tasks.add(task);
    await addToDatabase(input);
    fetchromDatabase();
    // addedId = _tasks.last.id;
    notifyListeners();
  }

  void updateTask(Task task) {
    task.toggleDone();
    updateToDatabase(task.id);
    notifyListeners();
  }

  void deleteTask(Task task) {
    _tasks.remove(task);
    deleteFromDatabase(task.id);
    notifyListeners();
  }
} //We have to add notifylisteners to update the subscribers who are listening to this.
