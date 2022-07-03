part of 'tasks_bloc.dart';

class TasksState extends Equatable {
  final List<Task> allTask;
  final List<Task> removedTasks;
  const TasksState(
      {this.allTask = const <Task>[], this.removedTasks = const <Task>[]});

  @override
  List<Object> get props => [allTask, removedTasks];

  Map<String, dynamic> toMap() {
    return {
      'allTasks': allTask.map((e) => e.toJson()).toList(),
      'removedTasks': removedTasks.map((e) => e.toJson()).toList()
    };
  }

  factory TasksState.fromMap(Map<String, dynamic> map) {
    return TasksState(
        allTask: List<Task>.from(map['allTasks']?.map((x) => Task.fromJson(x))),
        removedTasks:
            List<Task>.from(map['removedTasks']?.map((x) => Task.fromJson(x))));
  }
}
