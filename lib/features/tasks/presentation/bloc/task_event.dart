abstract class TaskEvent {}

class DateSelected extends TaskEvent {
  final DateTime date;
  DateSelected(this.date);
}

class TaskAdded extends TaskEvent {
  final String title;
  TaskAdded(this.title);
}

class TaskToggled extends TaskEvent {
  final String id;
  TaskToggled(this.id);
}

class TaskDeleted extends TaskEvent {
  final String id;
  TaskDeleted(this.id);
}

class MonthChanged extends TaskEvent {
  final int offset; // -1 = prev, +1 = next
  MonthChanged(this.offset);
}
