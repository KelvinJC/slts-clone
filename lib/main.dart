import 'package:background_fetch/background_fetch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:slts_enforcer_app/core/local_storage/local_storage.dart';
import 'injection.dart';
import 'ui/routes.dart';
import 'features/sync/presentation/providers/sync_service.dart';
import 'ui/themes/app_colors.dart';
import 'ui/themes/app_text_theme.dart';

/// Headless entry point for background_fetch.
///
/// We need our own ProviderContainer so we can read
/// Riverpod providers outside of the widget tree.
void _onBackgroundFetch(String taskId) async {
  final container = ProviderContainer(
    // only needed if you have test/dev overrides
    overrides: AppModule.overrides,
  );

  try {
    // Trigger your sync use‑case
    await container.read(syncOfflineDataProvider)();
  } catch (e) {
    print('[BackgroundFetch] sync error: $e');
  } finally {
    BackgroundFetch.finish(taskId);
    container.dispose(); // clean up
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 1) Load env variables
  await dotenv.load(fileName: ".env");

  // 2) Initialize secure storage / Hive etc.
  await LocalStorage.instance.init();

  // 3) Register headless handler before runApp
  BackgroundFetch.registerHeadlessTask(_onBackgroundFetch);

  // 4) Start your app
  runApp(
    ProviderScope(
      // no overrides needed if injection.dart uses real providers
      overrides: AppModule.overrides,
      child: const MyApp(),
    ),
  );

  // 5) Configure the periodic fetch
  BackgroundFetch.configure(
        BackgroundFetchConfig(
          minimumFetchInterval: 15,
          stopOnTerminate: false,
          enableHeadless: true,
          requiresBatteryNotLow: false,
          requiresCharging: false,
          requiresStorageNotLow: false,
          requiresDeviceIdle: false,
          requiredNetworkType: NetworkType.ANY,
        ),
        _onBackgroundFetch,
        (String taskId) {
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
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'SLTS Enforcer',
      theme: ThemeData(
        colorScheme: ColorScheme.light(primary: AppColors.primary),
        textTheme: AppTextTheme.light,
      ),
      routes: appRoutes,
      initialRoute: '/',
    );
  }
}
