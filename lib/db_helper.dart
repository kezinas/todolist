import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:todolist/task.dart';

class DbHelper {
  static const int ver = 1;
  static const String dbName = 'Tasks.db';

  static Future<Database> getDb() async {
    return openDatabase(join(await getDatabasesPath(), dbName),
        onCreate: (db, version) async => await db.execute(
            'CREATE TABLE Tasks(id TEXT NOT NULL, text TEXT NOT NULL, importance TEXT NOT NULL, deadline TEXT, done TEXT NOT NULL, createdAt TEXT NOT NULL, changedAt TEXT NOT NULL, lastUpdatedBy TEXT NOT NULL);'),
        version: ver);
  }

  static Future<int> addTask(Task task) async {
    final db = await getDb();
    print(
        '${task.id} ${task.task} ${task.strDate()} ${task.importance ?? ' '} ${task.lastUpdatedBy}');
    return await db.insert('Tasks', task.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> updateTask(Task task) async {
    final db = await getDb();
    return await db.update('Tasks', task.toJson(),
        where: 'id = ?',
        whereArgs: [task.id],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> deleteTask(Task task) async {
    final db = await getDb();
    print(
        '${task.id} ${task.task} ${task.strDate()} ${task.importance ?? ' '}');
    return await db.delete('Tasks', where: 'id = ?', whereArgs: [task.id]);
  }

  static Future<List<Task>?> getAllTasks() async {
    final db = await getDb();
    final List<Map<String, dynamic>> maps = await db.query('Tasks');
    if (maps.isEmpty) {
      return null;
    }
    return List.generate(maps.length, (index) => Task.fromJson(maps[index]));
  }

  static Future<List<Task>?> getTask(String id) async {
    final db = await getDb();
    final List<Map<String, dynamic>> maps =
        await db.query('Tasks', where: 'id = ?', whereArgs: [id]);
    if (maps.isEmpty) {
      return null;
    }
    return List.generate(maps.length, (index) => Task.fromJson(maps[index]));
  }
}
