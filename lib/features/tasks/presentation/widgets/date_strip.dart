// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:intl/intl.dart';

// import '../../../../core/utils/date_utils.dart';
// import '../bloc/task_bloc.dart';
// import '../bloc/task_event.dart';
// import '../bloc/task_state.dart';

// class DateStrip extends StatelessWidget {
//   const DateStrip({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<TaskBloc, TaskState>(
//       builder: (context, state) {
//         return SizedBox(
//           height: 90,
//           child: ListView.separated(
//             scrollDirection: Axis.horizontal,
//             padding: const EdgeInsets.symmetric(horizontal: 16),
//             itemCount: state.dates.length,
//             separatorBuilder: (_, _) => const SizedBox(width: 12),
//             itemBuilder: (_, index) {
//               final date = state.dates[index];
//               final selected = isSameDay(date, state.selectedDate);

//               return GestureDetector(
//                 onTap: () {
//                   context.read<TaskBloc>().add(DateSelected(date));
//                 },
//                 child: Container(
//                   width: 64,
//                   decoration: BoxDecoration(
//                     color: selected ? Colors.blue : Colors.grey.shade200,
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(
//                         DateFormat('EEE').format(date),
//                         style: TextStyle(
//                           color: selected ? Colors.white : Colors.black54,
//                         ),
//                       ),
//                       const SizedBox(height: 4),
//                       Text(
//                         date.day.toString(),
//                         style: TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                           color: selected ? Colors.white : Colors.black,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           ),
//         );
//       },
//     );
//   }
// }
