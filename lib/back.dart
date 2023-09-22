import 'dart:convert';
import 'package:http/http.dart' as http;
import 'consts.dart';
import 'task.dart';

class Ftasks {
  int? revision = 0;
  Future<List<Task>> getList() async {
    const fullUri = '$baseUrl/list';
    final uri = Uri.parse(fullUri);
    try {
      final response =
          await http.get(uri, headers: {'Authorization': 'Bearer $token'});
      final result = jsonDecode(response.body);
      revision = result['revision'];
      List<Task> n = (result['list'] as List<dynamic>)
          .map((e) => Task.fromUri(
              e['id'],
              e['text'],
              e['importance'],
              e['deadline'],
              e['done'],
              e['createdAt'],
              e['changedAt'],
              e['lastUpdatedBy']))
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
      revision = result['revision'];
      Task n = Task.fromUri(
        result['element']['id'],
        result['element']['text'],
        result['element']['importance'],
        result['element']['deadline'],
        result['element']['done'],
        result['element']['createdAt'],
        result['element']['changedAt'],
        result['element']['lastUpdatedBy'],
      );
      return n;
    } catch (error) {
      throw Error();
    }
  }

  Future addTask(Task task) async {
    String fullUri = '$baseUrl/list';
    final uri = Uri.parse(fullUri);
    try {
      final response = await http.post(uri,
          body: jsonEncode({
            'element': task.toJson(),
          }),
          headers: {
            'X-Last-Known-Revision': revision.toString(),
            'Authorization': 'Bearer $token'
          });
      final result = await jsonDecode(response.body);
      revision = result['revision'];
    } catch (error) {
      print(error);
    }
  }

  Future updateList(List<Task> upList) async {
    String fullUri = '$baseUrl/list';
    final uri = Uri.parse(fullUri);
    try {
      final response = await http.patch(uri, body: {jsonEncode(upList)});
      final result = jsonDecode(response.body);
      revision = result['revision'];
    } catch (error) {}
  }

  Future changeTask(Task task) async {
    String fullUri = '$baseUrl/list/${task.id}';
    final uri = Uri.parse(fullUri);
    try {
      final response = await http.put(uri,
          body: jsonEncode({
            task.toJson(),
          }),
          headers: {
            'X-Last-Known-Revision': revision.toString(),
            'Authorization': 'Bearer $token'
          });
      final result = jsonDecode(response.body);
      revision = result['revision'];
    } catch (error) {}
  }

  Future deleteTask(Task task) async {
    String fullUri = '$baseUrl/list/${task.id}';
    final uri = Uri.parse(fullUri);
    try {
      final response = await http.delete(uri, headers: {
        'X-Last-Known-Revision': revision.toString(),
        'Authorization': 'Bearer $token'
      });
      final result = jsonDecode(response.body);
      revision = result['revision'];
    } catch (error) {}
  }
}
