import '../entity/task.dart';

abstract class TaskRepository {
  Map<String, List<Task>> loadTasks();

  void addTask({required DateTime date, required String title});

  void toggleTask({required DateTime date, required String taskId});

  void deleteTask({required DateTime date, required String taskId});
}
