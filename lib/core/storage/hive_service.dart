import 'package:hive/hive.dart';

class HiveService {
  final Box box = Hive.box('tasks');

  Map<String, dynamic> read() {
    return Map<String, dynamic>.from(box.get('data') ?? {});
  }

  void write(Map<String, dynamic> data) {
    box.put('data', data);
  }
}
