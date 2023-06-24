import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

class Task {
  late String id;
  String? task = '';
  String? importance = 'Нет';
  bool dated = false;
  bool? done = false;
  DateTime date = DateTime.now();

  Task(this.task, this.importance, this.dated, this.date) {
    const uuid = Uuid();
    id = uuid.v4();
  }

  Task.fromUri(this.id, this.task, this.importance, var deadline, this.done) {
    if (deadline != null) {
      dated = true;
      final format = DateFormat('dd.MM.yyyy');
      date = format.parse(deadline);
      //date = DateTime.fromMillisecondsSinceEpoch(int.parse(deadline) * 1000);
    }
  }

  Task.newTask() {
    const uuid = Uuid();
    id = uuid.v4();
  }

  String strDate() {
    String day = date.day.toString();
    String month = date.month.toString();
    if (date.month < 10) {
      month = '0${date.month}';
    }
    if (date.day < 10) {
      day = '0${date.day}';
    }
    String s = "$day.$month.${date.year}";
    return s;
  }

  factory Task.fromJson(Map<String, dynamic> json) => Task.fromUri(
        json['id'],
        json['text'],
        json['importance'],
        json['deadline'],
        json['done'] == 'true',
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'text': task,
        'importance': importance,
        'deadline': strDate(),
        'done': done!.toString(),
      };
}
