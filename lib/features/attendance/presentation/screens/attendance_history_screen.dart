import 'package:attendance_frontend/features/attendance/presentation/providers/attendance_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AttendanceHistoryScreen extends ConsumerStatefulWidget {
  const AttendanceHistoryScreen({super.key});

  @override
  ConsumerState<AttendanceHistoryScreen> createState() =>
      _AttendanceHistoryScreenState();
}

// 2. Ubah State menjadi ConsumerState
class _AttendanceHistoryScreenState extends ConsumerState<AttendanceHistoryScreen> {
  @override
  void initState() {
    super.initState(); 
    
    ref.read(attendanceNotifierProvider.notifier).fetchAttendance();
  }

  @override
  Widget build(BuildContext context) {
    final attendanceState = ref.watch(attendanceNotifierProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Attendance History")),
      body: Center(
        child: Text("Status Data: ${attendanceState.state.name}"),
      ),
    );
  }
}