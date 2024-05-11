import 'package:flutter/material.dart';
import 'package:minimal_weather/Theme/dark_mode.dart';
import 'package:minimal_weather/Theme/light_mode.dart';
import 'package:minimal_weather/Theme/theme_provider.dart';
import 'package:minimal_weather/home..dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<ThemeProvider>(
        create: (_) => ThemeProvider(),
      )
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightMode,
      darkTheme: darkMode,
      home: const Home(),
    );
  }
}
