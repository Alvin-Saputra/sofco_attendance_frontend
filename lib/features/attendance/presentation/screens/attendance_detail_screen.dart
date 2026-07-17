import 'package:attendance_frontend/core/utils/date_parser.dart';
import 'package:attendance_frontend/core/utils/time_parser.dart';
import 'package:attendance_frontend/features/attendance/domain/entities/attendance.dart';
import 'package:attendance_frontend/features/auth/presentation/provider/auth_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AttendanceDetailScreen extends ConsumerStatefulWidget {
  final Attendance attendanceItem;
  const AttendanceDetailScreen({super.key, required this.attendanceItem});

  @override
  ConsumerState<AttendanceDetailScreen> createState() =>
      _AttendanceDetailScreenState();
}

class _AttendanceDetailScreenState
    extends ConsumerState<AttendanceDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authNotifierProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Repository'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    Container(
                      height: 400,
                      width: 200,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        image: DecorationImage(
                          image: NetworkImage(widget.attendanceItem.photoUrl),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),

                    const SizedBox(height: 32),
                    Text(
                      (authState.user?.username).toString(),
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 32),

                    Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildStatItem(
                          icon: Icons.calendar_today,
                          iconColor: Colors.blue,
                          value: DateParser.dateToString(widget.attendanceItem.date, pattern: 'dd MMM yyyy'),
                          label: "Attendance Date",
                        ),
                        _buildStatItem(
                          icon: Icons.access_time,
                          iconColor: Colors.blue,
                          value: TimeParser.timeOfDaytoString(widget.attendanceItem.time),
                          label: "Attendance Time",
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 36),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildStatItem({
  required IconData icon,
  required Color iconColor,
  required String value,
  required String label,
}) {
  return Column(
    children: [
      Icon(icon, color: iconColor, size: 28),
      const SizedBox(height: 8),
      Text(
        value,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
      const SizedBox(height: 4),
      Text(label, style: TextStyle(fontSize: 13, color: Colors.grey.shade600)),
    ],
  );
}
