import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test/models/task.dart';
import 'package:test/screens/my_drawer.dart';
import 'package:uuid/uuid.dart';
import '../bloc/tasks_bloc/tasks_bloc.dart';
import '../widgets/task_list.dart';

class FavoriteTasksScreen extends StatelessWidget {
  const FavoriteTasksScreen({Key? key}) : super(key: key);
  static const id = 'tasks_screen';
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksBloc, TasksState>(builder: (context, state) {
      List<Task> taskList = state.favoriteTask;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Chip(
              label: Text(
                '${taskList.length} Tasks',
              ),
            ),
          ),
          TaskList(taskList: taskList)
        ],
      );
    });
  }
}
