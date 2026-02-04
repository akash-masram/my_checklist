import '../repository/task_repository.dart';

class AddTask {
  final TaskRepository repo;

  AddTask(this.repo);

  void call(DateTime date, String title) {
    repo.addTask(date: date, title: title);
  }
}
