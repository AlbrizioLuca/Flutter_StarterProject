// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_starter/app.dart';

class SwitchMode extends StatefulWidget {
  const SwitchMode({super.key});

  @override
  State<SwitchMode> createState() => _SwitchModeState();
}

class _SwitchModeState extends State<SwitchMode> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        if (App.of(context).getThemeMode() == ThemeMode.light) {
          App.of(context).updateTheme(ThemeMode.dark);
        } else {
          App.of(context).updateTheme(ThemeMode.light);
        }
      },
      child: Icon(_getValue()),
    );
  }

  IconData _getValue() {
    IconData? value;
    ThemeMode mode = App.of(context).getThemeMode();
    if (mode == ThemeMode.light) {
      value = Icons.dark_mode_outlined;
    } else {
      value = Icons.light_mode_outlined;
    }
    return value;
  }
}
