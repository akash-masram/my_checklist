import '../../../../core/utils/date_utils.dart';
import '../../domain/entity/task.dart';
import '../../domain/repository/task_repository.dart';
import '../datasource/task_local_data_source.dart';

class TaskRepositoryImpl implements TaskRepository {
  final TaskLocalDataSource local;
  Map<String, List<Task>> _cache = {};

  TaskRepositoryImpl(this.local) {
    _cache = local.load();
  }

  @override
  Map<String, List<Task>> loadTasks() => _cache;

  @override
  void addTask({required DateTime date, required String title}) {
    final key = dateKey(date);
    final list = List<Task>.from(_cache[key] ?? []);

    list.add(
      Task(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: title,
        completed: false,
      ),
    );

    _cache = {..._cache, key: list};
    local.save(_cache);
  }

  @override
  void toggleTask({required DateTime date, required String taskId}) {
    final key = dateKey(date);
    final list = _cache[key] ?? [];

    final updated = list
        .map((t) => t.id == taskId ? t.copyWith(completed: !t.completed) : t)
        .toList();

    _cache = {..._cache, key: updated};
    local.save(_cache);
  }

  @override
  void deleteTask({required DateTime date, required String taskId}) {
    final key = dateKey(date);
    final updated = (_cache[key] ?? []).where((t) => t.id != taskId).toList();

    _cache = {..._cache, key: updated};
    local.save(_cache);
  }
}
