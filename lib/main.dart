import 'package:attendance_frontend/core/utils/shared_prefs_provider.dart';
import 'package:attendance_frontend/features/auth/presentation/provider/auth_notifier.dart';
import 'package:attendance_frontend/features/auth/presentation/provider/auth_provider.dart';
import 'package:attendance_frontend/features/auth/presentation/provider/auth_state.dart';
import 'package:attendance_frontend/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  runApp(
    ProviderScope(
      overrides: [sharedPreferencesProvider.overrideWithValue(prefs)],
      child: const MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    ref.listen<AuthState>(authNotifierProvider, (previous, next) {
      if (next.status == AuthStatus.unauthenticated) {
        navigatorKey.currentState?.pushNamedAndRemoveUntil(AppRoutes.login, (route) => false);
      } 
      else if (next.status == AuthStatus.authenticated && previous?.status != AuthStatus.authenticated) {
        navigatorKey.currentState?.pushNamedAndRemoveUntil(AppRoutes.home, (route) => false);
      }
    });
    
    // // final initialRouteAsync = ref.watch(initialRouteProvider);
    // final authState = ref.watch(authNotifierProvider);

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue)),
      routes: AppRoutes.routes, // Daftarkan rute aplikasi kamu di sini
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey, 
      home: Scaffold(body: Center(child: LinearProgressIndicator(),))
    );
  }
}

