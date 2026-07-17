import 'package:attendance_frontend/core/utils/shared_prefs_provider.dart';
import 'package:attendance_frontend/features/auth/presentation/provider/auth_provider.dart';
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
    // Memantau status penentuan rute awal secara reaktif
    final initialRouteAsync = ref.watch(initialRouteProvider);

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)),
      routes: AppRoutes.routes, // Daftarkan rute aplikasi kamu di sini
      debugShowCheckedModeBanner: false,
      
      // Jadikan properti 'home' dinamis berdasarkan status loading data
      home: initialRouteAsync.when(
        data: (initialRoute) {
          // Ambil fungsi builder dari map rute berdasarkan string rute yang didapat
          final routeBuilder = AppRoutes.routes[initialRoute];
          
          if (routeBuilder != null) {
            return routeBuilder(context);
          }
          
          // Fallback jika rute tidak ditemukan di AppRoutes.routes
          return const Scaffold(
            body: Center(
              child: Text('Halaman tidak ditemukan'),
            ),
          );
        },
        // Tampilan splash screen/loading saat membaca SharedPreferences
        loading: () => const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        ),
        // Penanganan jika terjadi error
        error: (err, stack) => const Scaffold(
          body: Center(
            child: Text('Terjadi kesalahan saat memuat data aplikasi'),
          ),
        ),
      ),
    );
  }
}