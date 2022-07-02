part of 'tasks_bloc.dart';

class TasksState extends Equatable {
  final List<Task> allTask;
  const TasksState({this.allTask = const <Task>[]});

  @override
  List<Object> get props => [allTask];

  Map<String, dynamic> toMap() {
    return {'allTasks': allTask.map((e) => e.toJson()).toList()};
  }

  factory TasksState.fromMap(Map<String, dynamic> map) {
    return TasksState(
      allTask: List<Task>.from(map['allTasks']?.map((x) => Task.fromJson(x)))
    );
  }

}
