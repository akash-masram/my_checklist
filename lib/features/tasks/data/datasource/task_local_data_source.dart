import '../../../../core/storage/hive_service.dart';
import '../../domain/entity/task.dart';

class TaskLocalDataSource {
  final HiveService hive;

  TaskLocalDataSource(this.hive);

  Map<String, List<Task>> load() {
    final raw = hive.read();

    return raw.map((key, value) {
      return MapEntry(
        key,
        List<Map>.from(value)
            .map(
              (e) => Task(
                id: e['id'],
                title: e['title'],
                completed: e['completed'],
              ),
            )
            .toList(),
      );
    });
  }

  void save(Map<String, List<Task>> data) {
    final encoded = data.map(
      (key, tasks) => MapEntry(
        key,
        tasks
            .map(
              (t) => {'id': t.id, 'title': t.title, 'completed': t.completed},
            )
            .toList(),
      ),
    );

    hive.write(encoded);
  }
}
