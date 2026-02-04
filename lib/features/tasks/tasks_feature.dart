import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../injection.dart';
import 'presentation/bloc/task_bloc.dart';
import 'presentation/pages/task_page.dart';

class TasksFeature extends StatelessWidget {
  const TasksFeature({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TaskBloc>(
      create: (_) => getIt<TaskBloc>(),
      child: const TaskPage(),
    );
  }
}
