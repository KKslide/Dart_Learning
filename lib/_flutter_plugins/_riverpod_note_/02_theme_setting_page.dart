import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_application/providers/02_theme_provider.dart';

@RoutePage()
class ThemeSettingPage extends ConsumerWidget {
  const ThemeSettingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(themeModeProvider);
    print('当前theme: $currentTheme');

    return Scaffold(
      appBar: AppBar(title: Text('fucking enum...')),
      body: ListView(
        children: [
          RadioListTile<AppThemeMode>(
            title: Text('Light'),
            value: AppThemeMode.light,
            groupValue: currentTheme,
            onChanged: (value) =>
                ref.read(themeModeProvider.notifier).setLight(),
          ),
          RadioListTile<AppThemeMode>(
            title: Text('Dark'),
            value: AppThemeMode.dark,
            groupValue: currentTheme,
            onChanged: (value) =>
                ref.read(themeModeProvider.notifier).setDark(),
          ),
          RadioListTile<AppThemeMode>(
            title: Text('System'),
            value: AppThemeMode.system,
            groupValue: currentTheme,
            onChanged: (value) =>
                ref.read(themeModeProvider.notifier).setSystem(),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: ElevatedButton(
              onPressed: () {
                ref.read(themeModeProvider.notifier).toggle();
              },
              child: Text('Quick Switch'),
            ),
          ),
        ],
      ),
    );
  }
}
