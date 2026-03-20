import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:horas_compl_app/core/theme/app_theme.dart';
import 'package:horas_compl_app/core/theme/app_colors.dart';

void main() {
  group('AppTheme.light', () {
    final theme = AppTheme.light;

    test('Should use Material3', () {
      expect(theme.useMaterial3, true);
    });

    test('Should have correct colorScheme', () {
      final colorScheme = theme.colorScheme;

      expect(colorScheme.brightness, Brightness.light);
      expect(colorScheme.primary, AppColors.primary);
      expect(colorScheme.secondary, AppColors.secondary);
      expect(colorScheme.error, AppColors.error);
      expect(colorScheme.surface, AppColors.surface);
      expect(colorScheme.onSurface, AppColors.text);
    });

    test('Should have correct scaffold background color', () {
      expect(theme.scaffoldBackgroundColor, theme.colorScheme.surface);
    });

    test('Should have correct AppBarTheme', () {
      final appBarTheme = theme.appBarTheme;

      expect(appBarTheme.backgroundColor, theme.colorScheme.primary);
      expect(appBarTheme.foregroundColor, theme.colorScheme.onPrimary);
      expect(appBarTheme.elevation, 5);
      expect(appBarTheme.centerTitle, true);
    });

    test('Should have correct FloatingActionButton theme', () {
      final fabTheme = theme.floatingActionButtonTheme;

      expect(fabTheme.backgroundColor, theme.colorScheme.primary);
    });
  });
}
