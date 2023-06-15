import 'package:flutter/material.dart';
import 'task.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

late Task addedTask;
late bool added;
late bool deleted;

class _FirstScreenState extends State<FirstScreen> {
  //late List<String> tasks = ['smth', 'smth1', 'smth2', 'smth3', 'smth4'];
  Map<String, Task> alltasks = {};
  int count_done = 0;
  bool isVisible = true;
  late int len;
  late List<String> visibleTasks = alltasks.keys.toList();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 0, 122, 255),
        foregroundColor: Colors.white,
        shape: CircleBorder(),
        onPressed: () async {
          await Navigator.pushNamed(context, '/editing',
              arguments: Task.newTask());
          print("smth");
          if (added) {
            print(addedTask.task! + 'sdsds');
            setState(() {
              alltasks[addedTask.task ?? ''] = addedTask;
              visibleTasks.add(addedTask.task ?? '');
            });
            added = false;
          }
        },
        child: Icon(
          Icons.add,
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Column(
              children: [
                Text(
                  "Мои дела",
                  style: TextStyle(fontSize: 32),
                ),
                Text(
                  'Выполнено - $count_done',
                  style: TextStyle(color: Color.fromARGB(255, 142, 142, 147)),
                ),
              ],
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    setState(() {
                      isVisible = !isVisible;
                      if (isVisible) {
                        visibleTasks.clear();
                        visibleTasks = alltasks.keys.toList();
                      } else {
                        visibleTasks.clear();
                        for (final key in alltasks.keys) {
                          if (alltasks[key]!.done == false) {
                            visibleTasks.add(key);
                          }
                        }
                      }
                    });
                  },
                  icon: isVisible
                      ? Icon(Icons.visibility,
                          color: Color.fromARGB(255, 0, 122, 255))
                      : Icon(Icons.visibility_off,
                          color: Color.fromARGB(255, 0, 122, 255)))
            ],
          ),
          SliverList.builder(
              itemCount: visibleTasks.length,
              itemBuilder: (context, i) {
                return Dismissible(
                  secondaryBackground: Container(
                    color: Colors.red,
                    child: Container(
                      child: const Icon(Icons.delete),
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.all(10),
                    ),
                  ),
                  background: Container(
                    color: Colors.green,
                    child: Container(
                      child: const Icon(Icons.check),
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.all(10),
                    ),
                  ),
                  key: ValueKey<String>(visibleTasks[i]),
                  confirmDismiss: (direction) async {
                    if (direction == DismissDirection.startToEnd) {
                      if (alltasks[visibleTasks[i]]!.done != true) {
                        count_done += 1;
                      }
                      setState(() {
                        alltasks[visibleTasks[i]]!.done = true;
                      });
                      return false;
                    } else {
                      setState(() {
                        if (alltasks[visibleTasks[i]]!.done == true) {
                          count_done -= 1;
                        }
                        alltasks.remove(visibleTasks[i]);
                        visibleTasks.removeAt(i);
                      });
                      return true;
                    }
                  },
                  child: CheckboxListTile(
                    activeColor: Colors.green,
                    value: alltasks[visibleTasks[i]]!.done,
                    onChanged: (bool? value) {
                      setState(() {
                        if (value == true) {
                          count_done += 1;
                        } else {
                          count_done -= 1;
                        }
                        alltasks[visibleTasks[i]]!.done = value;
                      });
                    },
                    title: alltasks[visibleTasks[i]]!.done != true
                        ? Text(
                            visibleTasks[i],
                            overflow: TextOverflow.ellipsis,
                          )
                        : Text(
                            visibleTasks[i],
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                decoration: TextDecoration.lineThrough,
                                color: Color.fromARGB(255, 209, 209, 214)),
                          ),
                    subtitle: alltasks[visibleTasks[i]]!.dated
                        ? Text(
                            alltasks[visibleTasks[i]]!.strDate(),
                            style: TextStyle(color: Colors.blue),
                          )
                        : null,
                    secondary: IconButton(
                      onPressed: () async {
                        await Navigator.pushNamed(context, '/editing',
                            arguments: alltasks[visibleTasks[i]]);
                        if (added) {
                          setState(() {
                            alltasks.remove(visibleTasks[i]);
                            visibleTasks.removeAt(i);
                            alltasks[addedTask.task!] = addedTask;
                            visibleTasks.add(addedTask.task ?? '');
                            added = false;
                          });
                        }
                        if (deleted) {
                          setState(() {
                            alltasks.remove(visibleTasks[i]);
                            visibleTasks.removeAt(i);
                          });
                        }
                      },
                      icon: Icon(
                        Icons.info_outline_rounded,
                        color: Colors.grey,
                      ),
                    ),
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                );
              }),
        ],
      ),
    );
  }
}
