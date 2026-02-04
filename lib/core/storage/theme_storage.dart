import 'package:hive/hive.dart';
import 'package:flutter/material.dart';

class ThemeStorage {
  static const _key = 'theme_mode';

  final Box box;

  ThemeStorage(this.box);

  ThemeMode loadTheme() {
    final value = box.get(_key);
    if (value == 'dark') return ThemeMode.dark;
    return ThemeMode.light;
  }

  Future<void> saveTheme(ThemeMode mode) async {
    await box.put(_key, mode == ThemeMode.dark ? 'dark' : 'light');
  }
}
