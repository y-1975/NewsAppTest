import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeCubit extends Cubit<ThemeMode> {
 // theme_cubit.dart

  ThemeCubit() : super(ThemeMode.light) {
    _loadTheme();
  }

  void toggleTheme(bool isDark) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', isDark);
    emit(isDark ? ThemeMode.dark : ThemeMode.light);
  }

  void _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final isDark = prefs.getBool('isDarkMode') ?? false;
    emit(isDark ? ThemeMode.dark : ThemeMode.light);
  }


}
