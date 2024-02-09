import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todoapp/models/database.dart';
import 'package:todoapp/utils/todo_tile.dart';

import '../utils/dialog.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
//refference the hive box
  final boxy = Hive.box('boxy');
  Tododatabase db = Tododatabase();

  @override
  void initState() {
    // first time opening or not
    if (boxy.get('todo') == null) {
      db.createfirstdata();
    } else {
      db.loaddata();
    }
    super.initState();
  }

  final _controller = TextEditingController();

//list of tasks

  void checkboxchanged(bool value, int index) {
    setState(() {
      db.todolist[index][1] = !db.todolist[index][1];
      db.updatedata();
    });
  }

  void savenewtask() {
    setState(() {
      db.todolist.add([_controller.text, false]);
      Navigator.of(context).pop();
      _controller.clear();
      db.updatedata();
    });
  }

  void createtask() {
    showDialog(
        context: context,
        builder: (context) {
          return dialoguebox(
            controller: _controller,
            onsave: savenewtask,
            oncancel: () => Navigator.of(context).pop(),
          );
        });
  }

  void deletetask(int index) {
    setState(() {
      db.todolist.removeAt(index);
      db.updatedata();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.purple[200],
        appBar: AppBar(
          title: Text('TO DO'),
          elevation: 0,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: createtask,
          child: Icon(Icons.add),
        ),
        body: ListView.builder(
            itemCount: db.todolist.length,
            itemBuilder: (context, index) {
              return Todotile(
                taskName: db.todolist[index][0],
                taskCompleted: db.todolist[index][1],
                onChanged: (value) => checkboxchanged(value!, index),
                delete: (BuildContext) => deletetask(index),
              );
            }));
  }
}
