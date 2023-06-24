/*import 'dart:convert';
import 'package:http/http.dart' as http;
import 'consts.dart';
import 'task.dart';

class Ftasks {
  Future<List<Task>> getList() async {
    const fullUri = '$baseUrl/list';
    final uri = Uri.parse(fullUri);
    try {
      final response =
          await http.get(uri, headers: {'Authorization': 'Bearer $token'});
      final result = jsonDecode(response.body);
      List<Task> n = (result['list'] as List<dynamic>)
          .map((e) => Task.fromUri(
              e['id'], e['text'], e['importance'], e['deadline'], e['done']))
          .toList();
      return n;
    } catch (error) {
      throw Error();
    }
  }

  Future<Task> getTask(String id) async {
    String fullUri = '$baseUrl/list/$id';
    final uri = Uri.parse(fullUri);
    try {
      final response =
          await http.get(uri, headers: {'Authorization': 'Bearer $token'});
      final result = jsonDecode(response.body);
      Task n = Task.fromUri(
          result['element']['id'],
          result['element']['text'],
          result['element']['importance'],
          result['element']['deadline'],
          result['element']['done']);
      return n;
    } catch (error) {
      throw Error();
    }
  }

  Future addTask(Task task) async {
    String fullUri = '$baseUrl/list';
    final uri = Uri.parse(fullUri);
    try {
      final response = await http.post(uri, body: {
        "status": "ok",
        "element": {
          "id": task.id, // уникальный идентификатор элемента
          "text": task.task,
          "importance": task.importance, // importance = low | basic | important
          "deadline": task.dated
              ? task.date
              : null, // int64, может отсутствовать, тогда нет
          "done": task.done,
          "color": null, // может отсутствовать
          "created_at": '',
          "changed_at": '',
          "last_updated_by": ''
        }
      }, headers: {
        'X-Last-Known-Revision': '<revision>',
        'Authorization': 'Bearer $token'
      });
    } catch (error) {}
  }

  Future<List<Task>> updateList() async {
    List<Task> n = [Task.newTask()];
    return n;
  }

  Future changeTask(Task task) async {
    String fullUri = '$baseUrl/list/${task.id}';
    final uri = Uri.parse(fullUri);
    try {
      final response = await http.put(uri, body: {
        "status": "ok",
        "element": {
          "id": task.id, // уникальный идентификатор элемента
          "text": task.task,
          "importance": task.importance, // importance = low | basic | important
          "deadline": task.dated
              ? task.date
              : null, // int64, может отсутствовать, тогда нет
          "done": task.done,
          "color": null, // может отсутствовать
          "created_at": '',
          "changed_at": '',
          "last_updated_by": ''
        }
      }, headers: {
        'X-Last-Known-Revision': '<revision>',
        'Authorization': 'Bearer $token'
      });
    } catch (error) {}
  }

  Future deleteTask(Task task) async {
    String fullUri = '$baseUrl/list/${task.id}';
    final uri = Uri.parse(fullUri);
    try {
      final response = await http.delete(uri, body: {
        "status": "ok",
        "element": {
          "id": task.id, // уникальный идентификатор элемента
          "text": task.task,
          "importance": task.importance, // importance = low | basic | important
          "deadline": task.dated
              ? task.date
              : null, // int64, может отсутствовать, тогда нет
          "done": task.done,
          "color": null, // может отсутствовать
          "created_at": '',
          "changed_at": '',
          "last_updated_by": ''
        }
      }, headers: {
        'X-Last-Known-Revision': '<revision>',
        'Authorization': 'Bearer $token'
      });
    } catch (error) {}
  }
}*/
