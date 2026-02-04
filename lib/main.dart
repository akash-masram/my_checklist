import 'package:flutter/widgets.dart';
import 'package:task_app/app.dart';
import 'package:task_app/injection.dart';
// import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  await Hive.openBox('tasks');

  setupDependencies();

  runApp(const MyApp());
}
