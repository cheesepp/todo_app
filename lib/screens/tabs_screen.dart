import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test/screens/completed_tasks_screen.dart';
import 'package:test/screens/favorite_tasks_screen.dart';
import 'package:test/screens/my_drawer.dart';
import 'package:test/screens/pending_screen.dart';
import 'package:uuid/uuid.dart';

import '../bloc/tasks_bloc/tasks_bloc.dart';
import '../models/task.dart';

class TabsScreen extends StatefulWidget {
  TabsScreen({Key? key}) : super(key: key);
  static const id = 'tabs_screen';

  final List<Map<String, dynamic>> _pageDetails = [
    {'pageName': PendingTasksScreen(), 'title': 'Pending Tasks'},
    {'pageName': CompletedTasksScreen(), 'title': 'Completed Tasks'},
    {'pageName': FavoriteTasksScreen(), 'title': 'Favorite Tasks'},
  ];

  var _selectedPageIndex = 0;

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  void _addTask(BuildContext context) {
    showModalBottomSheet(
        isScrollControlled: true,
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
                      const SizedBox(
                        height: 30,
                      ),
                      TextField(
                        autofocus: true,
                        controller: descriptionController,
                        minLines: 3,
                        maxLines: 5,
                        decoration: const InputDecoration(
                            label: Text('Description'),
                            border: OutlineInputBorder()),
                      ),
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('cancel'),
                      ),
                      ElevatedButton(
                          onPressed: () {
                            var task = Task(
                                description: descriptionController.text,
                                title: titleController.text,
                                date: DateTime.now().toString(),
                                id: Uuid().v1());
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget._pageDetails[widget._selectedPageIndex]['title']),
        actions: [
          IconButton(
            onPressed: () => _addTask(context),
            icon: const Icon(Icons.add),
          )
        ],
      ),
      drawer: MyDrawer(),
      body: widget._pageDetails[widget._selectedPageIndex]['pageName'],
      floatingActionButton: widget._selectedPageIndex == 0
          ? FloatingActionButton(
              onPressed: () => _addTask(context),
              tooltip: 'Add Task',
              child: const Icon(Icons.add),
            )
          : null,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: widget._selectedPageIndex,
        onTap: (index) {
          setState(() {
            widget._selectedPageIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.incomplete_circle_sharp),
              label: 'Pending Tasks'),
          BottomNavigationBarItem(
              icon: Icon(Icons.done), label: 'Completed Tasks'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: 'Favorite Tasks'),
        ],
      ),
    );
  }
}
