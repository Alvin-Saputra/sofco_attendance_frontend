import 'package:attendance_frontend/features/attendance/presentation/providers/check_attendance_state.dart';
import 'package:attendance_frontend/features/attendance/presentation/providers/result_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:attendance_frontend/core/utils/api_result.dart';
import 'package:attendance_frontend/features/attendance/domain/usecases/fetch_attendance_use_case.dart';
import 'package:attendance_frontend/features/attendance/presentation/providers/fetch_attendance_state.dart';
// Import provider usecase yang kita buat di atas
import 'package:attendance_frontend/features/attendance/presentation/providers/attendance_provider.dart'; 

// 1. Beralih mengekstensi kelas Notifier bawaan Riverpod secara manual
class CheckAttendanceNotifier extends Notifier<CheckAttendanceState> {

  // Wajib definisikan state awal di sini
  @override
  CheckAttendanceState build() {
    return CheckAttendanceState();
  }

  Future<void> checkAttendance(String date) async {
    

    state = state.copyWith(state: ResultState.loading);

    final useCase = ref.read(checkAttendanceUseCaseProvider);
    final result = await useCase.execute(date);

    switch (result) {
      case Success():
      
          state = state.copyWith(
            state: ResultState.success,
            isAttended: result.data.data.attended,
          );
        
      case Error():
        state = state.copyWith(
          state: ResultState.error,
          message: result.message,
        );
    }
  }
}

// 2. Daftarkan NotifierProvider-nya secara manual agar bisa dikonsumsi oleh UI
final checkAttendanceNotifierProvider = NotifierProvider<CheckAttendanceNotifier, CheckAttendanceState>(() {
  return CheckAttendanceNotifier();
});