import 'dart:io';

import 'package:uuid/uuid.dart';
import 'package:device_info_plus/device_info_plus.dart';

class Task {
  late String id;
  String? task = '';
  String? importance;
  bool dated = false;
  bool? done = false;
  DateTime date = DateTime.now();
  late DateTime? createdAt;
  late DateTime? changedAt;
  late String? lastUpdatedBy;

  Task(this.task, this.importance, this.dated, this.date) {
    const uuid = Uuid();
    id = uuid.v4();
  }

  Task.fromUri(this.id, this.task, this.importance, var deadline, this.done,
      var created, var changed, this.lastUpdatedBy) {
    createdAt = DateTime.fromMillisecondsSinceEpoch(int.parse(created));
    changedAt = DateTime.fromMillisecondsSinceEpoch(int.parse(changed));
    if (deadline != null) {
      dated = true;
      /*final format = DateFormat('dd.MM.yyyy');
      date = format.parse(deadline);*/
      date = DateTime.fromMillisecondsSinceEpoch(int.parse(deadline));
      print(date);
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
      json['createdAt'],
      json['changedAt'],
      json['lastUpdatedBy']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'text': task,
        'importance': importance,
        'deadline': done! ? date.millisecondsSinceEpoch.toString() : null,
        'done': done!.toString(),
        'createdAt': createdAt!.millisecondsSinceEpoch.toString(),
        'changedAt': changedAt!.millisecondsSinceEpoch.toString(),
        'lastUpdatedBy': lastUpdatedBy,
      };
}

Future<String?> getId() async {
  var devInfo = DeviceInfoPlugin();
  if (Platform.isAndroid) {
    var androidInfo = await devInfo.androidInfo;
    return androidInfo.androidId;
  } else if (Platform.isIOS) {
    var iosInfo = await devInfo.iosInfo;
    return iosInfo.identifierForVendor;
  }
  return "undefined device id";
}
