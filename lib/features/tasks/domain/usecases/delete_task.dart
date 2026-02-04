import '../repository/task_repository.dart';

class DeleteTask {
  final TaskRepository repo;

  DeleteTask(this.repo);

  void call(DateTime date, String taskId) {
    repo.deleteTask(date: date, taskId: taskId);
  }
}
