import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/date_utils.dart';
import '../bloc/task_bloc.dart';
import '../bloc/task_event.dart';
import '../bloc/task_state.dart';

class MonthDayStrip extends StatelessWidget {
  const MonthDayStrip({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskBloc, TaskState>(
      builder: (context, state) {
        final scheme = Theme.of(context).colorScheme;
        final today = DateTime.now();

        return Column(
          children: [
            // -------- Month header --------
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.chevron_left),
                    onPressed: () {
                      context.read<TaskBloc>().add(MonthChanged(-1));
                    },
                  ),
                  Text(
                    monthLabel(state.focusedMonth),
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  IconButton(
                    icon: const Icon(Icons.chevron_right),
                    onPressed: () {
                      context.read<TaskBloc>().add(MonthChanged(1));
                    },
                  ),
                ],
              ),
            ),

            // -------- Days strip --------
            SizedBox(
              height: 80,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: state.monthDays.length,
                itemBuilder: (_, index) {
                  final day = state.monthDays[index];
                  final isSelected = isSameDay(day, state.selectedDate);
                  final isToday = isSameDay(day, today);

                  return GestureDetector(
                    onTap: () {
                      context.read<TaskBloc>().add(DateSelected(day));
                    },
                    child: Container(
                      width: 56,
                      margin: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: isSelected ? scheme.primary : scheme.surface,
                        borderRadius: BorderRadius.circular(12),
                        border: isToday && !isSelected
                            ? Border.all(color: scheme.primary, width: 2)
                            : null,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        day.day.toString(),
                        style: TextStyle(
                          color: isSelected
                              ? scheme.onPrimary
                              : scheme.onSurface,
                          fontWeight: isToday
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
