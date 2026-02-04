import 'package:hive/hive.dart';
import 'package:task_app/core/theme/theme_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:task_app/core/storage/hive_service.dart';
import 'package:task_app/core/storage/theme_storage.dart';
import 'package:task_app/features/tasks/data/datasource/task_local_data_source.dart';
import 'package:task_app/features/tasks/data/repository/task_repository_impl.dart';
import 'package:task_app/features/tasks/domain/repository/task_repository.dart';
import 'package:task_app/features/tasks/domain/usecases/add_task.dart';
import 'package:task_app/features/tasks/domain/usecases/delete_task.dart';
import 'package:task_app/features/tasks/domain/usecases/load_tasks.dart';
import 'package:task_app/features/tasks/domain/usecases/toggle_task.dart';
import 'package:task_app/features/tasks/presentation/bloc/task_bloc.dart';

final getIt = GetIt.instance;

void setupDependencies() {
  // Core
  getIt.registerLazySingleton<HiveService>(() => HiveService());

  // Data source
  getIt.registerLazySingleton<TaskLocalDataSource>(
    () => TaskLocalDataSource(getIt()),
  );

  // Repository
  getIt.registerLazySingleton<TaskRepository>(
    () => TaskRepositoryImpl(getIt()),
  );

  // Use cases
  getIt.registerLazySingleton(() => LoadTasks(getIt()));
  getIt.registerLazySingleton(() => AddTask(getIt()));
  getIt.registerLazySingleton(() => ToggleTask(getIt()));
  getIt.registerLazySingleton(() => DeleteTask(getIt()));

  // Bloc
  getIt.registerFactory(
    () => TaskBloc(
      loadTasks: getIt(),
      addTask: getIt(),
      toggleTask: getIt(),
      deleteTask: getIt(),
    ),
  );

  getIt.registerLazySingleton(() => ThemeStorage(Hive.box('tasks')));

  getIt.registerLazySingleton(() => ThemeCubit(getIt<ThemeStorage>()));
}
