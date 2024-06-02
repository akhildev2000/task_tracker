import 'package:flutter/material.dart';
import '../models/task.dart';
import 'db_services.dart';

class MainModel extends ChangeNotifier {
  List<Task> _tasks = [];

  List<Task> get tasks => _tasks;

  Future<void> loadTasks() async {
    final tasks = await DbService().getTasks();
    _tasks = tasks;
    notifyListeners();
  }

  Future<void> addTask(Task task) async {
    await DbService().addTask(task);
    notifyListeners();
  }

  Future<void> updateTask(Task task) async {
    await DbService().updateTask(task);
    notifyListeners();
  }

  Future<void> deleteTask(Task task) async {
    await DbService().deleteTask(task);
    notifyListeners();
  }

  Future<void> searchTasks(String query) async {
    final results = await DbService().searchTasks(title: query);
    _tasks = results;
    notifyListeners();
  }
}
