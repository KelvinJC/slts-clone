import 'package:background_fetch/background_fetch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:slts_enforcer_app/core/local_storage/local_storage.dart';
import 'package:slts_enforcer_app/features/auth/presentation/screens/login_screen.dart';
import 'injection.dart';
import 'features/sync/presentation/providers/sync_service.dart';

/// This is called when a background fetch event fires.
void _onBackgroundFetch(String taskId) async {
  // Create a fresh ProviderContainer so we can read our sync use‑case
  final container = ProviderContainer(overrides: AppModule.overrides);
  try {
    // Call your sync use‑case to upload cached violations
    await container.read(syncOfflineDataProvider)();
  } catch (e) {
    // Handle/log errors as you see fit
    print('[BackgroundFetch] sync error: $e');
  }
  // IMPORTANT: signal completion of your task to OS
  BackgroundFetch.finish(taskId);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorage.instance.init();
  runApp(ProviderScope(overrides: AppModule.overrides, child: const MyApp()));

  // Configure Background Fetch
  BackgroundFetch.configure(
        BackgroundFetchConfig(
          minimumFetchInterval: 15, // minutes
          stopOnTerminate: false, // keep running after app terminate
          enableHeadless: true,
          requiresBatteryNotLow: false,
          requiresCharging: false,
          requiresStorageNotLow: false,
          requiresDeviceIdle: false,
          requiredNetworkType: NetworkType.ANY,
        ),
        _onBackgroundFetch,
        // Optional timeout callback
        (String taskId) async {
          print("[BackgroundFetch] TIMEOUT task: $taskId");
          BackgroundFetch.finish(taskId);
        },
      )
      .then((int status) {
        print('[BackgroundFetch] configured (status: $status)');
      })
      .catchError((e) {
        print('[BackgroundFetch] configure ERROR: $e');
      });

  // Register headless task (Android)
  BackgroundFetch.registerHeadlessTask(_onBackgroundFetch);
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'SLTS Enforcer',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const LoginScreen(),
    );
  }
}
