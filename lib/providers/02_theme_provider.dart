import 'package:riverpod_annotation/riverpod_annotation.dart';

part '02_theme_provider.g.dart';

enum AppThemeMode { light, dark, system }

@riverpod
class ThemeMode extends _$ThemeMode {
  @override
  AppThemeMode build() {
    return AppThemeMode.system;
  }
  void setLight() => state = AppThemeMode.light;
  void setDark() => state = AppThemeMode.dark;
  void setSystem() => state = AppThemeMode.system;

  void toggle() {
    state = state == AppThemeMode.light
      ? AppThemeMode.dark
      : AppThemeMode.light;
  }
}
