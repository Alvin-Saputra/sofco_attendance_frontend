import 'package:attendance_frontend/features/attendance/domain/entities/attendance.dart';
import 'package:attendance_frontend/features/attendance/presentation/providers/result_state.dart';

class CheckAttendanceState {
  final ResultState state;
  final String message;
  final bool? isAttended;

  CheckAttendanceState({
    this.state = ResultState.initial,
    this.message = '',
    this.isAttended,
  });

  CheckAttendanceState copyWith({
    ResultState? state,
    String? message,
    bool? isAttended,
  }) {
    return CheckAttendanceState(
      state: state ?? this.state,
      message: message ?? this.message,
      isAttended: isAttended ?? this.isAttended,
    );
  }
}
