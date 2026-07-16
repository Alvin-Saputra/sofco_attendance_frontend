import 'package:flutter/material.dart';

class Attendance {
  final int id;
  final int userId;
  final DateTime date;
  final TimeOfDay time;

  const Attendance({
    required this.id,
    required this.userId,
    required this.date,
    required this.time,
  });
}
