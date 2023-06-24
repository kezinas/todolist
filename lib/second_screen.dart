import 'package:flutter/material.dart';
import 'task.dart';
import 'db_helper.dart';
import 'generated/l10n.dart';

class SecondScreen extends StatefulWidget {
  const SecondScreen({super.key});

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  String? tsk;
  bool dateOn = false;
  DateTime date = DateTime.now();
  bool isEmpty = true;
  String importance = "Нет";
  bool changing = false;
  bool isChanged = false;
  @override
  Widget build(BuildContext context) {
    Task task = ModalRoute.of(context)?.settings.arguments as Task;
    final delegate = S.of(context);
    var items = [delegate.Not, delegate.Low, delegate.High];
    if (task.task != '' && !isChanged) {
      changing = true;
      isChanged = true;
      importance = task.importance ?? delegate.Not;
      dateOn = task.dated;
      if (dateOn) {
        date = task.date;
      }
    }
    return Scaffold(
      body: ListView(
        children: [
          AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: IconTheme(
                data: Theme.of(context).copyWith().iconTheme,
                child: const Icon(Icons.close),
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () async {
                    if (task.task == '') {
                      task.task = tsk;
                      task.importance = importance;
                      task.dated = dateOn;
                      task.date = date;
                      DbHelper.addTask(task);
                    } else {
                      task.task = tsk;
                      task.importance = importance;
                      task.dated = dateOn;
                      task.date = date;
                      DbHelper.updateTask(task);
                    }
                    Navigator.pop(context);
                  },
                  child: Text(
                    delegate.SaveButton,
                    style: const TextStyle(
                        color: Color.fromARGB(255, 0, 122, 255)),
                  )),
            ],
          ),
          SizedBox(
            //height: 100,
            child: TextFormField(
              //expands: true,
              minLines: 5,
              maxLines: 10,
              initialValue: (task.task != '') ? task.task : null,
              onChanged: (value) => setState(() {
                tsk = value;
                isEmpty = false;
              }),
              decoration: InputDecoration(
                border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                hintText: delegate.Hint,
                fillColor: Colors.white,
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Text(delegate.DropDown),
                DropdownButton(
                    hint: DropdownMenuItem(
                      child: Text(importance),
                    ),
                    items: items.map((String item) {
                      return DropdownMenuItem(
                        value: item,
                        child: Text(item),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        importance = value ?? delegate.Not;
                      });
                    }),
              ],
            ),
          ),
          SwitchListTile.adaptive(
            activeColor: Colors.blue,
            value: dateOn,
            onChanged: (value) async {
              if (value) {
                DateTime? newdate = await showDatePicker(
                  context: context,
                  initialDate: dateOn ? task.date : date,
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2100),
                );
                if (newdate == null) {
                  setState(() {
                    dateOn = false;
                  });
                } else {
                  setState(() {
                    dateOn = true;
                    date = newdate;
                  });
                }
              } else {
                setState(() {
                  dateOn = false;
                });
              }
            },
            title: Text(delegate.Date),
            subtitle: dateOn
                ? Text(
                    '${date.day}.${date.month}.${date.year}',
                    style: const TextStyle(color: Colors.blue),
                  )
                : const Text(''),
          ),
          TextButton.icon(
            onPressed: (isEmpty && task.task == '')
                ? null
                : () {
                    setState(() {
                      dateOn = false;
                      importance = items[0];
                      isEmpty = true;
                      tsk = '';
                      date = DateTime.now();
                      if (task.task != '') {
                        DbHelper.deleteTask(task);
                      }
                      Navigator.pop(context);
                    });
                  },
            icon: Icon(
              Icons.delete,
              color: (isEmpty && task.task == '') ? Colors.grey : Colors.red,
            ),
            label: Text(
              delegate.DeleteButton,
              style: TextStyle(
                  color:
                      (isEmpty && task.task == '') ? Colors.grey : Colors.red),
            ),
          )
        ],
      ),
    );
  }
}
