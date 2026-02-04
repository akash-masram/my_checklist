import '../repository/task_repository.dart';

class ToggleTask {
  final TaskRepository repo;

  ToggleTask(this.repo);

  void call(DateTime date, String taskId) {
    repo.toggleTask(date: date, taskId: taskId);
  }
}
