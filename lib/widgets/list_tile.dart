import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../bloc/tasks_bloc/tasks_bloc.dart';
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
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                const Icon(Icons.star_outline),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.task.title,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 18,
                          decoration: widget.task.isDone!
                              ? TextDecoration.lineThrough
                              : null,
                        )),
                    Text(DateFormat()
                        .add_yMMMd()
                        .add_Hms()
                        .format(DateTime.now())),
                  ],
                ),
              ],
            ),
          ),
          Row(
            children: [
              Checkbox(
                value: widget.task.isDone,
                onChanged: widget.task.isDeleted! == false
                    ? (value) {
                        context.read<TasksBloc>()
                          ..add(UpdateTask(task: widget.task));
                      }
                    : null,
              ),
              PopupMenuButton(
                  itemBuilder: widget.task.isDeleted == false
                      ? (((context) => [
                            PopupMenuItem(
                              child: TextButton.icon(
                                  onPressed: null,
                                  icon: const Icon(Icons.edit),
                                  label: const Text('Edit')),
                              onTap: () {},
                            ),
                            PopupMenuItem(
                                child: TextButton.icon(
                                    onPressed: null,
                                    icon: const Icon(Icons.bookmark),
                                    label: const Text('Add to Bookmarks')),
                                onTap: () {}),
                            PopupMenuItem(
                              child: TextButton.icon(
                                  onPressed: null,
                                  icon: const Icon(Icons.delete),
                                  label: const Text('Delete')),
                              onTap: () => widget._removedOrDeleteTask(
                                  context, widget.task),
                            ),
                          ]))
                      : (context) => [
                            PopupMenuItem(
                              child: TextButton.icon(
                                  onPressed: null,
                                  icon: const Icon(Icons.restore_from_trash),
                                  label: const Text('Restore')),
                              onTap: () {},
                            ),
                            PopupMenuItem(
                              child: TextButton.icon(
                                  onPressed: null,
                                  icon: const Icon(Icons.delete),
                                  label: const Text('Delete Forever')),
                              onTap: () => widget._removedOrDeleteTask(
                                  context, widget.task),
                            ),
                          ])
            ],
          ),
        ],
      ),
    );
    // return ListTile(
    //   title: Text(widget.task.title,
    //       style: TextStyle(
    //         decoration: widget.task.isDone! ? TextDecoration.lineThrough : null,
    //       )),
    //   trailing: Checkbox(
    //     value: widget.task.isDone,
    //     onChanged: widget.task.isDeleted! == false
    //         ? (value) {
    //             context.read<TasksBloc>()..add(UpdateTask(task: widget.task));
    //           }
    //         : null,
    //   ),
    //   onLongPress: () => widget._removedOrDeleteTask(context, widget.task),
    // );
  }
}
