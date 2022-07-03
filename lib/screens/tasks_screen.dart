import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test/models/task.dart';
import 'package:test/screens/my_drawer.dart';
import 'package:uuid/uuid.dart';
import '../bloc/tasks_bloc/tasks_bloc.dart';
import '../widgets/task_list.dart';

class TasksScreen extends StatelessWidget {
  TasksScreen({Key? key}) : super(key: key);
  static const id = 'tasks_screen';
  TextEditingController titleController = TextEditingController();
  void _addTask(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) => SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      const Text(
                        'Add Task',
                        style: TextStyle(fontSize: 24),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextField(
                        autofocus: true,
                        controller: titleController,
                        decoration: const InputDecoration(
                            label: Text('Title'), border: OutlineInputBorder()),
                      ),
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('cancel'),
                      ),
                      ElevatedButton(
                          onPressed: () {
                            var task = Task(
                                title: titleController.text, id: Uuid().v1());
                            context.read<TasksBloc>().add(AddTask(task: task));
                            Navigator.pop(context);
                          },
                          child: const Text('Add'))
                    ],
                  ),
                ),
              ),
            ));
  }

  // List<Task> taskList = [
  //   Task(title: 'Task 1'),
  //   Task(title: 'Task 2'),
  //   Task(title: 'Task 3'),
  // ];
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksBloc, TasksState>(builder: (context, state) {
      List<Task> taskList = state.allTask;
      return Scaffold(
        drawer: MyDrawer(),
        appBar: AppBar(
          title: const Text('Tasks App'),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.add),
            )
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Chip(
                label: Text(
                  '${state.allTask.length} Tasks',
                ),
              ),
            ),
            TaskList(taskList: taskList)
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _addTask(context),
          tooltip: 'Add Task',
          child: const Icon(Icons.add),
        ),
      );
    });
  }
}
