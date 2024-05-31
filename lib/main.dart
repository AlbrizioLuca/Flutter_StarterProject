import 'package:flutter/material.dart';
import 'package:flutter_starter/app.dart';
import 'package:flutter_starter/services/auth_service.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthService()),
      ],
      child: App(),
    ),
  );
}
