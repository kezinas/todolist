import 'package:flutter/material.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  //late List<String> tasks = ['smth', 'smth1', 'smth2', 'smth3', 'smth4'];
  late Map<String, bool?> tasks = {
    'smth': false,
    'smth1': false,
    'smth2': false,
    'smth3sdfdgfsffdhdhdfh fhdhd v fdhhdhdfhdhh dfhf fhhf': false,
    'smth4': false
  };
  bool isVisible = true;
  late int len;
  late List<String> visibleTasks = tasks.keys.toList();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 0, 122, 255),
        foregroundColor: Colors.white,
        shape: CircleBorder(),
        onPressed: () {},
        child: Icon(
          Icons.add,
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text(
              "Мои дела",
              style: TextStyle(fontSize: 32),
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    setState(() {
                      isVisible = !isVisible;
                      print('visible change');
                      if (isVisible) {
                        visibleTasks.clear();
                        visibleTasks = tasks.keys.toList();
                      } else {
                        visibleTasks.clear();
                        for (final key in tasks.keys) {
                          if (tasks[key] == false) {
                            visibleTasks.add(key);
                          }
                        }
                      }
                    });
                    print(tasks.values
                        .toList()
                        .where((element) => element == false)
                        .length);
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
                      setState(() {
                        tasks[visibleTasks[i]] = true;
                      });
                      return false;
                    } else {
                      setState(() {
                        tasks.remove(visibleTasks[i]);
                        visibleTasks.removeAt(i);
                      });
                      return true;
                    }
                  },
                  child: CheckboxListTile(
                    activeColor: Colors.green,
                    //selectedTileColor: Colors.grey,
                    tileColor: Color.fromARGB(255, 255, 255, 255),
                    value: tasks[visibleTasks[i]],
                    onChanged: (bool? value) {
                      setState(() {
                        tasks[visibleTasks[i]] = value;
                      });
                    },
                    title: tasks[visibleTasks[i]] != true
                        ? Text(
                            visibleTasks[i],
                            //softWrap: false,
                            overflow: TextOverflow.ellipsis,
                          )
                        : Text(
                            visibleTasks[i],
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                decoration: TextDecoration.lineThrough,
                                color: Color.fromARGB(255, 209, 209, 214)),
                          ),
                    secondary: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.info_rounded),
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
