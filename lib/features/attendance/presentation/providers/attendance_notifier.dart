import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:attendance_frontend/core/utils/api_result.dart';
import 'package:attendance_frontend/features/attendance/domain/usecases/fetch_attendance_use_case.dart';
import 'package:attendance_frontend/features/attendance/presentation/providers/attendance_state.dart';
// Import provider usecase yang kita buat di atas
import 'package:attendance_frontend/features/attendance/presentation/providers/attendance_provider.dart'; 

// 1. Beralih mengekstensi kelas Notifier bawaan Riverpod secara manual
class AttendanceNotifier extends Notifier<AttendanceState> {

  // Wajib definisikan state awal di sini
  @override
  AttendanceState build() {
    return AttendanceState();
  }

  Future<void> fetchAttendance() async {
    const harcodedUserId = 3;

    state = state.copyWith(state: ResultState.loading);

    final useCase = ref.watch(fetchAttendanceUseCaseProvider);
    final result = await useCase.execute(harcodedUserId);

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
        state = state.copyWith(
          state: ResultState.error,
          message: result.message,
        );
    }
  }
}

// 2. Daftarkan NotifierProvider-nya secara manual agar bisa dikonsumsi oleh UI
final attendanceNotifierProvider = NotifierProvider<AttendanceNotifier, AttendanceState>(() {
  return AttendanceNotifier();
});