import 'package:flutter/material.dart';

class CustomSnackBar {
  String level;
  String message;
  int duration;

  CustomSnackBar(
      {required this.level, required this.message, this.duration = 3});

  Color _getColor() {
    if (level == "error") {
      return Colors.red[300]!;
    }
    if (level == "warning") {
      return Colors.orange[300]!;
    }
    return Colors.green[300]!;
  }

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> display(
      BuildContext context) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: _getColor(),
        duration: const Duration(seconds: 3),
        content: Text(message),
      ),
    );
  }
}
