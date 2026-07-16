import 'package:flutter/material.dart';

class AttendanceCard extends StatelessWidget {
  const AttendanceCard({super.key, required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){},
      child: Card(
        elevation: 0,
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: ListTile(
          leading: CircleAvatar(child: Icon(Icons.check_circle, color: Colors.blueAccent ,)),
          title: Text(
            title,
          ),
          subtitle: Text(
            "Time: $subtitle",
          ),
        ),
      ),
    );
  }
}
