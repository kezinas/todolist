import 'package:flutter/material.dart';
import 'task.dart';
import 'db_helper.dart';
//import 'generated/l10n.dart';
//import 'package:flutter_localizations/flutter_localizations.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

late Task addedTask;
late bool added;
late bool deleted;

class _FirstScreenState extends State<FirstScreen> {
  List<Task> data = [];
  Map<String, Task> alltasks = {};
  int countDone = 0;
  bool isVisible = true;
  late int len;
  late List<String> visibleTasks = alltasks.keys.toList();
  @override
  Widget build(BuildContext context) {
    //final delegate = S.of(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 0, 122, 255),
        foregroundColor: Colors.white,
        shape: const CircleBorder(),
        onPressed: () async {
          await Navigator.pushNamed(context, '/editing',
              arguments: Task.newTask());
          /*if (added) {
            setState(() {
              alltasks[addedTask.task ?? ''] = addedTask;
              visibleTasks.add(addedTask.task ?? '');
            });
            added = false;
          }*/
          data = await DbHelper.getAllTasks() ?? [];
          setState(() {});
        },
        child: const Icon(
          Icons.add,
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Column(
              children: [
                const Text(
                  "Мои дела",
                  style: TextStyle(fontSize: 32),
                ),
                Text(
                  'Выполнено - $countDone',
                  style: const TextStyle(
                      color: Color.fromARGB(255, 142, 142, 147)),
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
                      ? const Icon(Icons.visibility,
                          color: Color.fromARGB(255, 0, 122, 255))
                      : const Icon(Icons.visibility_off,
                          color: Color.fromARGB(255, 0, 122, 255)))
            ],
          ),
          FutureBuilder<List<Task>?>(
              future: DbHelper.getAllTasks(),
              builder: (context, snapshot) {
                data = snapshot.data ?? [];
                if (snapshot.hasData && snapshot.data != null) {
                  alltasks = {for (Task v in data) v.task ?? '': v};
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
                }
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return SliverList.builder(
                      itemCount: visibleTasks.length,
                      itemBuilder: (context, i) {
                        return Dismissible(
                          secondaryBackground: Container(
                            color: Colors.red,
                            child: Container(
                              alignment: Alignment.centerRight,
                              padding: const EdgeInsets.all(10),
                              child: const Icon(Icons.delete),
                            ),
                          ),
                          background: Container(
                            color: Colors.green,
                            child: Container(
                              alignment: Alignment.centerLeft,
                              padding: const EdgeInsets.all(10),
                              child: const Icon(Icons.check),
                            ),
                          ),
                          key: ValueKey<String>(visibleTasks[i]),
                          confirmDismiss: (direction) async {
                            if (direction == DismissDirection.startToEnd) {
                              if (alltasks[visibleTasks[i]]!.done != true) {
                                countDone += 1;
                              }
                              setState(() {
                                alltasks[visibleTasks[i]]!.done = true;
                              });
                              DbHelper.updateTask(alltasks[visibleTasks[i]]!);
                              return false;
                            } else {
                              setState(() {
                                if (alltasks[visibleTasks[i]]!.done == true) {
                                  countDone -= 1;
                                }
                                DbHelper.deleteTask(alltasks[visibleTasks[i]]!);
                                alltasks.remove(visibleTasks[i]);
                                visibleTasks.removeAt(i);
                              });
                              return true;
                            }
                          },
                          child: CheckboxListTile(
                            activeColor: Colors.green,
                            value: alltasks[visibleTasks[i]]!.done,
                            onChanged: (bool? value) async {
                              setState(() {
                                alltasks[visibleTasks[i]]!.done = value;
                                if (value == true) {
                                  countDone += 1;
                                } else {
                                  countDone -= 1;
                                }
                              });
                              DbHelper.updateTask(alltasks[visibleTasks[i]]!);
                              data = await DbHelper.getAllTasks() ?? [];
                            },
                            title: alltasks[visibleTasks[i]]!.done != true
                                ? Text(
                                    visibleTasks[i],
                                    overflow: TextOverflow.ellipsis,
                                  )
                                : Text(
                                    visibleTasks[i],
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        decoration: TextDecoration.lineThrough,
                                        color:
                                            Color.fromARGB(255, 209, 209, 214)),
                                  ),
                            subtitle: alltasks[visibleTasks[i]]!.dated
                                ? Text(
                                    alltasks[visibleTasks[i]]!.strDate(),
                                    style: const TextStyle(color: Colors.blue),
                                  )
                                : null,
                            secondary: IconButton(
                              onPressed: () async {
                                await Navigator.pushNamed(context, '/editing',
                                    arguments: alltasks[visibleTasks[i]]);
                                /*if (added) {
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
                        }*/
                                data = await DbHelper.getAllTasks() ?? [];
                                setState(() {});
                              },
                              icon: const Icon(
                                Icons.info_outline_rounded,
                                color: Colors.grey,
                              ),
                            ),
                            controlAffinity: ListTileControlAffinity.leading,
                          ),
                        );
                      });
                }
              }),
        ],
      ),
    );
  }
}
