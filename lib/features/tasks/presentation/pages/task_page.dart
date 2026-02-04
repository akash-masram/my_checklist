import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_app/core/theme/theme_cubit.dart';
import 'package:task_app/features/tasks/presentation/widgets/month_day_strip.dart';

import '../../../../core/utils/date_utils.dart';
import '../bloc/task_bloc.dart';
import '../bloc/task_event.dart';
import '../bloc/task_state.dart';

class TaskPage extends StatelessWidget {
  const TaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('My CheckList'),
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_6),
            onPressed: () {
              context.read<ThemeCubit>().toggleTheme();
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addTask(context),
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),
          const MonthDayStrip(),
          const Divider(),
          Expanded(
            child: BlocBuilder<TaskBloc, TaskState>(
              builder: (context, state) {
                final key = dateKey(state.selectedDate);
                final tasks = state.tasks[key] ?? [];

                if (tasks.isEmpty) {
                  return Center(
                    child: Text(
                      'No tasks for this date',
                      style: textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onSurface,
                      ),
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (_, index) {
                    final task = tasks[index];

                    return ListTile(
                      leading: Checkbox(
                        value: task.completed,
                        onChanged: (_) {
                          context.read<TaskBloc>().add(TaskToggled(task.id));
                        },
                      ),
                      title: Text(
                        task.title,
                        style: textTheme.bodyLarge?.copyWith(
                          color: colorScheme.onSurface,
                          decoration: task.completed
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                        ),
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.delete, color: colorScheme.onSurface),
                        onPressed: () {
                          context.read<TaskBloc>().add(TaskDeleted(task.id));
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _addTask(BuildContext context) {
    final controller = TextEditingController();
    final colorScheme = Theme.of(context).colorScheme;

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Add Task'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(hintText: 'Task title'),
        ),
        actions: [
          TextButton(
            onPressed: () {
              if (controller.text.trim().isNotEmpty) {
                context.read<TaskBloc>().add(TaskAdded(controller.text.trim()));
              }
              Navigator.pop(context);
              // ❌ DO NOT dispose controller here
            },
            style: TextButton.styleFrom(foregroundColor: colorScheme.primary),
            child: const Text('ADD'),
          ),
        ],
      ),
    );
  }
}
