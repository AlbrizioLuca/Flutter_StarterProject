// ignore_for_file: library_private_types_in_public_api
import 'package:flutter/material.dart';
import 'package:flutter_starter/screens/login_page.dart';
import 'package:flutter_starter/services/auth_service.dart';
import 'package:flutter_starter/shared/custom_page_layout.dart';
import 'package:provider/provider.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();

  static _AppState of(BuildContext context) =>
      context.findAncestorStateOfType<_AppState>()!;
}

class _AppState extends State<App> {
  ThemeMode _themeMode = ThemeMode.system;

  void updateTheme(ThemeMode theme) {
    setState(() {
      _themeMode = theme;
    });
  }

  ThemeMode getThemeMode() {
    return _themeMode;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Facil'Paper",
      themeMode: _themeMode,
      theme: ThemeData(
        scaffoldBackgroundColor: Color.fromARGB(255, 255, 255, 255),
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color.fromRGBO(147, 184, 1, 1),
          primary: Colors.blue,
          secondary: Color.fromRGBO(10, 128, 155, 1),
        ),
        textTheme: TextTheme(
          bodyMedium: TextStyle(
            color: Color.fromRGBO(34, 34, 34, 1),
            fontSize: 16,
          ),
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        colorScheme: ColorScheme.dark(),
        textTheme: TextTheme(
          bodyMedium: TextStyle(
            color: Color.fromRGBO(239, 235, 230, 1),
            fontSize: 16,
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: Consumer<AuthService>(builder: (context, auth, child) {
        return auth.isLoggedIn == true ? CustomPageLayout() : LoginPage();
      }),
    );
  }
}
