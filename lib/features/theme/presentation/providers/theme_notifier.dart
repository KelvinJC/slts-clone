import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:slts_enforcer_app/core/local_storage/local_storage.dart';
import 'package:slts_enforcer_app/injection.dart';

/// The keys we use in secure storage.
const _themeKey = 'theme_mode';

/// Holds & persists the current ThemeMode.
class ThemeNotifier extends StateNotifier<ThemeMode> {
  final LocalStorage _storage;
  ThemeNotifier(this._storage) : super(ThemeMode.system) {
    _loadFromStorage();
  }

  /// Load saved theme or default to system.
  Future<void> _loadFromStorage() async {
    final saved = await _storage.read(_themeKey);
    if (saved == 'light') {
      state = ThemeMode.light;
    } else if (saved == 'dark') {
      state = ThemeMode.dark;
    } else {
      state = ThemeMode.system;
    }
  }

  /// Change theme and persist.
  Future<void> setThemeMode(ThemeMode mode) async {
    state = mode;
    final str = mode == ThemeMode.light
        ? 'light'
        : mode == ThemeMode.dark
        ? 'dark'
        : 'system';
    await _storage.write(_themeKey, str);
  }
}

/// Riverpod provider for theme
final themeNotifierProvider = StateNotifierProvider<ThemeNotifier, ThemeMode>((
  ref,
) {
  final storage = ref.watch(localStorageProvider);
  return ThemeNotifier(storage);
});

// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../../theme/presentation/providers/theme_notifier.dart';

// class SettingsScreen extends ConsumerWidget {
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final mode = ref.watch(themeNotifierProvider);
//     final notifier = ref.read(themeNotifierProvider.notifier);

//     return Scaffold(
//       appBar: AppBar(title: const Text('Settings')),
//       body: ListView(
//         children: [
//           SwitchListTile(
//             title: const Text('Use Dark Mode'),
//             subtitle: const Text('Toggle light/dark theme'),
//             value: mode == ThemeMode.dark,
//             onChanged: (on) {
//               notifier.setThemeMode(on ? ThemeMode.dark : ThemeMode.light);
//             },
//           ),
//           ListTile(
//             title: const Text('Follow System Theme'),
//             leading: Radio<ThemeMode>(
//               value: ThemeMode.system,
//               groupValue: mode,
//               onChanged: (val) => notifier.setThemeMode(val!),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
