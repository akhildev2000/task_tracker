// provider.dart
import 'package:flutter/material.dart';

import '../models/task.dart';
import 'main_model_provider.dart';

class TaskProvider with ChangeNotifier {
  final MainModel _mainModel = MainModel();

  TaskProvider() {
    _mainModel.loadTasks();
  }

  List<Task> get tasks => _mainModel.tasks;

  Future<void> addTask(Task task) async {
    await _mainModel.addTask(task);
  }

  Future<void> updateTask(Task task) async {
    await _mainModel.updateTask(task);
  }

  Future<void> deleteTask(Task task) async {
    await _mainModel.deleteTask(task);
  }
}
