import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import '../../models/task.dart';

part 'tasks_event.dart';
part 'tasks_state.dart';

class TasksBloc extends HydratedBloc<TasksEvent, TasksState> {
  TasksBloc() : super(const TasksState()) {
    on<AddTask>(_onAddTask);
    on<UpdateTask>(_onUpdateTask);
    on<DeleteTask>(_onDeleteTask);
    on<RemoveTask>(_onRemoveTask);
  }

  void _onAddTask(AddTask event, Emitter<TasksState> emit) {
    final state = this.state;
    emit(TasksState(
        completedTask: state.completedTask,
        favoriteTask: state.favoriteTask,
        allTask: List.from(state.allTask)..add(event.task),
        removedTasks: state.removedTasks));
  }

  void _onUpdateTask(UpdateTask event, Emitter<TasksState> emit) {
    final state = this.state;
    final task = event.task;
    // final int index = state.allTask.indexOf(task);
    // emit(TasksState(allTask: List.from(state.allTask)..remove(task)));
    // List<Task> allTasks = List.from(state.allTask)..remove(task);
    List<Task> allTasks = state.allTask;
    List<Task> completedTasks = state.completedTask;
    task.isDone == false
        ? {
            allTasks = List.from(allTasks)..remove(task),
            completedTasks = List.from(completedTasks)
              ..insert(0, task.copyWith(isDone: true))
          }
        : {
            completedTasks = List.from(completedTasks)..remove(task),
            allTasks = List.from(allTasks)
              ..insert(0, task.copyWith(isDone: false))
          };

    emit(TasksState(
        allTask: allTasks,
        removedTasks: state.removedTasks,
        favoriteTask: state.favoriteTask,
        completedTask: completedTasks));
  }

  void _onDeleteTask(DeleteTask event, Emitter<TasksState> emit) {
    final state = this.state;
    emit(TasksState(
        allTask: List.from(state.allTask)..remove(event.task),
        completedTask: state.completedTask,
        favoriteTask: state.favoriteTask,
        removedTasks: List.from(state.removedTasks)..remove(event.task)));
  }

  void _onRemoveTask(RemoveTask event, Emitter<TasksState> emit) {
    final state = this.state;
    emit(TasksState(
        favoriteTask: List.from(state.favoriteTask)..remove(event.task),
        completedTask: List.from(state.completedTask)..remove(event.task),
        allTask: List.from(state.allTask)..remove(event.task),
        removedTasks: List.from(state.removedTasks)
          ..add(event.task.copyWith(
            isDeleted: true,
          ))));
  }

  @override
  TasksState? fromJson(Map<String, dynamic> json) {
    return TasksState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(TasksState state) {
    return state.toMap();
  }
}
