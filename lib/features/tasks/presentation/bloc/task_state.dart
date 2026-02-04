import 'package:task_app/features/tasks/domain/entity/task.dart';

class TaskState {
  final DateTime selectedDate;
  final DateTime focusedMonth;
  final List<DateTime> monthDays;
  final Map<String, List<Task>> tasks;

  TaskState({
    required this.selectedDate,
    required this.focusedMonth,
    required this.monthDays,
    required this.tasks,
  });

  TaskState copyWith({
    DateTime? selectedDate,
    DateTime? focusedMonth,
    List<DateTime>? monthDays,
    Map<String, List<Task>>? tasks,
  }) {
    return TaskState(
      selectedDate: selectedDate ?? this.selectedDate,
      focusedMonth: focusedMonth ?? this.focusedMonth,
      monthDays: monthDays ?? this.monthDays,
      tasks: tasks ?? this.tasks,
    );
  }
}
