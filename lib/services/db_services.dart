import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;
import '../models/task.dart';

class DbService {
  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    final databasePath = await getDatabasesPath();
    const databaseName = 'task_tracker.db';
    final databasePathFull = path.join(databasePath, databaseName);

    return await openDatabase(
      databasePathFull,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE tasks (
        id INTEGER PRIMARY KEY,
        title TEXT,
        description TEXT,
        comments TEXT,
        employeeId TEXT,
        isComplete INTEGER
      )
    ''');
  }

  Future<List<Task>> getTasks() async {
    final db = await database;
    final tasks = await db!.query('tasks');
    return tasks
        .map((task) => Task(
              id: task['id'].toString(),
              title: task['title'].toString(),
              description: task['description'].toString(),
              employeeId: task['employeeId'].toString(),
              comments: task['comments'].toString(),
              isComplete: task['isComplete'] == 1,
            ))
        .toList();
  }

  Future<void> addTask(Task task) async {
    final db = await database;
    await db!.insert('tasks', task.toMap());
    //print(task.description);
  }

  Future<void> updateTask(Task task) async {
    final db = await database;
    await db!
        .update('tasks', task.toMap(), where: 'id = ?', whereArgs: [task.id]);
    //print(task.comments);
  }

  Future<void> deleteTask(Task task) async {
    final db = await database;
    await db!.delete('tasks', where: 'id = ?', whereArgs: [task.id]);
    //print('task deleted');
  }

  // Search tasks by title, description, and employeeId
  Future<List<Task>> searchTasks({
    String? title,
    String? description,
    String? employeeId,
  }) async {
    final db = await database;
    List<String> whereClauses = [];
    List<dynamic> whereArgs = [];

    if (title != null && title.isNotEmpty) {
      whereClauses.add("title LIKE ?");
      whereArgs.add('%$title%');
    }
    if (description != null && description.isNotEmpty) {
      whereClauses.add("description LIKE ?");
      whereArgs.add('%$description%');
    }
    if (employeeId != null && employeeId.isNotEmpty) {
      whereClauses.add("employeeId = ?");
      whereArgs.add(employeeId);
    }

    final whereString =
        whereClauses.isNotEmpty ? whereClauses.join(" AND ") : null;
    final tasks = await db!.query(
      'tasks',
      where: whereString,
      whereArgs: whereArgs,
    );

    return tasks
        .map((task) => Task(
              id: task['id'].toString(),
              title: task['title'].toString(),
              description: task['description'].toString(),
              employeeId: task['employeeId'].toString(),
              comments: task['comments'].toString(),
              isComplete: task['isComplete'] == 1,
            ))
        .toList();
  }
}
