import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_app/core/theme/app_theme.dart';
import 'package:task_app/core/theme/theme_cubit.dart';
import 'package:task_app/features/tasks/tasks_feature.dart';
import 'package:task_app/injection.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ThemeCubit>(),
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, mode) {
          return MaterialApp(
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            themeMode: mode,
            debugShowCheckedModeBanner: false,
            home: const TasksFeature(), // ❗ NOT TaskPage
          );
        },
      ),
    );
  }
}
