import 'package:hive/hive.dart';

class Tododatabase {
  List todolist = [];

//refference the box
  final boxy = Hive.box('boxy');

  //first time yhal l app
  void createfirstdata() {
    todolist = [
      ['prayings', false]
    ];
  }

  void loaddata() {
    todolist = boxy.get('todo');
  }

  void updatedata() {
    boxy.put('todo', todolist);
  }
}
