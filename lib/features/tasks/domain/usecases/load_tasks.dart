// import '../entity/task.dart';
import 'package:task_app/features/tasks/domain/entity/task.dart';

import '../repository/task_repository.dart';

class LoadTasks {
  final TaskRepository repo;

  LoadTasks(this.repo);

  Map<String, List<Task>> call() {
    return repo.loadTasks();
  }
}
