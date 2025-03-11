import 'package:flutter/material.dart';
import 'package:novo_projeto/components/task.dart';

class TaskInherited extends InheritedWidget {
  TaskInherited({super.key, required super.child});

  final List<Task> taskList = <Task>[
    Task(
      name: "yyyyyy",
      photo: "assets/images/1d00c4def63f580b7450e834600d50e2.jpg",
      difficulty: 2,
    ),

    Task(
      name: "zzzzzz",
      photo: "assets/images/05b4b103a4bce9d83d2fcfca8bdc3bfe.jpg",
      difficulty: 0,
    ),
    Task(
      name: "aaaaaaa",
      photo: "assets/images/6e1cb7013c95689334bda60ca79b4f21.jpg",
      difficulty: 3,
    ),
    Task(
      name: "yyyyyy",
      photo: "assets/images/6e07e9ac97324206ff0d98f3a707edce.jpg",
      difficulty: 5,
    ),
    Task(
      name: "aaaaaaa",
      photo: "assets/images/7ca037f238b66b94f862a2edd09dabbc.jpg",
      difficulty: 3,
    ),
    Task(
      name: "yyyyyy",
      photo: "assets/images/9388d67b1e53e2dec6176b602ae9b9eb.jpg",
      difficulty: 5,
    ),

  ];

  void newTask(String name, int difficulty, String photo) {
    taskList.add(Task(name: name, photo: photo, difficulty: difficulty));
  }

  static TaskInherited of(BuildContext context) {
    final TaskInherited? result =
        context.dependOnInheritedWidgetOfExactType<TaskInherited>();
    assert(result != null, 'No TaskInherited found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(TaskInherited old) {
    return old.taskList.length != taskList.length;
  }
}
