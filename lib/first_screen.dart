import 'package:flutter/material.dart';
import 'task.dart';
import 'db_helper.dart';
import 'generated/l10n.dart';
//import 'package:flutter_localizations/flutter_localizations.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  List<Task> data = [];
  Map<String, Task> alltasks = {};
  int countDone = 0;
  bool isVisible = true;
  late int len;
  late List<String> visibleTasks = alltasks.keys.toList();
  @override
  Widget build(BuildContext context) {
    final delegate = S.of(context);
    //delegate.load(Locale('en'));
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
                Text(
                  delegate.Title,
                  style: TextStyle(fontSize: 32),
                ),
                Text(
                  '${delegate.Subtitle} $countDone',
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
                print('data len = ${data.length}');
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
                  print(data.length);
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
                              if (alltasks[visibleTasks[i]]!.done == true) {
                                countDone -= 1;
                              }
                              var tsk = alltasks[visibleTasks[i]];
                              alltasks.remove(visibleTasks[i]);
                              visibleTasks.removeAt(i);
                              print(visibleTasks.length);
                              DbHelper.deleteTask(tsk!);
                              setState(() {});
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
                                data = await DbHelper.getAllTasks() ?? [];
                                print('smth ${data.length}');
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
