import 'package:attendance_frontend/core/utils/date_parser.dart';
import 'package:attendance_frontend/core/utils/time_parser.dart';
import 'package:attendance_frontend/features/attendance/presentation/providers/attendance_notifier.dart';
import 'package:attendance_frontend/features/attendance/presentation/providers/attendance_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AttendanceHistoryScreen extends ConsumerStatefulWidget {
  const AttendanceHistoryScreen({super.key});

  @override
  ConsumerState<AttendanceHistoryScreen> createState() =>
      _AttendanceHistoryScreenState();
}

// 2. Ubah State menjadi ConsumerState
class _AttendanceHistoryScreenState
    extends ConsumerState<AttendanceHistoryScreen> {
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
      body: _buildBodyContent(attendanceState),
    );
  }

  Widget _buildBodyContent(AttendanceState attendanceState) {
    switch (attendanceState.state) {
      case ResultState.loading:
        return Center(child: CircularProgressIndicator());
      
      case ResultState.success:
        return ListView.builder(
          itemCount: attendanceState.attendanceList.length,
          itemBuilder: (context, index) {
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: ListTile(
                leading: CircleAvatar(child: Icon(Icons.av_timer_sharp)),
                title: Text(
                  DateParser.dateTimeToString(
                    attendanceState.attendanceList[index].date,
                  ),
                ),
                subtitle: Text(
                  "Time: ${TimeParser.timeOfDaytoString(attendanceState.attendanceList[index].time)}",
                ),
              ),
            );
          },
        );

      case ResultState.empty:
        return Center(child: Text("No Attendance Data"));

      case ResultState.error:
        return Center(
          child: Column(
            children: [
              Text(attendanceState.message),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  ref
                      .read(attendanceNotifierProvider.notifier)
                      .fetchAttendance();
                },
                child: Text("Retry"),
              ),
            ],
          ),
        );

      case ResultState.initial:
      default:
        return Center(child: Text("No Attendance Data"));
    }
  }
}
