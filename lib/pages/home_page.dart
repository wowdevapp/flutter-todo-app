import 'package:flutter/material.dart';
import 'package:todo/util/dialog_box.dart';
import 'package:todo/util/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _controller = TextEditingController();

  List todoTasks = [
    {'taskName': 'Task 1', 'isDone': false},
    {'taskName': 'Task 2', 'isDone': true},
    {'taskName': 'Task 3', 'isDone': false},
  ];

  void checkBoxChanged(bool? value, int index) {
    setState(() {
      todoTasks[index]['isDone'] = value;
    });
  }

  void saveNewTask() {
    setState(() {
      todoTasks.add({'taskName': _controller.text, 'isDone': false});
      _controller.clear();
    });
    Navigator.pop(context);
    print(todoTasks);
  }

  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _controller,
          onSave: saveNewTask,
          onCancel: () {
            Navigator.pop(context);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        title: Text('My Todo App'),
        elevation: 0,
        backgroundColor: Colors.yellow[300],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: todoTasks.length,
        itemBuilder: (context, index) {
          return TodoTile(
            taskName: todoTasks[index]['taskName'],
            isDone: todoTasks[index]['isDone'],
            onChanged: (value) => checkBoxChanged(value, index),
            deleteTask: (context) {
              setState(() {
                todoTasks.removeAt(index);
              });
            },
          );
        },
      ),
    );
  }
}
