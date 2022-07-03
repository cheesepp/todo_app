import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test/widgets/list_tile.dart';

import '../bloc/tasks_bloc/tasks_bloc.dart';
import '../models/task.dart';

class TaskList extends StatelessWidget {
  const TaskList({
    Key? key,
    required this.taskList,
  }) : super(key: key);

  final List<Task> taskList;

  @override
  Widget build(BuildContext context) {
    return ExpansionPanelList.radio(
      children: taskList
          .map((task) => ExpansionPanelRadio(
              value: task.id,
              headerBuilder: (context, isOpen) => ListTiles(task: task),
              body: ListTile(
                title: SelectableText.rich(TextSpan(children: [
                  const TextSpan(
                    text: 'Text\n',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: '${task.title}\n',
                  ),
                  const TextSpan(
                    text: 'Description\n',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: '${task.description}\n',
                  ),
                ])),
              )))
          .toList(),
    );
    // return Expanded(
    //   child: ListView.builder(
    //     itemCount: taskList.length,
    //     itemBuilder: (_, i) {
    //       var task = taskList[i];
    //       return ListTiles(task: task);
    //     },
    //   ),
    // );
  }
}
