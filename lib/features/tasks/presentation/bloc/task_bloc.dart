import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_app/core/utils/date_utils.dart';
import 'package:task_app/features/tasks/domain/usecases/add_task.dart';
import 'package:task_app/features/tasks/domain/usecases/delete_task.dart';
import 'package:task_app/features/tasks/domain/usecases/load_tasks.dart';
import 'package:task_app/features/tasks/domain/usecases/toggle_task.dart';
import 'package:task_app/features/tasks/presentation/bloc/task_event.dart';
import 'package:task_app/features/tasks/presentation/bloc/task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final LoadTasks loadTasks;
  final AddTask addTask;
  final ToggleTask toggleTask;
  final DeleteTask deleteTask;

  TaskBloc({
    required this.loadTasks,
    required this.addTask,
    required this.toggleTask,
    required this.deleteTask,
  }) : super(_initialState(loadTasks)) {
    on<DateSelected>((e, emit) {
      emit(state.copyWith(selectedDate: e.date));
    });

    on<MonthChanged>((e, emit) {
      final newMonth = DateTime(
        state.focusedMonth.year,
        state.focusedMonth.month + e.offset,
      );

      emit(
        state.copyWith(
          focusedMonth: newMonth,
          monthDays: daysInMonth(newMonth),
          selectedDate: DateTime(newMonth.year, newMonth.month, 1),
        ),
      );
    });

    on<TaskAdded>((e, emit) {
      addTask(state.selectedDate, e.title);
      emit(state.copyWith(tasks: loadTasks()));
    });

    on<TaskToggled>((e, emit) {
      toggleTask(state.selectedDate, e.id);
      emit(state.copyWith(tasks: loadTasks()));
    });

    on<TaskDeleted>((e, emit) {
      deleteTask(state.selectedDate, e.id);
      emit(state.copyWith(tasks: loadTasks()));
    });
  }

  static TaskState _initialState(LoadTasks loadTasks) {
    final now = DateTime.now();
    return TaskState(
      selectedDate: now,
      focusedMonth: DateTime(now.year, now.month),
      monthDays: daysInMonth(now),
      tasks: loadTasks(),
    );
  }
}
