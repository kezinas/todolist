class Task {
  String? task = '';
  String? importance = 'Нет';
  bool dated = false;
  bool? done = false;
  DateTime date = DateTime.now();

  Task(this.task, this.importance, this.dated, this.date);

  Task.newTask();

  String strDate() {
    String s = date.day.toString() +
        '.' +
        date.month.toString() +
        '.' +
        date.year.toString();
    return s;
  }
}
