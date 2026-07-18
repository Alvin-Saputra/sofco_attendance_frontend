import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  const Button({super.key, required this.onPressed, required this.text, this.isDisable = false});

  final Function() onPressed;
  final String text;
  final bool isDisable;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: (isDisable)?null:onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: (isDisable)?Colors.grey:Colors.blue,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            8.0,
          ), // Ubah angka ini sesuai kebutuhan
        ),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(
            text,
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
