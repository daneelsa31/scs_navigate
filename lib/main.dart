import 'package:flutter/material.dart';
import 'screens/main_page.dart';

void main() {
  runApp(const ScsNavigateApp());
}

class ScsNavigateApp extends StatelessWidget {
  const ScsNavigateApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SCS NAVIGATE',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFFFFCFD),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFF55D95),
          primary: const Color(0xFFF55D95),
          surface: Colors.white,
        ),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Color(0xFF0F172A)),
        ),
      ),
      home: const MainPage(),
    );
  }
}