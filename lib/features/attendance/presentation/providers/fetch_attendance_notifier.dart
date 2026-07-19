import 'package:attendance_frontend/features/attendance/presentation/providers/result_state.dart';
import 'package:attendance_frontend/features/auth/presentation/provider/auth_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:attendance_frontend/core/utils/api_result.dart';
import 'package:attendance_frontend/features/attendance/domain/usecases/fetch_attendance_use_case.dart';
import 'package:attendance_frontend/features/attendance/presentation/providers/fetch_attendance_state.dart';
// Import provider usecase yang kita buat di atas
import 'package:attendance_frontend/features/attendance/presentation/providers/attendance_provider.dart'; 

// 1. Beralih mengekstensi kelas Notifier bawaan Riverpod secara manual
class FetchAttendanceNotifier extends Notifier<FetchAttendanceState> {

  // Wajib definisikan state awal di sini
  @override
  FetchAttendanceState build() {
    return FetchAttendanceState();
  }

  Future<void> fetchAttendance() async {
    

    state = state.copyWith(state: ResultState.loading);

    final useCase = ref.read(fetchAttendanceUseCaseProvider);
    final result = await useCase.execute();

    switch (result) {
      case Success():
        if (result.data.items.isEmpty) {
          state = state.copyWith(
            state: ResultState.empty,
            message: 'Tidak ada data attendance yang ditemukan.',
          );
        } else {
          state = state.copyWith(
            state: ResultState.success,
            attendanceList: result.data.items, 
          );
        }
      case Error():
      if (result.statusCode == 401) {
          ref.read(authNotifierProvider.notifier).logout();
        }
        state = state.copyWith(
          state: ResultState.error,
          message: result.message,
        );
    }
  }
}

// 2. Daftarkan NotifierProvider-nya secara manual agar bisa dikonsumsi oleh UI
final fetchAttendanceNotifierProvider = NotifierProvider<FetchAttendanceNotifier, FetchAttendanceState>(() {
  return FetchAttendanceNotifier();
});