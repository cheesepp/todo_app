import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/bloc/tasks_bloc.dart';
import '../models/task.dart';

class ListTiles extends StatefulWidget {
  ListTiles({Key? key, required this.task}) : super(key: key);
  Task task;

  void _removedOrDeleteTask(BuildContext ctx, Task task) {
    task.isDeleted!
        ? ctx.read<TasksBloc>().add(DeleteTask(task: task))
        : ctx.read<TasksBloc>().add(RemoveTask(task: task));
  }

  @override
  State<ListTiles> createState() => _ListTilesState();
}

class _ListTilesState extends State<ListTiles> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.task.title,
          style: TextStyle(
            decoration: widget.task.isDone! ? TextDecoration.lineThrough : null,
          )),
      trailing: Checkbox(
        value: widget.task.isDone,
        onChanged: (value) {
          context.read<TasksBloc>()..add(UpdateTask(task: widget.task));
        },
      ),
      onLongPress: () => widget._removedOrDeleteTask(context, widget.task),
    );
  }
}
