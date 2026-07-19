import 'dart:async';

import 'package:attendance_frontend/core/components/attendance_card.dart';
import 'package:attendance_frontend/core/components/custom_button.dart';
import 'package:attendance_frontend/core/constant/app_colors.dart';
import 'package:attendance_frontend/core/constant/app_text_size.dart';
import 'package:attendance_frontend/core/utils/date_parser.dart';
import 'package:attendance_frontend/core/utils/time_parser.dart';
import 'package:attendance_frontend/features/attendance/presentation/providers/attendance_provider.dart';
import 'package:attendance_frontend/features/attendance/presentation/providers/check_attendance_notifier.dart';
import 'package:attendance_frontend/features/attendance/presentation/providers/fetch_attendance_notifier.dart';
import 'package:attendance_frontend/features/attendance/presentation/providers/result_state.dart';
import 'package:attendance_frontend/features/attendance/presentation/screens/attendance_detail_screen.dart';
import 'package:attendance_frontend/features/auth/presentation/provider/auth_notifier.dart';
import 'package:attendance_frontend/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  late Timer _timer;
  DateTime _currentTime = DateTime.now();

  @override
  void initState() {
    super.initState();

    // 1. Panggil API/State cukup SATU KALI saat halaman diinisialisasi
    WidgetsBinding.instance.addPostFrameCallback((_) {
      String _current = DateParser.dateToString(
        DateTime.now(),
        pattern: "yyyy-MM-dd",
      );
      ref
          .read(checkAttendanceNotifierProvider.notifier)
          .checkAttendance(_current);
      ref.read(fetchAttendanceNotifierProvider.notifier).fetchAttendance();
    });

    // 2. Timer HANYA digunakan untuk memperbarui UI jam lokal setiap detiknya
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _currentTime = DateTime.now();
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authNotifierProvider);
    final checkAttendanceState = ref.watch(checkAttendanceNotifierProvider);
    final attendanceState = ref.watch(fetchAttendanceNotifierProvider);
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Hello",
              style: TextStyle(
                fontSize: AppTextSize.textSm,
                color: AppColors.quarternary,
              ),
            ),

            Text(
              "${authState.user?.username}",
              style: const TextStyle(
                fontSize: AppTextSize.textXl,
                color: AppColors.tertiary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout_rounded, color: AppColors.danger),
            tooltip: 'Logout',
            onPressed: () async {
              final confirmLogout = await showDialog<bool>(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Konfirmasi'),
                  content: const Text(
                    'Apakah Anda yakin ingin keluar dari aplikasi?',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: const Text('Batal'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context, true),
                      child: const Text(
                        'Keluar',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ],
                ),
              );
              if (confirmLogout == true) {
                await ref.read(authNotifierProvider.notifier).logout();

                if (context.mounted) {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    AppRoutes.login,
                    (route) => false,
                  );
                }
              }
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "${DateParser.dateToString(_currentTime, pattern: 'HH:mm:ss')}",
                    style: const TextStyle(
                      color: AppColors.tertiary,
                      fontSize: AppTextSize.heading,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                  Text(
                    "${DateParser.dateToString(DateTime.now(), pattern: 'EEEE, dd MMMM yyyy')}",
                    style: TextStyle(
                      color: AppColors.quarternary,
                      fontSize: AppTextSize.textSm,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
              ),

              const SizedBox(height: 24),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.teal.shade200, width: 1),
                ),
                child: Row(
                  children: [
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Status Hari Ini',
                            style: TextStyle(
                              color: AppColors.quarternary,
                              fontSize: AppTextSize.textSm,
                            ),
                          ),
                          const SizedBox(height: 4),

                          Container(
                            child: switch (checkAttendanceState.state) {
                              ResultState.initial || ResultState.loading =>
                                const CircularProgressIndicator(),

                              ResultState.success => Text(
                                checkAttendanceState.isAttended == true
                                    ? 'Sudah Absen Masuk'
                                    : 'Belum Absen Masuk',
                                style: const TextStyle(
                                  color: AppColors.tertiary,
                                  fontSize: AppTextSize.textXl,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              ResultState.empty => const Text(
                                'Data Tidak Ditemukan',
                                style: TextStyle(
                                  color: AppColors.tertiary,
                                  fontSize: AppTextSize.textXl,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              ResultState.error => Text(
                                'Gagal memuat status: ${checkAttendanceState.message}',
                                style: const TextStyle(
                                  color: AppColors.danger,
                                  fontSize: AppTextSize.textXl,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            },
                          ),

                          SizedBox(height: 24.0),
                          CustomButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                AppRoutes.attendanceRecord,
                              );
                            },

                            isDisable: checkAttendanceState.isAttended ?? true,
                            childWidget: Text(
                              "Absen Sekarang",
                              style: TextStyle(
                                fontSize: AppTextSize.textLg,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Aktivitas Terakhir',
                    style: TextStyle(
                      color: AppColors.tertiary,
                      fontSize: AppTextSize.textBase,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoutes.attendanceHistory);
                    },
                    child: Text(
                      'Lihat Semua',
                      style: TextStyle(
                        color: AppColors.secondary,
                        fontSize: AppTextSize.textXs,
                      ),
                    ),
                  ),
                ],
              ),

              switch (attendanceState.state) {
                ResultState.loading => Center(
                  child: CircularProgressIndicator(),
                ),

                ResultState.success => ListView.builder(
                  shrinkWrap: true,
                  itemCount: attendanceState.attendanceList.length >= 3
                      ? 3
                      : attendanceState.attendanceList.length,
                  itemBuilder: (context, index) {
                    return AttendanceCard(
                      title: DateParser.dateToString(
                        attendanceState.attendanceList[index].date,
                        pattern: 'dd MMM yyyy',
                      ),
                      subtitle: TimeParser.timeOfDaytoString(
                        attendanceState.attendanceList[index].time,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AttendanceDetailScreen(
                              attendanceItem:
                                  attendanceState.attendanceList[index],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),

                ResultState.empty => SizedBox(
                  height: 200,
                  child: Center(
                    child: Text(
                      "No Attendance Data",
                      style: TextStyle(
                        fontSize: AppTextSize.textLg,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                ResultState.error => SizedBox(
                  height:200,
                  child: Center(
                    child: Text(
                      attendanceState.message,
                      style: TextStyle(
                        fontSize: AppTextSize.textLg,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                ResultState.initial => SizedBox(
                  height: 200,
                  child: Center(
                    child: Center(
                      child: Text(
                        "No Attendance Data",
                        style: TextStyle(
                          fontSize: AppTextSize.textLg,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              },
            ],
          ),
        ),
      ),
    );
  }
}
