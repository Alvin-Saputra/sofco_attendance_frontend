import 'package:attendance_frontend/core/utils/shared_prefs_provider.dart';
import 'package:attendance_frontend/features/auth/presentation/provider/auth_notifier.dart';
import 'package:attendance_frontend/features/auth/presentation/provider/auth_provider.dart';
import 'package:attendance_frontend/features/auth/presentation/provider/auth_state.dart';
import 'package:attendance_frontend/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    
    // final initialRouteAsync = ref.watch(initialRouteProvider);
    final authState = ref.watch(authNotifierProvider);

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)),
      routes: AppRoutes.routes, // Daftarkan rute aplikasi kamu di sini
      debugShowCheckedModeBanner: false,
      
      // Jadikan properti 'home' dinamis berdasarkan status loading data
      home: _getHomeScreen(context,authState.status),
    );
  }
}

Widget _getHomeScreen(BuildContext context, AuthStatus status){
  switch (status){
    case AuthStatus.initial:
      case AuthStatus.loading:
        
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
   case AuthStatus.authenticated:
       return AppRoutes.routes[AppRoutes.home]!(context);

    
  case AuthStatus.unauthenticated:
      case AuthStatus.error:
      default:
      return AppRoutes.routes[AppRoutes.login]!(context);
  }
}