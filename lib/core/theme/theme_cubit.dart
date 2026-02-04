import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../storage/theme_storage.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  final ThemeStorage storage;

  ThemeCubit(this.storage) : super(storage.loadTheme());

  void toggleTheme() {
    final newMode = state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;

    emit(newMode);
    storage.saveTheme(newMode);
  }
}
