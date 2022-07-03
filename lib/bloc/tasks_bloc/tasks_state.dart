part of 'tasks_bloc.dart';

class TasksState extends Equatable {
  final List<Task> allTask;
  final List<Task> completedTask;
  final List<Task> favoriteTask;
  final List<Task> removedTasks;
  const TasksState(
      {this.allTask = const <Task>[],
      this.removedTasks = const <Task>[],
      this.completedTask = const <Task>[],
      this.favoriteTask = const <Task>[]});

  @override
  List<Object> get props =>
      [allTask, removedTasks, completedTask, favoriteTask];

  Map<String, dynamic> toMap() {
    return {
      'completedTasks': completedTask.map((e) => e.toJson()).toList(),
      'favoriteTasks': favoriteTask.map((e) => e.toJson()).toList(),
      'allTasks': allTask.map((e) => e.toJson()).toList(),
      'removedTasks': removedTasks.map((e) => e.toJson()).toList()
    };
  }

  factory TasksState.fromMap(Map<String, dynamic> map) {
    return TasksState(
        completedTask: List<Task>.from(
            map['completedTasks']?.map((x) => Task.fromJson(x))),
        favoriteTask:
            List<Task>.from(map['favoriteTasks']?.map((x) => Task.fromJson(x))),
        allTask: List<Task>.from(map['allTasks']?.map((x) => Task.fromJson(x))),
        removedTasks:
            List<Task>.from(map['removedTasks']?.map((x) => Task.fromJson(x))));
  }
}
